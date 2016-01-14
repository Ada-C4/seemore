require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:params) do {
    search_term: "defliese"
  }
end

let(:user) do
  User.create(uid:"1234",provider:"developer",name:"Test")
end

  describe "GET 'index'" do
    context "when searching for a twitter or vimeo user" do
      it "successfully loads the search results page" do
        get :index, params
        expect(subject).to render_template :index
      end

      context "when making api calls"  do
        before(:each) do
          session[:user_id] = user.id
          VCR.use_cassette 'twitter_response' do
            get :index, params
          end
        end
          it "gives you data back from twitter" do
            expect(response.status).to eq 200
          end

          it "gives you data back from vimeo" do
            expect(response.status).to eq 200
          end
      end #ends api context


    end #ends first context block

  end #ends get index describe block

end # ends the whole shebang
