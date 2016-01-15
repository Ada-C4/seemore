require 'rails_helper'
require 'pry'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do
    context "logs in with Twitter" do
      context "when it is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]}
        it "redirects to feed path" do
          get :create, provider: :twitter
          expect(subject).to redirect_to feed_path
        end
        it "creates a user" do
          expect {get :create, provider: :twitter}.to change(User, :count).by(1)
        end
        it "assigns the @user variable" do
          get :create, provider: :twitter
          expect(assigns(:user)).to be_an_instance_of(User)
        end
        it "assigns session[:user_id]" do
          get :create, provider: :twitter
          expect(session[:user_id]).to eq assigns(:user).id
        end
      end
      context "when user has signed up before" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]}
        let!(:user) {User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter])}
        it "doesn't create another user" do
          expect {get :create, provider: :twitter}.to change(User, :count).by(0)
        end
        it "assigns the session[:user_id]" do
          get :create, provider: :twitter
          expect(session[:user_id]).to eq user.id
        end
        it "assigns the @user variable" do
          get :create, provider: :twitter
          expect(assigns(:user)).to be_an_instance_of(User)
        end
      end
      context "it fails to save the user" do
        before { request.env["omniauth.auth"] = {"uid" => "not correct", "info" => {}}}
        it "redirect to root path" do
          get :create, provider: :twitter
          expect(response).to redirect_to root_path
        end
        it "returns flash notice to include 'Failed to save the user'" do
          get :create, provider: :twitter
          expect(flash[:notice]).to include "Failed to save the user"
        end
      end
      context "it fails on twitter" do
        before { request.env["omniauth.auth"] = "bad login"}
        it "redirect to root path" do
          get :create, provider: :twitter
          expect(response).to redirect_to root_path
        end
        it "returns flash notice to include 'Failed to authenticate'" do
          get :create, provider: :twitter
          expect(flash[:notice]).to include "Failed to authenticate"
        end
      end
    end

    context "logs in with Vimeo" do
      context "when it is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]}
        it "redirects to feed path" do
          get :create, provider: :vimeo
          expect(subject).to redirect_to feed_path
        end
        it "creates a user" do
          expect {get :create, provider: :vimeo}.to change(User, :count).by(1)
        end
        it "assigns the @user variable" do
          get :create, provider: :vimeo
          expect(assigns(:user)).to be_an_instance_of(User)
        end
        it "assigns session[:user_id]" do
          get :create, provider: :vimeo
          expect(session[:user_id]).to eq assigns(:user).id
        end
      end
      context "when user has signed up before" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]}
        let!(:user) {User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:vimeo])}
        it "doesn't create another user" do
          expect {get :create, provider: :vimeo}.to change(User, :count).by(0)
        end
        it "assigns the session[:user_id]" do
          get :create, provider: :vimeo
          expect(session[:user_id]).to eq user.id
        end
        it "assigns the @user variable" do
          get :create, provider: :vimeo
          expect(assigns(:user)).to be_an_instance_of(User)
        end
      end
      context "it fails to save the user" do
        before { request.env["omniauth.auth"] = {"uid" => "not correct", "info" => {}}}
        it "redirect to root path" do
          get :create, provider: :vimeo
          expect(response).to redirect_to root_path
        end
        it "returns flash notice to include 'Failed to save the user'" do
          get :create, provider: :vimeo
          expect(flash[:notice]).to include "Failed to save the user"
        end
      end
      context "it fails on vimeo" do
        before { request.env["omniauth.auth"] = "bad login"}
        let(:user) { FactoryGirl.create(:some_user) }
        it "redirect to root path" do
          get :create, provider: :vimeo
          expect(response).to redirect_to root_path
        end
        it "returns flash notice to include 'Failed to authenticate'" do
          get :create, provider: :vimeo
          expect(flash[:notice]).to include "Failed to authenticate"
        end
      end
    end

    describe "DELETE #destroy" do
      before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]}
      let!(:user) {User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:vimeo])}
      before :each do
        session[:user_id] = user.id
      end

        it "redirects to new session path" do
          delete :destroy
          expect(response).to redirect_to new_session_path
        end
        it "the user is not login" do
          delete :destroy
          expect(session[:user_id]).to be_nil
          # expect(:notice).to eq("You've logged out. See you next time.")

        end
    end
  end
end
