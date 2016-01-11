require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    it "redirects to login route when there is no current user" do
      session[:id] = nil
      get :index
      expect(subject).to redirect_to login_path
    end
  end
end
