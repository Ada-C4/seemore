require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:tweet) { Tweet.new(
    twitter_id:      "12345678",
    text: "This is a tweet",
    uri: "https://twitter.com/kdefliese/status/684970660116873216",
    provider_created_at: "Mon, 21 Dec 2015 17:13:59 +0000",
    embed: "<blockquote class=\"twitter-tweet\"><p lang=\"en\" dir=\"ltr\"><a href=\"https://twitter.com/Elia_MG\">@Elia_MG</a> Can you share with me the link to your capstone project?</p>&mdash; Rebecca Tolmach (@BeccaTmac) <a href=\"https://twitter.com/BeccaTmac/status/678986784529870848\">December 21, 2015</a></blockquote>\n<script async src=\"//platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>"
    )
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

    it "requires a provider_created_at" do
      tweet.provider_created_at = nil
      expect(tweet).to be_invalid
    end

    it "requires embed html" do
      tweet.embed = nil
      expect(tweet).to be_invalid
    end
  end
end
