require 'rails_helper'
require 'json'

RSpec.describe Creator, type: :model do

  let!(:creator1) {FactoryGirl.create(:twitter_creator)}
  let!(:user1) { FactoryGirl.create(:twitter_user)}

  let(:log_in) {
  current_user = create :user
  session[:user_id] = current_user.id
  }

    describe ".validations" do
      it "name must be present" do
        expect(Creator.new(name: nil, uid:"12233344")).to_not be_valid
      end
      it "uid must be present" do
        expect(Creator.new(name: "cat", uid: nil)).to_not be_valid
      end

      it "must have a unique uid" do
        expect(Creator.new(name: "cat", uid: creator1.name )).to_not be_valid
      end
    end

    describe '.find or create' do
      context 'creator exists' do
        let(:params) do {
                        "name" => "Edward",
                        "description" => "HELLO!",
                        "profile_pic" => "www.profilepic.com",
                        "provider" => "twitter",
                        "uri" => "/user/edward",
                        "uid" => "fdsfdsfs"
                      }
                    end
        it 'returns that creator' do
          expect(Creator.find_or_create(params)).to eq(creator1)
        end
      end

      context 'when the provider is Vimeo', :vcr do

          let(:create_params_vimeo) do
            vimeo_access_token = ENV["VIMEO_ACCESS_TOKEN"]
            all_results = HTTParty.get("https://api.vimeo.com/users?page=1&per_page=25&query=purple&fields=uri,name,pictures",
             headers: {"Authorization" => "bearer #{vimeo_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response
            result = all_results["data"][0]
            params = {
              "name" => result["name"],
              "profile_pic" => result["pictures"],
              "provider" => "vimeo",
              "uid" => result["uri"].gsub(/[^0-9]/, "")
            }
            return params
          end
        context 'when following a new vimeo creator' do
          it 'creates new vimeo Creator' do
            expect{ Creator.find_or_create(create_params_vimeo) }.to change(Creator, :count).by(1)
            expect(Creator.find_or_create(create_params_vimeo).name.downcase).to include("purple")
            expect(Creator.find_or_create(create_params_vimeo).provider).to eq("vimeo")
          end
        end

        context 'creates videos associated with the creator' do
          before :each do
            @vimeo_creator = Creator.find_or_create(create_params_vimeo)
          end

          it 'saves some videos associated with that creator' do
            expect(@vimeo_creator.videos.nil?).to be_falsey
          end

          # it 'if the videos are not populated correctly Creator is not saved ' do
          #   bad_vimeo_creator_params = {
          #     "provider" => "vimeo",
          #     "uid" => "21222444"
          #   }
          #   expect{ Creator.find_or_create(bad_vimeo_creator_params) }.to raise_error(ArgumentError)
          #   expect{ Creator.find_or_create(bad_vimeo_creator_params) }.to change(Creator, :count).by(0)
          # end

          it 'save the Creator if there are no videos' do
          end

          it 'has a profile picture' do
          end

          it 'assigns and default image if none is provided' do
            pictureless_params = {
              "name" => "frog",
              "provider" => "vimeo",
              "uid" => "2520140"
            }
            default_pic_creator = Creator.find_or_create(pictureless_params)
            expect(default_pic_creator.profile_pic).to be_truthy
            expect(default_pic_creator.profile_pic).to eq("vimeo_default_image.png")
          end

        end
      end

      context 'when the provider is Twitter', :vcr do

        let(:create_params_twitter) do
          {
            "name" => "CutePicsOfCats",
            "profile_pic" => "http://pbs.twimg.com/profile_images/567285191169687553/7kg_TF4l_normal.jpeg",
            "provider" => "twitter",
            "uid" => "3040591972"
          }
        end

        it 'creates new twitter Creator' do
          expect{ Creator.find_or_create(create_params_twitter) }.to change(Creator, :count).by(1)
          expect(Creator.find_or_create(create_params_twitter).name).to eq("CutePicsOfCats")
          expect(Creator.find_or_create(create_params_twitter).provider).to eq("twitter")
        end


        it 'saves some tweets associated with that creator' do
          twitter_creator = Creator.find_or_create(create_params_twitter)
          expect(twitter_creator.tweets.nil?).to be_falsey
          expect(twitter_creator.tweets).to_not be_empty
          expect(twitter_creator.tweets[0]).to be_an_instance_of(Tweet)
        end

        it 'assigns and default image if none is provided' do
          pictureless_params = {
            "name" => "CutePicsOfCats",
            "provider" => "twitter",
            "uid" => "3040591972"
          }
          default_pic_creator = Creator.find_or_create(pictureless_params)
          expect(default_pic_creator.profile_pic).to be_truthy
          expect(default_pic_creator.profile_pic).to eq("twitter_default_image.png")
        end

      end

    end
end

  # describe 'get videos info' do
  # end


#   describe 'create videos' do
#     before(:each) do
#       VCR.use_cassette 'get_videos' do
#
#     end
#   end
# end
