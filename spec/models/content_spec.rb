require 'rails_helper'

RSpec.describe Content, type: :model do
  it { is_expected.to validate_presence_of(:content_id) }
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:create_time) }
  it { is_expected.to validate_presence_of(:creator_id) }
end
