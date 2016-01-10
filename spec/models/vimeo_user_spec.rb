require 'rails_helper'

RSpec.describe VimeoUser, type: :model do
  let(:vimeo_user) { VimeoUser.new(
    name: "Kutay Cengil",
    description: "Hi there",
    location: "Los Angeles, CA",
    uri: "/users/2543732",
    profile_images_uri: "/users/2543732/pictures/4897997",
    videos_uri: "/users/2543732/videos"
  )}

  describe "model validations" do
    it "is valid" do
      expect(vimeo_user).to be_valid
    end

    it "requires a name" do
      vimeo_user.name = nil
      expect(vimeo_user).to be_invalid
    end

    it "requires a uri" do
      vimeo_user.uri = nil
      expect(vimeo_user).to be_invalid
    end
  end
end
