require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET 'show'" do
    it "renders the show view" do
      get :show
      expect(subject).to render_template :show
    end
  end

describe "GET 'twitter_search'" do
    let(:params) do
    {
      search: "justinbieber"
    }
  end

  it "renders the twitter_search view" do
    get :twitter_search, params
    expect(subject).to render_template :twitter_search
  end
end

describe "GET 'twitter_search_user'" do
  let(:params) do
    {
      id: "justinbieber"
    }
  end

  it "renders the twitter_search_user view" do
    get :twitter_search_user, params
    expect(subject).to render_template :twitter_search_user
  end

end
end
