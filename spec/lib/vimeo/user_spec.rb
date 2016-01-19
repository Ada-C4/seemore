require 'vimeo/base'
require 'vimeo/user'

RSpec.describe Vimeo, type: :module do
  let(:user_uri) { "/users/36804861" }

  describe ".find_by_name" do
    it "returns an array" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Vimeo::User.find_by_name("Daphne")).to be_an_instance_of Array
      end
    end

    it "returns an array of Vimeo::User objects" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Vimeo::User.find_by_name("Daphne").first).to be_an_instance_of Vimeo::User
      end
    end
  end

  describe ".find_by_uri" do
    it "returns an instance of Vimeo::User" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Vimeo::User.find_by_uri(user_uri)).to be_an_instance_of Vimeo::User
      end
    end
  end
end
