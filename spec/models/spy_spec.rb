require 'rails_helper'

RSpec.describe Spy, type: :model do
  before(:each) do
    Spy.create(
    uid: "string thing",
    username: "usery name",
    image_url: "http://www.imageyimage.com",
    provider: "twitter")
  end

  describe "validations" do
    it "is valid" do
      expect(spy).to be_valid
    end

    it "requires a username" do
      spy.username = nil
      expect(spy).to be_invalid
    end

    it "requires a provider" do
      spy.provider = nil
      expect(spy).to be_invalid
    end

    it "requires a uid" do
      spy.uid = nil
      expect(spy).to be_invalid
    end

    it "has a unique uid" do
      expect(Spy.new(
        uid: "string thing",
        username: "usery name",
        image_url: "http://www.imageyimage.com",
        provider: "twitter")).to_not be_valid
    end

    it "has a unique username" do
      expect(Spy.new(
        uid: "string thing",
        username: "usery name",
        image_url: "http://www.imageyimage.com",
        provider: "twitter")).to_not be_valid
    end
  end
end
