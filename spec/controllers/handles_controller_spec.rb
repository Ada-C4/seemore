require 'rails_helper'

RSpec.describe HandlesController, type: :controller do
  let(:handle) do
    Handle.create
  end
  describe "GET 'show'" do
    it "renders the show page" do
      get :show, id: handle.id
      expect(subject).to render_template :show
    end
  end
end
