require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET 'show'" do
    it "renders the show view" do
      get :show
      expect(subject).to render_template :show
    end
  end

  describe "GET 'twitter_search'" do
    let(:params) do
    {
      search: "justinbieber"
    }
    end

    it "renders the twitter_search view" do
      get :twitter_search, params
      expect(subject).to render_template :twitter_search
    end
  end

  describe "GET 'twitter_search_user'" do
    let(:params) do
      {
        id: "justinbieber"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the twitter_search_user view" do
      session[:user_id] = user.id
      get :twitter_search_user, params
      expect(subject).to render_template :twitter_search_user
    end
  end

  describe "POST 'twitter_subscribe'" do
    let(:params) do
      {
        id: "justinbieber"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "subscribes to a new subscription" do
      session[:user_id] = user.id
      expect { post :twitter_subscribe, params }.to change(Subscription, :count).by(1)
      expect(subject).to redirect_to root_path
    end

    it "creates new stories" do
      session[:user_id] = user.id
      expect { post :twitter_subscribe, params }.to change(Story, :count).by(20)
      expect(subject).to redirect_to root_path
    end
  end

  describe "GET 'vimeo_search'" do
    let(:params) do
    {
      search: "justinbieber"
    }
    end

    it "renders the vimeo_search view" do
      get :vimeo_search, params
      expect(subject).to render_template :vimeo_search
    end
  end

  describe "GET 'vimeo_search_user'" do
    let(:params) do
      {
        id: "4943031"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the vimeo_search_user view" do
      session[:user_id] = user.id
      get :vimeo_search_user, params
      expect(subject).to render_template :vimeo_search_user
    end
  end

  describe "POST 'vimeo_subscribe'" do
    let (:params) do
      {
        id: "4943031"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "vimeo")
    end

    it "subscribes to a new subscription" do
      session[:user_id] = user.id
      expect { post :vimeo_subscribe, params }.to change(Subscription, :count).by(1)
      expect(subject).to redirect_to root_path
    end

    it "creates new stories" do
      session[:user_id] = user.id
      expect { post :vimeo_subscribe, params }.to change(Story, :count).by(25)
      expect(subject).to redirect_to root_path
    end
  end

  describe "GET 'instagram_search'" do
    let(:params) do
    {
      search: "justinbieber"
    }
    end

    it "renders the instagram_search view" do
      get :instagram_search, params
      expect(subject).to render_template :instagram_search
    end
  end

  describe "GET 'instagram_search_user'" do
    let(:params) do
      {
        id: "justinbieber"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the instagram_search_user view" do
      session[:user_id] = user.id
      get :instagram_search_user, params
      expect(subject).to render_template :instagram_search_user
    end
  end

  describe "POST 'twitter_subscribe'" do
    let(:params) do
      {
        id: "justinbieber"
      }
    end

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "subscribes to a new subscription" do
      session[:user_id] = user.id
      expect { post :instagram_subscribe, params }.to change(Subscription, :count).by(1)
      expect(subject).to redirect_to root_path
    end

    it "creates new stories" do
      session[:user_id] = user.id
      expect { post :instagram_subscribe, params }.to change(Story, :count).by(20)
      expect(subject).to redirect_to root_path
    end
  end
end
