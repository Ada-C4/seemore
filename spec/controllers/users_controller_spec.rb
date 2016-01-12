require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET 'subscriptions'" do
    it "successfully loads the subscriptions page" do
      get :subscriptions
      expect(subject).to render_template :subscriptions
    end
  end
end
