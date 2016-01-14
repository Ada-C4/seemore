require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET 'show'" do
    it "renders the show view" do
      get :show
      expect(subject).to render_template :show
    end

    let!(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }
    let(:subscription) {Subscription.create(
            username: "Schwarzenegger", uid: "12044602" , provider: "twitter", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg"
            )}
    let(:subscription_2) {Subscription.create(
            username: "Poodle", uid: "4943031" , provider: "vimeo", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg"
            )}

    let(:subscription_3) {Subscription.create(
            username: "schwarzenegger", uid: "198945880" , provider: "instagram", avatar_url: "https://scontent-sea1-1.cdninstagram.com/hphotos-xta1/t51.2885-19/11373921_1614186788830308_1200274240_a.jpg"
            )}
    let(:story) {Story.create(uid: 1, text: "blah", subscription_id: 1, post_time: Time.now)}
    let(:story) {Story.create(uid: 2, text: "blah", subscription_id: 2, post_time: Time.now)}
    let(:story) {Story.create(uid: 3, text: "blah", subscription_id: 3, post_time: Time.now)}


    it "pulls content for a logged in user" do
      session[:user_id] = user.id
      user.subscriptions << subscription
      user.subscriptions << subscription_2
      user.subscriptions << subscription_3

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

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the twitter_search view" do
      session[:user_id] = 1
      get :twitter_search, params
      expect(response).to render_template :twitter_search
    end

    it "doesn't render the twitter_search view if you are not logged in" do
      get :twitter_search, params
      expect(response).to redirect_to root_path
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

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the vimeo_search view" do
      session[:user_id] = user.id
      get :vimeo_search, params
      expect(response).to render_template :vimeo_search
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

    let!(:user) do
      User.create(
      email:    "a@b.com",
      username: "Ada",
      uid:      "1234",
      provider: "twitter")
    end

    it "renders the instagram_search view" do
      session[:user_id] = 1
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

  describe "POST 'instagram_subscribe'" do
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
