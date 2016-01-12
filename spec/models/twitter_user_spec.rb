require 'rails_helper'

RSpec.describe TwitterUser, type: :model do
  let(:twitter_user) { TwitterUser.create(
    twitter_id:      "12345678",
    screen_name: "kdefliese",
    name: "Katherine Defliese",
    description: "I really like cats",
    location: "Seattle, WA",
    uri: "https://twitter.com/kdefliese",
    profile_image_uri: "http://pbs.twimg.com/profile_images/672319002706706432/_MQlTm-A_normal.jpg")
  }

  describe "model validations" do
    it "is valid" do
      expect(twitter_user).to be_valid
    end

    it "requires a twitter_id" do
      twitter_user.twitter_id = nil
      expect(twitter_user).to be_invalid
    end

    it "must have a unique twitter_id" do
        twitter_user
        same_twitter_user = TwitterUser.new(twitter_id: "12345678", screen_name: "kdefliese", name: "Katherine Defliese", uri: "https://twitter.com/kdefliese")
        expect(same_twitter_user.save).to eq false
        expect(same_twitter_user.errors.keys).to include :twitter_id
    end

    it "requires a screen_name" do
      twitter_user.screen_name = nil
      expect(twitter_user).to be_invalid
    end

    it "requires a uri" do
      twitter_user.uri = nil
      expect(twitter_user).to be_invalid
    end
  end

end
