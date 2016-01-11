require 'spec_helper'
require 'rails_helper'

RSpec.describe Mark, type: :model do
  let(:new_mark) { build(:mark) }
  let(:new_spy) { build(:spy) }

  describe "model associations" do
    it "has many media" do
      new_mark.save
      5.times do
        create(:medium)
      end

      expect(new_mark.media.count).to eq 5

    end

    it "has and belongs to many spies" do
      new_spy.save
      new_mark.save

      new_mark.spies << new_spy

      expect(new_spy.marks.first.uid).to eq "56789"
      expect(new_mark.spies.first.uid).to eq "12345"
    end

  end

  describe "validations" do
    it "creates a mark instance when everything goes right" do
      expect(new_mark).to be_valid
    end

    it "must have a username" do
      bad_mark = new_mark
      bad_mark.username = nil
      expect(bad_mark).to be_invalid
    end

    it "must have a unique username" do
      new_mark.save
      bad_mark = Mark.new(username: "markisthebest", provider: "stuff", uid: "9394")
      expect(bad_mark.save).to eq false
    end

    it "must have a provider" do
      bad_mark = new_mark
      bad_mark.provider = nil
      expect(bad_mark).to be_invalid
    end

    it "must have a uid" do
      bad_mark = new_mark
      bad_mark.uid = nil
      expect(bad_mark).to be_invalid
    end

    it "must have a unique uid" do
      new_mark.save
      bad_mark = Mark.new(username: "stuff", provider: "stuff", uid: "56789")
      expect(bad_mark.save).to eq false
    end
  end

  describe "#self.vimeo_lookup" do
    context "user exists" do
      it "creates a new mark" do
        expect(Mark.vimeo_lookup("hi")).to be_an_instance_of Mark
      end

      it "sets the profile image to 'blank.png' if the image is nil" do
        expect((Mark.vimeo_lookup("user47660891")).image_url).to eq "blank.png"
      end
    end

    context "user does not exist" do
      it "returns an error if the user doesn't exist" do
        expect(Mark.vimeo_lookup("fadjslfajdslfkjasdlkfj")).to eq "The requested user could not be found"
      end
    end
  end
end