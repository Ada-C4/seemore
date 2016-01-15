require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:provider) }

  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:vimeo]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end

    context "when the user has already logged in" do
      it "returns user" do
        user
        user = User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:vimeo])
        expect(user).to be_an_instance_of(User)
      end
    end
  end

  describe "following" do
    let(:user) { create(:developer_user) }
    context "creator does not exist" do
      it "returns nil for creator and false for following" do
        creator, following = user.following("twitter", 1234)
        expect(creator).to be_nil
        expect(following).to be false
      end
    end
    context "creator exists" do
      let!(:twitter_creator) { create(:twitter_creator) }
      context "user not following" do
        it "returns creator and false for following" do
          creator, following = user.following(twitter_creator.provider, twitter_creator.p_id)
          expect(creator).to eq twitter_creator
          expect(following).to be false
        end
      end
      context "user following" do
        it "returns creator and true for following" do
          user.creators << twitter_creator
          creator, following = user.following(twitter_creator.provider, twitter_creator.p_id)
          expect(creator).to eq twitter_creator
          expect(following).to be true
        end
      end
    end
  end
end
