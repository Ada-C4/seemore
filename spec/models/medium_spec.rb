require 'spec_helper'
require 'rails_helper'

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
        it "returns an array of videos" do
          create(:mark)
          expect(Medium.video_lookup("jeffdesom")).to be_an Array
        end
        
        it "returns an array of videos less than or equal to 10" do
          create(:mark)
          array = Medium.video_lookup("johnmervin")
          expect(array.count).to be > 11
        end

        it "returns instances of Media" do
          create(:mark)
          array = Medium.video_lookup("jeffdesom")
          expect(array[0]).to be_an_instance_of Medium
        end

        it "returns videos with all information" do
          create(:mark)
          array = Medium.video_lookup("jeffdesom")
          expect(array[0].link).to eq "https://vimeo.com/150264292"
        end

        it "finds the video in the database rather than creating a new medium" do
          create(:mark)
          Medium.video_lookup("jeffdesom")
          expect{Medium.video_lookup("jeffdesom")}.to change(Medium, :count).by(0)
        end
      end
    end
  end
