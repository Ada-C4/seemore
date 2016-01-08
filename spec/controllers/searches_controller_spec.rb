require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe "GET #search" do
    context "when searching vimeo" do
      it "renders the search template" do
        get :search
        expect(subject).to render_template(:search)
      end
      it "is successful" do
        get :search
        expect(response.status).to eq 200
      end
    end
  end

end
