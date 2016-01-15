require 'rails_helper'
require './spec/support/shared_tests'

RSpec.describe SessionsController, type: :controller do
  context "when using twitter authentication" do
    it_behaves_like "an auth controller" do
      let(:auth_provider) { :twitter }
    end
  end

  context "when using vimeo authentication" do
    it_behaves_like "an auth controller" do
      let(:auth_provider) { :vimeo }
    end
  end
end
