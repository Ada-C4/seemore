require 'rails_helper'

RSpec.describe MarksController, type: :controller do
  describe "GET #search" do
    context "twitter" do
      it "renders the search template" do
        get :search, provider: "twitter", username: "loganmeetsworld"
        expect(response).to render_template :search
      end
    end
    context "vimeo" do
      it "renders the search page" do
        get :search, provider: "vimeo", username: "loganmeetsworld"
        expect(response).to render_template :search
      end
    end
  end

  describe "GET #index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end
  end
end
