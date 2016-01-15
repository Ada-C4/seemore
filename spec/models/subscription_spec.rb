require 'rails_helper'
require 'spec_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { Subscription.new(
  username: "Ada",
  uid:      "1234",
  provider: "twitter")
  }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a username" do
      user.username = nil
      expect(user).to be_invalid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end

    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end
  end

  describe "model methods" do
    let(:subscription) {Subscription.create(
      username: "Schwarzenegger", uid: "12044602", provider: "twitter", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg"
    )}

    it "find_or_create returns an existing subscription if one exists" do
      subscription
      a = Subscription.find_or_create("12044602", "twitter", "Schwarzenegger", "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg")
      expect(a).to eq subscription
    end

    it "find returns an existing subscription if one exists" do
      subscription
      a = Subscription.find("12044602", "twitter")
      expect(a).to eq subscription
    end
  end
end
