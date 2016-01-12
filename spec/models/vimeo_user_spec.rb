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

    it "must have a unique uri" do
        vimeo_user
        same_vimeo_user = VimeoUser.new(uri: "/users/2543732", name: "audrey",description: "I love licorice", location: "Seattle, WA", videos_uri: "/users/1111111/videos", profile_images_uri: "/users/1111111/pictures")
        expect(same_vimeo_user.save).to eq false
        expect(same_vimeo_user.errors.keys).to include :uri
    end
  end
end
