require 'rails_helper'

RSpec.describe SessionsController, type: :controller  do
  describe "GET #create" do
    context "when using provider authorization" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:prov] }

        it "redirects to welcome page" do
          get :create, provider: :prov
          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :prov }.to change(User, :count).by(1)
        end

        it "assigns the @user var" do
          get :create, provider: :prov
          expect(assigns(:user)).to be_an_instance_of User
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :prov
          expect(session[:user_id]).to eq assigns(:user).id
        end
      end

      context "when the user has already signed up" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:prov] }
        let!(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:prov]) }

        it "doesn't create another user" do
          expect { get :create, provider: :prov }.to change(User, :count).by(0)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :prov
          expect(session[:user_id]).to eq user.id
        end
      end

      context "fails from provider" do
        before { request.env["omniauth.auth"] = :invalid_credential }

        it "redirect to welcome with flash error" do
          get :create, provider: :prov
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to authenticate"
        end
      end

      context "when failing to save the user" do
        before {
          request.env["omniauth.auth"] = {"uid" => {}, "info" => {}}
        }

        it "redirect to welcome with flash error" do
          get :create, provider: :prov
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to save the user"
        end
      end
    end
  end
end
