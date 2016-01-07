require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(
    uid:      "123",
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

    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end

    it "does not require an image" do
      user.image = nil
      expect(user).to be_valid
    end

  end

end
