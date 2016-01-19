require 'rails_helper'

RSpec.describe Identity, type: :model do
  let(:user_identity) { build(:identity) }

  let (:omniauth_identity) {
    Identity.create_with_omniauth(OmniAuth.config.mock_auth[:twitter])
  }

  describe "validations" do
    it "is valid" do
      expect(user_identity).to be_valid
    end

    it "requires a uid" do
      user_identity.uid = nil
      expect(user_identity).to be_invalid
    end

    it "requires a provider" do
      user_identity.provider = nil
      expect(user_identity).to be_invalid
    end
  end

  describe ".find_with_omniauth" do
    it "returns the identity if one exists" do
      omniauth_identity.update(user: create(:user1))
      user_identity = Identity.find_with_omniauth( { "uid" => omniauth_identity.uid,  "provider" => omniauth_identity.provider} )
      expect(user_identity).to_not be_nil
    end

    context "when it's invalid" do
      it "returns nil" do
        user_identity = Identity.find_with_omniauth( { "uid" => "123", "provider" => "twitter" } )
        expect(user_identity).to be_nil
      end
    end
  end

  describe ".create_with_omniauth" do
    it "creates a valid identity" do
      omniauth_identity.update(user: create(:user1))
      expect(omniauth_identity).to be_valid
    end
  end
end
