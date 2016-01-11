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
  end
