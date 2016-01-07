require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:tweet) { Tweet.new(
    twitter_id:      "12345678",
    text: "This is a tweet",
    uri: "https://twitter.com/kdefliese/status/684970660116873216")
  }

  describe "model validations" do
    it "is valid" do
      expect(tweet).to be_valid
    end

    it "requires a twitter_id" do
      tweet.twitter_id = nil
      expect(tweet).to be_invalid
    end

    it "requires a text field" do
      tweet.text = nil
      expect(tweet).to be_invalid
    end

    it "requires a uri" do
      tweet.uri = nil
      expect(tweet).to be_invalid
    end
  end
end
