require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    context "when using developer authentication" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:developer] }

        it "redirects to the home page" do
          get :create, provider: :developer
          expect(response).to redirect_to root_path
        end

        it "creates a spy" do
          expect { get :create, provider: :developer }.to change(Spy, :count).by(1)
        end

        it "doesn't create a new spy if spy already exists" do
          Spy.create(uid: "123545", provider: "developer", username: "Brittany")
          expect { get :create, provider: :developer }.to change(Spy, :count).by(0)
        end

        it "assigns the session[:spy_id]" do
          get :create, provider: :developer
          expect(session[:spy_id]).to eq assigns(:spy).id
        end
      end
    end
  end
end
