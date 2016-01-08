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
    twitter_user: {
    screen_name: "kdefliese"
    }
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
    twitter_user: {
    screen_name: "kdefliese"
    }
  }
  end

  describe "POST 'create'" do

    it "successfully creates a new TwitterUser" do
      post :create, good_params
      expect(TwitterUser.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    # it "will not create a new TwitterUser with bad params" do
    #   post :create, bad_params
    #   expect(TwitterUser.all.length).to eq 0
    #   expect(response.status).to eq 200
    #   expect(subject).to render_template :search_results
    # end

  end

end
