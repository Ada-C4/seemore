require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:user1) { create(:user1) }
  let(:handle) { create(:twitter_handle) }
  let(:medium) { create(:twitter_medium) }

  before(:each) do
    session[:user_id] = user1.id
  end

  describe "#index" do
    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "#filter" do
    context "when not following any handles of that filter" do
      it "redirects to root path" do
        get :filter, filter: "twitter"
        expect(response).to redirect_to root_path
      end
    end
    context "when following handles of that filter" do
      it "renders index view" do
        handle.media << medium
        user1.handles << handle
        get :filter, filter: "twitter"
        expect(response).to render_template :index
      end
    end
  end
end
