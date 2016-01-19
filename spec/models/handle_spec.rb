require 'rails_helper'

RSpec.describe Handle, type: :model do
  let(:twitter_user_instance) do
    $twitter.user("houglande")
  end

  describe ".validates" do
    context "when created with good parameters" do
      it "will be valid" do
        expect(build(:twitter_handle)).to be_valid
      end
    end

    context "when created with any bad parameters" do
      it "will not be valid" do
        expect(build(:twitter_handle, name: nil)).to be_invalid
        expect(build(:twitter_handle, uri: nil)).to be_invalid
        expect(build(:twitter_handle, provider: nil)).to be_invalid
      end
    end
  end

  describe ".create_handle" do
    context "when given an instance of Twitter::User" do
      it "adds an instance of Handle" do
        VCR.use_cassette('api_responses', :record => :new_episodes) do
          expect(Handle.all.count).to eq 0
          Handle.create_twitter_handle(twitter_user_instance.screen_name)
          expect(Handle.all.count).to eq 1
        end
      end
    end
  end

  describe ".search" do
    before(:each) do
      create(:twitter_handle)
    end
    it "returns array" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Handle.search("houglande")).to be_kind_of(Array)
      end
    end
    it "returns array of Twitter::User instances" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Handle.search("houglande")[0]).to be_an_instance_of(Twitter::User)
      end
    end
    it "returns correct instance of Twitter::User" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        search_results = Handle.search("houglande")
        expect(search_results).to include(twitter_user_instance)
      end
    end
  end

  describe ".create_vimeo_handle" do
    it "increases num of Handles by 1" do
      VCR.use_cassette('api_responses', :record => :new_episodes) do
        expect(Handle.all.count).to eq 0
        Handle.create_vimeo_handle("/users/657778")
        # https://vimeo.com/user657778
        expect(Handle.all.count).to eq 1
      end
    end
  end
end
