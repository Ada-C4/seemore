require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:params) do {
    search_term: "defliese"
  }
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
            patch :subscribe, params
          end
        end
          it "gives you data back from twitter" do

          end

          it "gives you data back from vimeo" do

          end
      end #ends api context


    end #ends first context block

  end #ends get index describe block

end # ends the whole shebang
