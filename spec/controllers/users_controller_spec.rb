require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(uid:"1234",provider:"developer",name:"Test")
  end

  describe "GET 'subscriptions'" do
    before(:each) do
      session[:user_id] = user.id
    end
    
    it "successfully loads the subscriptions page" do
      user
      get :subscriptions
      expect(subject).to render_template :subscriptions
    end
  end
end
