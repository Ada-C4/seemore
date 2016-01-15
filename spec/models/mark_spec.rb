require 'spec_helper'
require 'rails_helper'

RSpec.describe Mark, type: :model do
  let(:new_mark) { build(:mark) }
  let(:mark_media) { create(:mark_with_media) }
  let(:new_spy) { build(:spy) }

  describe "model associations" do
    it "has many media" do
      expect(mark_media.media.count).to eq 5
    end

    it "has and belongs to many spies" do
      new_spy.save
      new_mark.save

      new_mark.spies << new_spy

      expect(new_spy.marks.first.uid).to eq "1291877"
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
      bad_mark = Mark.new(username: "stuff", provider: "stuff", uid: "1291877")
      expect(bad_mark.save).to eq false
    end
  end

  describe "#self.single_mark_vimeo_lookup" do
    context "user exists" do
      it "creates a new mark" do
        expect(Mark.single_mark_vimeo_lookup("hi")).to be_an_instance_of Mark
      end

      it "sets the profile image to 'blank.png' if the image is nil" do
        expect((Mark.single_mark_vimeo_lookup("user47660891")).image_url).to eq "blank.png"
      end
    end

    context "user does not exist" do
      it "returns an error if the user doesn't exist" do
        expect(Mark.single_mark_vimeo_lookup("fadjslfajdslfkjasdlkfj")).to eq "The requested user could not be found"
      end
    end
  end

  describe "#self.vimeo_lookup" do
    context "search results exist" do
      it "returns an array of marks" do
        expect(Mark.vimeo_lookup("hi")).to be_an_instance_of Array
        expect(Mark.vimeo_lookup("hi")[0]).to be_an_instance_of Mark
      end
    end

    context "search results do not exist" do
      it "returns an empty array if no results exist" do
        expect(Mark.vimeo_lookup("fadjslfajdslfkjasdlkfj")).to eq []
      end
    end
  end
end
