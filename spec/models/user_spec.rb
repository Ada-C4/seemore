require 'rails_helper'

RSpec.describe User, type: :model do

  describe "can be instantiated" do
    it "exists" do
      expect(User.new).not_to be_nil
    end
  end

  describe "twitter oauth" do
    let(:user) { build(:twitter_user) }

    describe "validations" do
      it "is valid" do
        expect(user).to be_valid
      end

      it "requires a username" do
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
    end

    describe ".initialize_from_omniauth" do
      let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

      it "creates a valid user" do
        expect(user).to be_valid
      end

      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_from_omniauth({"uid" => "123", provider: "twitter", "info" => {}})
          expect(user).to be_nil
        end
      end
    end
  end

  describe "vimeo oauth" do
    let(:user) { build(:vimeo_user) }

    describe "validations" do
      it "is valid" do
        expect(user).to be_valid
      end

      it "requires a username" do
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
    end

    describe ".initialize_from_omniauth" do
      context "for a Vimeo user" do
        let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:vimeo]) }

        it "creates a valid user" do
          expect(user).to be_valid
        end

        context "when it's invalid" do
          it "returns nil" do
            user = User.find_or_create_from_omniauth({"uid" => "123", provider: "vimeo", "info" => {}})
            expect(user).to be_nil
          end
        end
      end
    end
  end


  describe ".initialize_from_omniauth" do
    context "for a Twitter user" do
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
end
