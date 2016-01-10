require 'rails_helper'

RSpec.describe VimeoUser, type: :model do
  let(:vimeo_user) { VimeoUser.new(
    name: "Kutay Cengil",
    description: "Hi there",
    location: "Los Angeles, CA",
    uri: "/users/2543732",
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
