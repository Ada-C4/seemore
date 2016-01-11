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

  let(:user) do
    { User.new(
    email:    "a@b.com",
    username: "Ada",
    uid:      "1234",
    provider: "twitter")
  }

  let(:session) do
    {
      user_id: 1
    }
  end

  it "renders the twitter_search_user view" do
    user
    session
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

    it "subscribes to a new subscription" do
      expect { post :twitter_subscribe, params }.to change(Subscription, :count).by(1)
      expect(subject).to redirect_to root_path
    end

    it "creates new stories" do
      expect { post :twitter_subscribe, params }.to change(Story, :count).by(20)
      expect(subject).to redirect_to root_path
    end
end
end
