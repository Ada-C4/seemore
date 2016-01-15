require 'rails_helper'

RSpec.describe CreatorsController, type: :controller do

  describe "GET#search" do
    let (:vimeo_search_params) {
      { query: "Hello",
        provider: "vimeo" }
    }
    let (:twitter_search_params) {
      { query: "Hello",
        provider: "twitter" }
    }
    let (:invalid_search_params) {
      { query: "" }
    }
    let (:user) { create(:user) }

    context "blank search" do
      it "creates a flash message" do
        get :search, invalid_search_params
        expect(flash["error"]).to_not be_nil
      end

      it "redirects to root_path" do
        get :search, invalid_search_params, user_id: user.id
        expect(subject).to redirect_to root_path
      end
    end

    context "vimeo query" do
      it "redirects to search page" do
        get :search, vimeo_search_params, user_id: user.id
        expect(subject).to render_template :search
      end
    end

    context "twitter query" do
      it "returns an array of Creators from twitter" do
        get :search, twitter_search_params, user_id: user.id
        expect(subject).to render_template :search
      end
    end
  end
end
