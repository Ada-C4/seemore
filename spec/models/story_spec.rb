require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "model methods" do
    let!(:story) {Story.create(
      uid: 1, text: "blah", subscription_id: 1, post_time: Time.now)
    }

    it "find_or_create returns an existing story if one exists" do
      story
      a = Story.find_or_create(1, "blah", nil, nil, 1, Time.now)
      expect(a).to eq story
    end

    it "find_story? returns true if a story is found" do
      story
      a = Story.find_story?(1, 1)
      expect(a).to eq true
    end
  end

end
