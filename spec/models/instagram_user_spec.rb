require 'rails_helper'

RSpec.describe InstagramUser, type: :model do
  let(:instagram_user) { InstagramUser.new(
    instagram_id:      "123",
    screen_name: "zeldapug",
    name: "Zelda",
    description: "Love love love I'm a pug",
    uri: "https://www.instagram.com/dreedles/",
    profile_image_uri: "https://scontent-sea1-1.cdninstagram.com/hphotos-frc/t51.2885-19/10598334_772391902818043_627378339_a.jpg")
  }

  describe "model validations" do
    it "is valid" do
      expect(instagram_user).to be_valid
    end

    it "requires an instagram_id" do
      instagram_user.instagram_id = nil
      expect(instagram_user).to be_invalid
    end

    it "requires a screen_name" do
      instagram_user.screen_name = nil
      expect(instagram_user).to be_invalid
    end

    it "requires a uri" do
      instagram_user.uri = nil
      expect(instagram_user).to be_invalid
    end
  end

end
