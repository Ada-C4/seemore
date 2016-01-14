require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  before :each do
      build(:twitter_user)
      build(:tweet)
      build(:vimeo_user)
      build(:video)
  end

  describe "GET #index" do
    it "renders welcome index when there is a current user" do
      get :index
      expect(subject).to render_template :index
    end

    it "redirects to login route when there is no current user" do
      session[:id] = nil
      get :index
      expect(subject).to redirect_to login_path
    end

    it "generates a feed for the user" do
      get :index
      expect(@feed)
    end

  end

  describe "make_feed" do
    it ""
  end


end
