require 'rails_helper'

RSpec.describe TwitterUsersController, type: :controller do
  let(:twitter_user_hash) do {
      twitter_id:      "12345678",
      screen_name: "kdefliese",
      name: "Katherine Defliese",
      description: "I really like cats",
      location: "Seattle, WA",
      uri: "https://twitter.com/kdefliese",
      profile_image_uri: "http://pbs.twimg.com/profile_images/672319002706706432/_MQlTm-A_normal.jpg"
      }
  end

  let(:good_params) do  {
    screen_name: "kdefliese"
  }
  end

  let(:bad_twitter_user_hash) do {
    twitter_id:      "",
    screen_name: "",
    name: "",
    description: "",
    location: "",
    uri: "",
    profile_image_uri: ""
    }
  end

  let(:bad_params) do  {
    screen_name: "kdefliese"
  }
  end

  let(:user) do
    User.create(uid:"1234",provider:"developer",name:"Test")
  end


  describe "PATCH 'subscribe'" do
    before(:each) do
      session[:user_id] = user.id
    end
    
    it "successfully creates a new TwitterUser if the TwitterUser does not exist" do
      patch :subscribe, good_params
      expect(TwitterUser.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    # it "does not create a new TwitterUser if the TwitterUser already exists" do
    #   existing_TwitterUser = TwitterUser.create()
    #   patch :subscribe, good_params
    #   expect(TwitterUser.all.length).to eq 1
    #   expect(response.status).to eq 200
    #   expect(subject).to redirect_to :root
    # end

    # it "will not create a new TwitterUser with bad params" do
    #   post :create, bad_params
    #   expect(TwitterUser.all.length).to eq 0
    #   expect(response.status).to eq 200
    #   expect(subject).to render_template :search_results
    # end

    it "associates a TwitterUser with a User" do
      patch :subscribe, good_params
      expect(@current_user.twitter_users).to include(@twitter_user)
      expect(subject).to redirect_to :root
    end

  end

end
