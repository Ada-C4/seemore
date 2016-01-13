require 'rails_helper'

RSpec.describe MediaController, type: :controller do
  let(:new_mark) { build(:mark) }
  let(:prez_mark) { build(:mark, :prez) }
  let(:new_spy) { build(:spy) }

  describe "GET #index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "index gets all marks" do 
    it "returns all current spies marks" do 
      new_spy.save
      session[:spy_id] = new_spy.id
      get :index

      expect(response).to render_template :index
    end
  end

  context "showing the feed" do 
    describe "shows all media" do 
      it "creates new media with vimeo" do
        new_spy.save
        new_mark.save
        new_spy.marks << new_mark
        session[:spy_id] = new_spy.id
        get :index

        expect(Medium.all.count).to be > 0
        expect(Medium.all.last.medium_type).to eq "vimeo"
      end

      it "creates new media with twitter" do
        new_spy.save
        prez_mark.save
        new_spy.marks << prez_mark
        session[:spy_id] = new_spy.id
        get :index

        expect(Medium.all.count).to be > 0
        expect(Medium.all.last.medium_type).to eq "twitter"
      end
    end
  end
end
