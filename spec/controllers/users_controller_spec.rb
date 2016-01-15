require 'rails_helper'
require 'pry'

RSpec.describe UsersController, type: :controller do

  describe "GET show" do
    before :each do
      @user = create(:twitter_user)
      session[:user_id] = @user.id
    end

    it "is successful" do
      get :show, id: @user.id
      expect(response.status).to eq(200)
    end
  end

end
