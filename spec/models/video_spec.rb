require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video) { Video.new(
    title:      "Cool video",
    uri: "/videos/102805992")
  }

  describe "model validations" do
    it "is valid" do
      expect(video).to be_valid
    end

    it "requires a title" do
      video.title = nil
      expect(video).to be_invalid
    end

    it "requires a uri" do
      video.uri = nil
      expect(video).to be_invalid
    end
  end
end
