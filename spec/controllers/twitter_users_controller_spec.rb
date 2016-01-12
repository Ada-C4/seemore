require 'rails_helper'

RSpec.describe TwitterUsersController, type: :controller do
  let(:twitter_user_hash) do {
      twitter_id:      "12345678",
      screen_name: "kdefliese",
      name: "Katherine Defliese",
      description: "I really like cats",
      location: "Seattle, WA",
      uri: "https://twitter.com/kdefliese",
      profile_image_uri: "http://pbs.twimg.com/profile_images/672319002706706432/_MQlTm-A_normal.jpg"
      }
  end

  let(:params) do  {
    screen_name: "kdefliese"
  }
  end

  let (:protected_params) do {
    screen_name: "kerrydefliese"
  }
  end

  let(:bad_twitter_user_hash) do {
    twitter_id:      "",
    screen_name: "",
    name: "",
    description: "",
    location: "",
    uri: "",
    profile_image_uri: ""
    }
  end

  let(:user) do
    User.create(uid:"1234",provider:"developer",name:"Test")
  end

  let(:existing_TwitterUser) do
    TwitterUser.create(twitter_id: "3320848554", screen_name: "kdefliese", name: "Katherine Defliese", uri: "https://twitter.com/kdefliese")
  end


  describe "PATCH 'subscribe'" do
    before(:each) do
      session[:user_id] = user.id
    end

    # it "successfully creates a new TwitterUser if the TwitterUser does not exist" do
    #   patch :subscribe, params
    #   expect(TwitterUser.all.length).to eq 1
    #   expect(response.status).to eq 302
    #   expect(subject).to redirect_to :root
    # end

    it "does not create a new TwitterUser if the TwitterUser already exists" do
      existing_TwitterUser
      patch :subscribe, params
      expect(TwitterUser.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    # it "creates Tweets for new TwitterUsers" do
    #   patch :subscribe, params
    #   expect(TwitterUser.first.tweets).not_to be_empty
    #   expect(response.status).to eq 302
    #   expect(subject).to redirect_to :root
    # end

    it "does not create Tweets if the TwitterUser already exists" do
      existing_TwitterUser = TwitterUser.create(twitter_id: "3320848554", screen_name: "kdefliese", name: "Katherine Defliese", uri: "https://twitter.com/kdefliese")
      patch :subscribe, params
      expect(TwitterUser.first.tweets).to be_empty
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    # it "associates a TwitterUser with a User" do
    #   patch :subscribe, params
    #   expect(User.first.twitter_users).to include(TwitterUser.first)
    #   expect(subject).to redirect_to :root
    # end

    it "will not create a TwitterUser if the Twitter account is protected" do
      patch :subscribe, protected_params
      expect(flash[:error]).to eq "That user is protected; you cannot subscribe to their tweets."
      expect(subject).to redirect_to :root
    end

    it "will not associate a User with a TwitterUser if they are already associated" do
      existing_TwitterUser = TwitterUser.create(twitter_id: "3320848554", screen_name: "kdefliese", name: "Katherine Defliese", uri: "https://twitter.com/kdefliese")
      user.twitter_users << existing_TwitterUser
      patch :subscribe, params
      expect(user.twitter_users.length).to eq 1
      expect(flash[:error]).to eq "You are already subscribed to this user."
      expect(subject).to redirect_to :root
    end

  end

  describe "PATCH 'unsubscribe'" do
    before(:each) do
      session[:user_id] = user.id
    end

    it "removes the association between the User and the TwitterUser" do
      patch :unsubscribe, params
      expect(user.twitter_users.length).to eq 0
      expect(subject).to redirect_to :subscriptions
    end
  end

end
