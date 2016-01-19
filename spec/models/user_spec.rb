require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user1) }

  let(:twitter_handle) { build(:twitter_handle) }

  let(:vimeo_handle) { build(:vimeo_handle) }

  let(:twitter_medium) { build(:twitter_medium) }

  let(:vimeo_medium) { build(:vimeo_medium) }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a name" do
      user.name = nil
      expect(user).to be_invalid
    end
  end

  describe ".create_with_omniauth" do
    it "creates a valid user" do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:vimeo]["info"])
      expect(user).to be_valid
    end
  end

  describe "#find_vimeo_handles" do
    it "returns an array" do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:vimeo]["info"])
      user.handles << vimeo_handle
      expect(user.find_vimeo_handles).to be_kind_of(Array)
      expect(user.find_vimeo_handles.length).to eq 1
    end
  end

  describe "#find_twitter_handles" do
    it "returns an array" do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:vimeo]["info"])
      user.handles << twitter_handle
      expect(user.find_twitter_handles).to be_kind_of(Array)
      expect(user.find_twitter_handles.length).to eq 1
    end
  end

  describe "#merge_user_accounts" do
    it "descreases length of User model by 1" do
      vimeo_user = User.create_with_omniauth(OmniAuth.config.mock_auth[:vimeo]["info"])
      twitter_user = User.create_with_omniauth(OmniAuth.config.mock_auth[:twitter]["info"])
      expect { vimeo_user.merge_user_accounts(twitter_user) }.to change(User, :count).by(-1)
    end
  end
end
