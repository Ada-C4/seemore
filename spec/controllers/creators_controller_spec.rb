require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe CreatorsController, type: :controller do

    describe "GET index" do

      context "User is successfully following a Creator" do
        let(:user) {create(:twitter_user) }

      context "user has followed a creator" do
        let(:category) { create(:category) }
        let(:user) { category.user }
        let(:creator) { category.creator }

        before :each do
          session[:user_id] = user.id
          request.env["HTTP_REFERER"] = "from_where_I_was"
        end

        context "is successful" do
          it "renders creator index page" do
            get :index
            expect(response).to render_template :index
          end

          it "is successful" do
            get :index
            expect(response.status).to eq 200
          end

          it "shows creators that the user is following" do
            get :index
            expect(assigns(:creators)).not_to be_empty
            expect(assigns(:creators)[0]).to be_an_instance_of(Creator)
          end
        end
      end
    end

    describe "POST follow" do

      let(:creator_params) do
        { name: "Edward",
          provider: "twitter",
          bio: "Hello",
          profile_pic: "asdf",
          uid: "fdsfdsfs"
        }
      end

      before :each do
        session[:user_id] = user.id
        request.env["HTTP_REFERER"] = "from_where_I_was"
      end

      context "it finds an existing creator" do
        let(:user) {create(:twitter_user) }
        let (:creator) {create(:twitter_creator) }

        it "follows a creator" do
          get :follow, creator_params
          expect(flash[:notice]).to include "You're now following #{creator.name}."
          expect(subject).to redirect_to "from_where_I_was"
        end
      end
    end
  end

  describe "GET #index" do

    before :each do
      session[:user_id] = user.id
    end

    context "User failed to follow Creator" do
      let(:user) {create(:twitter_user_not_following) }

      it "gives a flash notice" do
        get :index
        expect(response.status).to eq 200
        expect(flash[:notice]).to include "Try following some people first!"
      end
    end
  end

  describe "POST #follow" do

    let(:category_2) { create(:category_2) }
    let(:user_2) { category_2.user }
    let(:creator_2) { category_2.creator }

    before :each do
      session[:user_id] = user_2.id
      request.env["HTTP_REFERER"] = "from_where_I_was"
    end

    context "creator is already followed" do

      let(:creator_params) do
        { name: "Eddie",
          description: "Hola!",
          profile_pic: "www.profilepix.com",
          provider: "twitter",
          uid: "fdsfdas"
        }
      end

      it "gives an error" do
        get :follow, creator_params
        expect(flash[:notice]).to include "You're already following #{creator_2.name}"
        expect(subject).to redirect_to "from_where_I_was"
      end
    end
  end

  describe "POST #unfollow" do

    let(:unfollow_category) { create(:unfollow_category) }
    let(:twitter_user) { unfollow_category.user }
    let(:twitter_creator_to_unfollow) { unfollow_category.creator }

    let(:twitter_creator_to_unfollow_params) do
      { name: "Nancy",
        description: "Hi!",
        profile_pic: "www.profilepix.com",
        provider: "twitter",
        uid: "112233"
      }
    end

    before :each do
      session[:user_id] = twitter_user.id
      request.env["HTTP_REFERER"] = "from_where_I_was"
    end

 # this test could use an actual method to test whether or not relationship got destroyed
    it "deletes the relationship between the user and creator" do
      get :unfollow, twitter_creator_to_unfollow_params
      expect(subject).to redirect_to "from_where_I_was"
    end
  end

end
