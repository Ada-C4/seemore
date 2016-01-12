require 'rails_helper'
require 'spec_helper'

RSpec.describe CreatorsController, type: :controller do

  describe "GET #index" do
    context "when using Twitter authorization" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
        let!(:twitter_user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

        before :each do
          session[:user_id] = twitter_user.id
        end

        it "redirects to home page" do
          get :index
          expect(response).to render_template :index
        end

        # it "shows creators that the user is following" do
        #   get :index
        # end
    end
  end


  # describe "GET #create" do
  #   context "when using Twitter authorization" do
  #       it "assigns the @current_user var" do
  #         get :create, provider: :twitter
  #         expect(assigns(:current_user)).to be_an_instance_of Creator
  #       end
        #
        # it "assigns the session[:user_id]" do
        #   get :create, provider: :github
        #   expect(session[:user_id]).to eq assigns(:user).id
  #   end
  # end


  describe "add_videos"  do

  end

  describe "add_tweets" do

  end
end
