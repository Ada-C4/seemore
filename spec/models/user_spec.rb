require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(
    uid:      "123",
    provider: "twitter",
    name: "Beagle",
    image: "http://wiki.hydrogenaud.io/images/2/2a/Beagle_50x50.gif")
  }

  let(:bad_user) { User.new(
    uid:      "123",
    provider: "twitter",
    name: "Beagle",
    image: "http://wiki.hydrogenaud.io/images/2/2a/Beagle_50x50.gif")
  }

  let(:good_user) { User.new(
    uid:      "234",
    provider: "twitter",
    name: "Beagle",
    image: "http://wiki.hydrogenaud.io/images/2/2a/Beagle_50x50.gif")
  }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a name" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end

    it "requires a unique uid" do
      user.save
      expect(bad_user.save).to be false
      expect(good_user.save).to be true
    end

    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end

    it "does not require an image" do
      user.image = nil
      expect(user).to be_valid
    end
  end

  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end

end
