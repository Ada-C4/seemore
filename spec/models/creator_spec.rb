require 'rails_helper'

RSpec.describe Creator, type: :model do
  it { is_expected.to validate_presence_of(:p_id) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:username) }

  describe "has_image?" do
    context "creator is from twitter" do
      let(:creator) { build(:twitter_creator) }
      it "returns true when creator object has image" do
        creator.avatar_url = "abc"
        expect(creator.has_image?).to be true
      end
      it "returns false when creator object has no image" do
        expect(creator.has_image?).to be false
      end
    end
    context "creator is from vimeo" do
      let(:creator) { build(:vimeo_creator) }
      it "returns true when creator object has image" do
        creator.avatar_url = "abc"
        expect(creator.has_image?).to be true
      end
      it "returns false when creator object has no image" do
        expect(creator.has_image?).to be false
      end
    end
  end

  describe "get_content" do
    context "creator is from twitter" do
      let(:twitter_creator){ create(:twitter_creator) }
      it "saves content from twitter to Content database" do
        count = twitter_creator.content.count
        expect(twitter_creator.get_content).to be true
        expect(twitter_creator.content.count).to_not be count
      end
    end
    context "creator is from vimeo" do
      let(:vimeo_creator) { create(:vimeo_creator) }
      it "saves content from vimeo to Content database" do
        count = vimeo_creator.content.count
        expect(vimeo_creator.get_content).to be true
        expect(vimeo_creator.content.count).to_not be count
      end
    end
    context "creator is not recognized" do
      let(:invalid_creator) { build(:vimeo_creator, provider: "random") }
      it "raises an error" do
        expect{invalid_creator.get_content}.to raise_error(RuntimeError, "Content provider provided is not recognized (vimeo, twitter).")
      end
    end
  end
end
