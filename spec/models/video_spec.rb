require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video) { Video.new(
    title:      "Cool video",
    uri: "/videos/102805992",
    vimeo_created_at: "Mon, 21 Dec 2015 17:13:59 +0000",
    embed: "<iframe src=\"https://player.vimeo.com/video/150661465?badge=0&autopause=0&player_id=0\" width=\"1920\" height=\"1080\" frameborder=\"0\" title=\"006 Teapot\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>")
  }

  describe "model validations" do
    it "is valid" do
      expect(video).to be_valid
    end

    it "requires a uri" do
      video.uri = nil
      expect(video).to be_invalid
    end

    it "requires a vimeo_created_at" do
      video.vimeo_created_at = nil
      expect(video).to be_invalid
    end

    it "requires embed html" do
      video.embed = nil
      expect(video).to be_invalid
    end
  end
end
