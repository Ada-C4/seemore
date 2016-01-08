require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  before(:each) do
    Subscription.create(
      username: "Schwarzenegger", uid: "12044602" , provider: "twitter", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg"
      )

    Subscription.create(
      username: "Schwarzenegger", uid: "12044602" , provider: "vimeo", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg"
      )
  end


  let(:user) { User.new(
  email:    "a@b.com",
  username: "Ada",
  uid:      "1234",
  provider: "twitter")
  }


  describe "validations" do

    it "is valid" do
      expect(user).to be_valid
    end

    it "does not require an email" do
      user.email = nil
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
