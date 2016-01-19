require 'rails_helper'

RSpec.describe HandlesController, type: :controller do
  let(:user1) { create(:user1) }

  before(:each) do
   session[:user_id] = user1.id
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "#subscribe" do
    let(:twitter_params) do
      { "provider" => "twitter", "handle_uri" => "https://twitter.com/sferik", "handle_username" => "houglande" }
    end

    let(:vimeo_params) do
      { "provider" => "vimeo", "handle_uri" => "/users/253450" }
    end

    context "when handle does not yet exist in our database" do
      context "when provider is twitter" do
        it "creates a new handle with twitter as provider and 5 associated media" do
          VCR.use_cassette('api_responses', :record => :new_episodes) do
            post :subscribe, twitter_params
            expect(Handle.all.last.provider).to eq "twitter"
            expect(Medium.all.length).to eq 5
            expect(Handle.all.last.media).to eq Medium.all
          end
        end
      end
    end

    context "when provider is vimeo" do
      it "creates a new handle with vimeo as provider and 5 associated media" do
        VCR.use_cassette('api_responses', :record => :new_episodes) do
          post :subscribe, vimeo_params
          expect(Handle.all.last.provider).to eq "vimeo"
          expect(Medium.all.length).to eq 5
          expect(Handle.all.last.media).to eq Medium.all
        end
      end
    end

    context "when user has already subscribed to handle" do
      it "redirects to last page" do
        user1.handles << create(:twitter_handle)
        post :subscribe, twitter_params
        expect(subject).to redirect_to "where_i_came_from"
      end
    end
  end

  describe "#unsubscribe" do
    before(:each) do
      user1.handles << create(:twitter_handle)
      user1.handles << create(:vimeo_handle)
    end

    it "removes handle from user's handles array" do
      put :unsubscribe, { handle_uri: "https://twitter.com/sferik" }
      expect(User.all.last.handles.length).to eq 1
    end

    context "when there are no longer any users subscribing to the handle" do
      it "removes handle from our application's database" do
        put :unsubscribe, { handle_uri: "https://twitter.com/sferik" }
        expect(Handle.find_by_uri("https://twitter.com/sferik")).to eq nil
      end
    end

    it "redirects to settings page" do
      put :unsubscribe, { handle_uri: "https://twitter.com/sferik" }
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "#search" do
    it "returns vimeo user objects whose name matches the name query" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        get :search, { query: "Johnny Kelly" }
        expect(assigns(:vimeo_search_results).length).to eq 9
        expect(assigns(:vimeo_search_results)[0]).to be_an_instance_of Vimeo::User
      end
    end

    context "if the current user is subscribed to corresponding vimeo handle" do
      it "assigns the vimeo object's subscribe attritube to true" do
        VCR.use_cassette('api_responses', :record => :new_episodes) do
          vimeo_handle = create(:vimeo_handle)
          user1.handles << vimeo_handle
          get :search, { query: "Johnny Kelly" }

          expect(assigns(:vimeo_search_results)[0].subscribed).to eq true
        end
      end
    end

    it "returns twitter user objects whose name matches the name query " do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        get :search, { query: "Hello ClubW" }
        expect(assigns(:twitter_search_results).length).to eq 1
        expect(assigns(:twitter_search_results)[0]).to be_an_instance_of Twitter::User
      end
    end
  end
end
