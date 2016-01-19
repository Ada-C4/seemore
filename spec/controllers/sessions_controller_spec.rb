require 'rails_helper'
require 'pry'

RSpec.describe SessionsController, type: :controller  do
  let(:twit_handle) { create(:twitter_handle) }
  let(:vim_handle) { create(:vimeo_handle) }

  describe "GET #create" do
    context "when using twitter authorization" do
      context "user was already logged in" do
        context "user tries to log in with same provider" do
          before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
          it "redirects to home page" do
            get :create, provider: :twitter
            get :create, provider: :twitter
            expect(response).to redirect_to root_path
          end
        end
        context "user links with a second provider" do
          before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
          it "redirects to home page" do
            get :create, provider: :twitter
            request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vimeo]
            get :create, provider: :vimeo
            expect(response).to redirect_to root_path
          end
        end
      end
      context "user wasn't logged in" do
        context "is logging in with a previously used identity" do
          before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
          it "redirects to home page" do
            get :create, provider: :twitter
            delete :destroy
            get :create, provider: :twitter
            expect(response).to redirect_to root_path
          end
        end
        context "is logging in with a new identity" do
          before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
          it "increases user count by 1" do
            expect { get :create, provider: :twitter }.to change(User, :count).by(1)
          end
          it "redirects to home page" do
            get :create, provider: :twitter
            expect(response).to redirect_to root_path
          end
        end
      end
      context "user is logging in and has handles" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
        it "redirects to root_path" do
          get :create
          User.last.handles << twit_handle
          User.last.handles << vim_handle
          delete :destroy

          VCR.use_cassette('api_responses', :record => :new_episodes) do
            get :create
            expect(response).to redirect_to root_path
          end
        end
      end
    end
  end
  describe "DELETE #destroy" do
    context "user logs out" do
      it "redirects to home page" do
        delete :destroy
        expect(subject).to redirect_to root_path
      end
    end
  end
end
