require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]}
  let!(:user) {User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter])}

  before :each do
    session[:user_id] = user.id
  end

  describe "GET #search" do

    context "when user does not specify twitter or vimeo" do
      let (:search_params) do
    {
      search: "cat",
    }
    end

      it "renders the search template" do
        get :search, search_params
        expect(subject).to render_template(:search)
      end

      it "flash notice if no provider is specified" do
        get :search, search_params
        expect(flash[:notice]).to be_present
      end


    end

    context "when searching vimeo" do

      let (:good_search_params) do
    {
      search: "cat",
      provider: "vimeo"

    }
  end

    let (:bad_search_params) do
  {
    search: "sssskljkkljdfskljlkjdfslkjfakljfdslkjdfksjlkljdfskjlfdskljfklsdjoiuwoiuwrqijdgsjkllkjsdfljkgsdjghsdajhgdsa",
    provider: "vimeo"
  }
  end

      it "renders the search template" do
        get :search, good_search_params
        expect(subject).to render_template(:search)
      end
      it "is successful" do
        get :search, good_search_params
        expect(response.status).to eq 200
      end
      it "returns a search result" do
        get :search, good_search_params
        expect(assigns(:results)).to be_an_instance_of(Array)
        expect(assigns(:results)).not_to be_empty
        expect(assigns(:results)[1]["name"]).to include("cat")
      end
      it "flash error if no search results" do
        get :search, bad_search_params
        expect(flash[:error]).to be_present
      end
    end

    context "when searching twitter" do

      let (:good_search_params) do
    {
      search: "cat",
      provider: "twitter"

    }
  end

    let (:bad_search_params) do
  {
    search: "sssskljkkljdfskljlkjdfslkjfaklrqijdgsjkllkjsdfljkgsdjghsdajhgdsa",
    provider: "twitter"
  }
  end
      it "renders the search template" do
        get :search, good_search_params
        expect(subject).to render_template(:search)
      end
      it "is successful" do
        get :search, good_search_params
        expect(response.status).to eq 200
      end
      it "returns a search result" do
        get :search, good_search_params
        expect(assigns(:results)).to be_an_instance_of(Array)
        expect(assigns(:results)).not_to be_empty
        expect(assigns(:results)[0].name).to include("Cat")
      end
      it "flash error if no search results" do
        get :search, bad_search_params
        expect(flash[:error]).to be_present
      end
    end
  end

end
