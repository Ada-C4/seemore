require 'spec_helper'
require 'rails_helper'

RSpec.describe Medium, type: :model do
  let(:medium) { Medium.new(
      mark_id:     "0",
      date_posted: "3/7/2015",
      link:        "www.twitter.com/user",
      medium_type: "tweet")
    }

    describe "validations" do

      it "requires a mark_id" do
        medium.mark_id = nil
        expect(medium).to be_invalid
      end

      it "requires a date_posted" do
        medium.date_posted = nil
        expect(medium).to be_invalid
      end

      it "requires a link" do
        medium.link = nil
        expect(medium).to be_invalid
      end

      it "requires a medium type" do
        medium.medium_type = nil
        expect(medium).to be_invalid
      end
    end
  end
