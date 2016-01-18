require 'rails_helper'

RSpec.shared_examples "a skynet controller" do

  describe 'GET index' do
    it 'is successful' do
      get :index
      expect(subject.response.status).to eq(200)
    end
  end

end
