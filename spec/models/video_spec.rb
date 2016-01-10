require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video) { Video.new(
    twitter_id:      "12345678",
    text: "This is a video",
    uri: "https://twitter.com/kdefliese/status/684970660116873216")
  }

  describe "model validations" do
    it "is valid" do
      expect(video).to be_valid
    end

    it "requires a title" do
      video.twitter_id = nil
      expect(video).to be_invalid
    end

    it "requires a text field" do
      video.text = nil
      expect(video).to be_invalid
    end

    it "requires a uri" do
      video.uri = nil
      expect(video).to be_invalid
    end
  end
end
