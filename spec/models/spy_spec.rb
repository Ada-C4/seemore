require 'spec_helper'
require 'rails_helper'

RSpec.describe Spy, type: :model do
  let(:new_spy) { build(:spy) }
  let(:bad_id_spy) { build(:spy, username: "something new") }
  let(:bad_username_spy) { build(:spy, uid: "something new") }

  describe "validations" do
    it "is valid" do
      expect(new_spy).to be_valid
    end

    it "requires a username" do
      new_spy.username = nil
      expect(new_spy).to be_invalid
    end

    it "requires a provider" do
      new_spy.provider = nil
      expect(new_spy).to be_invalid
    end

    it "requires a uid" do
      new_spy.uid = nil
      expect(new_spy).to be_invalid
    end

    it "has a unique uid" do
      new_spy.save
      expect(bad_id_spy).to_not be_valid
    end

    it "has a unique username" do
      new_spy.save
      expect(bad_username_spy).to_not be_valid
    end
  end
end
