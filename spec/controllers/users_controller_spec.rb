require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user1) { create(:user1) }

  let(:identity) { create(:identity) }

  before :each do
    session[:user_id] = user1
  end

  describe "#show" do
    it "redirects to root_path if user does not have permissions" do
      user2 = create(:user2)
      get :show, id: user2.id
      expect(response).to redirect_to root_path
    end

    it "renders the show view" do
      get :show, id: user1.id
      expect(response).to render_template :show
    end

    it "redirects to root_path if user is not logged in" do
      session[:user_id] = nil
      get :show, id: user1.id
      expect(response).to redirect_to root_path
    end
  end

  describe "#deauthorize" do
    context "when logged in" do
      before(:each) do
        identity
      end
      it "decreases number of identities by 1" do
        expect(Identity.all.length).to eq 1
        post :deauthorize, id: user1.id, provider: identity.provider
        expect(Identity.all.length).to eq 0
      end

      it "decreases number of identities for logged in user by 1" do
        expect(user1.identities.length).to eq 1
        post :deauthorize, id: user1.id, provider: user1.identities.first.provider
        expect(user1.identities.reload.length).to eq 0
      end

      context "when logged in with 2 identities" do
        it "keeps user logged in" do
          user1.identities << create(:identity, provider: "vimeo")
          post :deauthorize, id: user1.id, provider: user1.identities.first.provider
          expect(response).to redirect_to user_path(user1.id)
        end
      end

      context "when logged in with 1 identity" do
        it "logs out a user" do
          user1.identities << identity
          post :deauthorize, id: user1.id, provider: user1.identities.first.provider
          expect(response).to redirect_to root_path
        end
      end
    end


  end
end
