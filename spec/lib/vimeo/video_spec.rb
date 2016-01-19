require 'vimeo/base'
require 'vimeo/video'

RSpec.describe Vimeo, type: :module do
  let(:user_uri) { "/users/36804861" }

  describe ".get_user_videos" do
    it "returns an array" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Vimeo::Video.get_user_videos(user_uri)).to be_an_instance_of Array
      end
    end

    it "returns an array of Vimeo::Video objects" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Vimeo::Video.get_user_videos(user_uri).first).to be_an_instance_of Vimeo::Video
      end
    end
  end
end
