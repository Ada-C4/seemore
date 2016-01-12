require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(uid:"1234",provider:"developer",name:"Test")
  end

  describe "GET 'subscriptions'" do

    it "successfully loads the subscriptions page if you are logged in" do
      user
      session[:user_id] = user.id
      get :subscriptions
      expect(subject).to render_template :subscriptions
    end

    it "will not load the subscription page if you are not logged in" do
      get :subscriptions
      expect(subject).to redirect_to :login
    end
  end
end
