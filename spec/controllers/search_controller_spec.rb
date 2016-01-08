require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:params) do {
    search_term: "defliese"
  }
end

  describe "GET 'index'" do
    it "successfully loads the search results page" do
      get :index, params
      expect(subject).to render_template :index
    end
  end
end
