require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
  let(:user) { create(:developer_user) }
  let(:creator) { create(:twitter_creator) }

  describe "GET #show" do
    it "renders the show view" do
      get :show, {id: user.id}, user_id: user.id
      expect(subject).to render_template :show
    end
    it "assigns current user's creators as @creators" do
      user.creators << creator
      creators = user.creators
      get :show, {id: user.id}, user_id: user.id
      expect(assigns(:creators)).to eq creators
    end
  end

  describe "GET #feed" do
    context "user is logged in" do
      let (:params) do
        {p_id: "154915030",
        username: "stillkidrauhl",
        avatar_url: "avatar_url.com",
        provider: "twitter",
        id: user.id}
      end
      it "renders feed template" do
        get :feed, {id: user.id}, user_id: user.id
        expect(subject).to render_template :feed
      end
    end
  end

  describe "PATCH #update" do
    context "creator does not exist" do
      let (:params) do
        {p_id: "154915030",
        username: "stillkidrauhl",
        avatar_url: "avatar_url.com",
        provider: "twitter",
        id: user.id}
      end
      # test needs to have user logged in for a creator to be created or assigned
      it "makes a new creator" do
        @count = user.creators.all.count
        # session[:user_id] = user.id
        patch :update, params, user_id: user.id
        expect(user.creators.all.count).to eq(@count + 1)
      end
      it "gets the content for the new creator" do
        patch :update, params, user_id: user.id
        expect(Creator.last.content[0]).is_a?(Content)
      end
    end
  end

  describe "GET #delete_creator" do
    context "creator is no longer followed" do
      let (:params) do
        {p_id: "154915030",
        username: "stillkidrauhl",
        avatar_url: "avatar_url.com",
        provider: "twitter",
        id: user.id}
      end
      before :each do
        patch :update, params, user_id: user.id
      end
      it "deletes the creator" do
        @count = user.creators.all.count
        get :delete_creator, params, user_id: user.id
        expect(user.creators.all.count).to eq(@count - 1)
      end
    end
  end
end
