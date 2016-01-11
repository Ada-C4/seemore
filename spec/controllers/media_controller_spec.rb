require 'rails_helper'

RSpec.describe MediaController, type: :controller do
  let(:new_mark) { build(:mark) }
  let(:new_spy) { build(:spy) }

  describe "GET #index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "index gets all marks" do 
    it "returns all current spies marks" do 
      new_spy.save
      session[:spy_id] = new_spy.id
      get :index

      expect(response).to render_template :index
    end
  end
end
