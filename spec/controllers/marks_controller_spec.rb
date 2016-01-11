require 'rails_helper'

RSpec.describe MarksController, type: :controller do
    let(:new_spy) { build(:spy) }

  describe "GET #search" do
    context "logged in" do
      context "twitter" do
        it "renders the search template" do
          new_spy.save
          session[:spy_id] = new_spy.id
          get :search, provider: "twitter", username: "loganmeetsworld"
          expect(response).to render_template :search
        end
      end

      context "vimeo" do
        it "renders the search page" do
          new_spy.save
          session[:spy_id] = new_spy.id
          get :search, provider: "vimeo", username: "loganmeetsworld"
          expect(response).to render_template :search
        end
      end
    end

    context "not logged in" do
      context "twitter" do
        it "redirects to the home page" do
          get :search, provider: "twitter"
          expect(response).to redirect_to root_path
        end

        it "adds a flash error" do
          get :search, provider: "twitter"
          expect(flash[:error]).to_not be nil
        end
      end

      context "vimeo" do
        it "redirects to the home page" do
          get :search, provider: "vimeo"
          expect(response).to redirect_to root_path
        end

        it "adds a flash error" do
          get :search, provider: "vimeo"
          expect(flash[:error]).to_not be nil
        end
      end
    end
  end

  describe "GET #index" do
    it "renders the index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #vimeo_subscribe" do
    it "redirects to the marks index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :vimeo_subscribe, name: "hi"
      expect(response).to redirect_to marks_path
    end

    it "creates a new mark" do
      new_spy.save
      session[:spy_id] = new_spy.id
      expect{ post :vimeo_subscribe, name: "hi" }.to change(Mark, :count).by(1)
    end
  end

  describe "POST #twitter_subscribe" do
    it "redirects to the marks index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :twitter_subscribe, name: "hi"
      expect(response).to redirect_to marks_path
    end

    it "creates a new mark" do
      new_spy.save
      session[:spy_id] = new_spy.id
      expect{ post :twitter_subscribe, name: "hi" }.to change(Mark, :count).by(1)
    end
  end
end
