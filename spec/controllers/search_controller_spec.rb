require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:twitter_params) do {
    search_term: "defliese",
    provider: 1
  }
  end

  let(:vimeo_params) do {
    search_term: "adadev",
    provider: 2
  }
  end


let(:user) do
  User.create(uid:"1234",provider:"developer",name:"Test")
end

  describe "GET 'index'" do
    context "when searching for a twitter or vimeo user" do
      it "successfully loads the search results page" do
        get :index
        expect(subject).to render_template :index
      end

      context "when making api calls to Twiter"  do
        before(:each) do
          session[:user_id] = user.id
          VCR.use_cassette 'twitter_search_response' do
            get :index, twitter_params
          end
        end
        it "gives you data back from twitter" do
          expect(response.status).to eq 200
        end
      end #ends api twitter context

      context "when making api calls to Vimeo" do
        before(:each) do
          session[:user_id] = user.id
          VCR.use_cassette 'vimeo_search_response' do
            get :index, vimeo_params
          end
        end

        it "gives you data back from vimeo" do
          expect(response.status).to eq 200
        end
      end
    end #ends first context block
  end #ends get index describe block
end # ends the whole shebang
