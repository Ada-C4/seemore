require 'rails_helper'

RSpec.describe VimeoUsersController, type: :controller do
  let(:vimeo_user_hash) do {
      uri:  "/users/1111111",
      name: "audrey",
      description: "I love licorice",
      location: "Seattle, WA",
      videos_uri: "/users/1111111/videos",
      profile_images_uri: "/users/1111111/pictures"
      }
  end

  let(:params) do  {
    uri: "/users/1111111"
  }
  end

  let(:bad_vimeo_user_hash) do {
    uri:  "",
    name: "audrey",
    description: "I love licorice",
    location: "Seattle, WA",
    videos_uri: "/users/1111111/videos",
    profile_images_uri: "/users/1111111/pictures"
    }
  end

  let(:user) do
    User.create(uid:"1234",provider:"developer",name:"Test")
  end


  describe "PATCH 'subscribe'" do
    before(:each) do
      session[:user_id] = user.id
    end

    it "successfully creates a new VimeoUser if the VimeoUser does not exist" do
      patch :subscribe, params
      expect(VimeoUser.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    it "does not create a new VimeoUser if the VimeoUser already exists" do
      existing_VimeoUser = VimeoUser.create(uri: "/users/1111111", name: "audrey",description: "I love licorice", location: "Seattle, WA", videos_uri: "/users/1111111/videos", profile_images_uri: "/users/1111111/pictures")
      patch :subscribe, params
      expect(VimeoUser.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    it "creates Videos for new VimeoUsers" do
      patch :subscribe, params
      expect(VimeoUser.first.videos).not_to be_empty
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    it "does not create Videos if the VimeoUser already exists" do
      existing_VimeoUser = VimeoUser.create(uri: "/users/1111111", name: "audrey",description: "I love licorice", location: "Seattle, WA", videos_uri: "/users/1111111/videos", profile_images_uri: "/users/1111111/pictures")
      patch :subscribe, params
      expect(VimeoUser.first.videos).to be_empty
      expect(response.status).to eq 302
      expect(subject).to redirect_to :root
    end

    it "associates a VimeoUser with a User" do
      patch :subscribe, params
      expect(User.first.vimeo_users).to include(VimeoUser.first)
      expect(subject).to redirect_to :root
    end
  end
end