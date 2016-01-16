require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  context "factory girl only" do
    before (:each) do
        @user = build(:user)
    end

    describe "GET #index" do
      it "renders welcome index when there is a current user" do
        @user.save
        session[:user_id] = @user.id
        get :index
        @current_user = @user
        expect(subject).to render_template :index
        @user.destroy
      end

      it "redirects to login route when there is no current user" do
        session[:user_id] = nil
        get :index
        expect(subject).to redirect_to login_path
      end
    end

    describe "make feed" do
      it "generates a feed for the user" do
        get :index
        feed = controller.make_feed(@user)
        expect(feed).to_not be_nil
        expect(feed.length).to eq(2)
      end
    end
  end
end
