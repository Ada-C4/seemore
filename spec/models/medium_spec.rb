require 'spec_helper'
require 'rails_helper'
require 'pry'

RSpec.describe Medium, type: :model do
  let(:new_medium) { build(:medium) }

    describe "validations" do

      it "requires a mark_id" do
        new_medium.mark_id = nil
        expect(new_medium).to be_invalid
      end

      it "requires a date_posted" do
        new_medium.date_posted = nil
        expect(new_medium).to be_invalid
      end

      it "requires a link" do
        new_medium.link = nil
        expect(new_medium).to be_invalid
      end

      it "requires a new_medium type" do
        new_medium.medium_type = nil
        expect(new_medium).to be_invalid
      end
    end

    describe "#self.video_lookup" do
      context "users videos become Media instances" do
        it "creates Medium instances" do
          create(:mark)
          Medium.video_lookup("jeffdesom")
          expect(Medium.all.length).to be > 1
        end

        it "returns an array of videos less than or equal to 20" do
          create(:mark)
          Medium.video_lookup("jeffdesom")
          expect(Medium.all.count).to be < 20
        end

        it "returns videos with all information" do
          create(:mark)
          Medium.video_lookup("jeffdesom")
          expect(Medium.all.first.link).to eq "https://vimeo.com/150264292"
        end

        it "finds the video in the database rather than creating a new medium" do
          create(:mark)
          Medium.video_lookup("jeffdesom")
          expect{Medium.video_lookup("jeffdesom")}.to change(Medium, :count).by(0)
        end
      end
    end

    describe "#self.vimeo_filter" do
      it "returns only vimeo media" do
        mark = create(:mark_with_media)
        expect(Medium.vimeo_filter(mark.media).count).to eq 0
      end

      it "returns only twitter media" do
        mark = create(:mark_with_media)
        expect(Medium.twitter_filter(mark.media).count).to eq 5
      end
    end
  end
