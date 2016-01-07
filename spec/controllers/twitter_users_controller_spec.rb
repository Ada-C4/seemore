require 'rails_helper'

RSpec.describe TwitterUsersController, type: :controller do
  let(:good_params) do {
      twitter_user: {
      twitter_id:      "12345678",
      screen_name: "kdefliese",
      name: "Katherine Defliese",
      description: "I really like cats",
      location: "Seattle, WA",
      uri: "https://twitter.com/kdefliese",
      profile_image_uri: "http://pbs.twimg.com/profile_images/672319002706706432/_MQlTm-A_normal.jpg"
      }
    }
  end

  let(:bad_params) do {
    twitter_user: {
    twitter_id:      "",
    screen_name: "kdefliese",
    name: "",
    description: "",
    location: "",
    uri: "https://twitter.com/kdefliese",
    profile_image_uri: ""
    }
  }
  end

  describe "POST 'create'" do
    it "successfully creates a new TwitterUser" do
      post :create, good_params
      expect(TwitterUser.all.length).to eq 1
      expect(response.status).to eq 302
    end

    it "will not create a new TwitterUser with bad params" do
      post :create, bad_params
      expect(TwitterUser.all.length).to eq 0
      expect(response.status).to eq 200
    end
  end

end
