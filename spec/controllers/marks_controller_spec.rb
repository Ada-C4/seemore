require 'rails_helper'

RSpec.describe MarksController, type: :controller do
    let(:new_spy) { build(:spy) }
    let(:new_mark) { build(:mark) }

  describe "GET #results" do
    context "logged in" do
      context "twitter" do
        it "renders the results template" do
          new_spy.save
          session[:spy_id] = new_spy.id
          get :results, provider: "twitter", username: "loganmeetsworld"
          expect(response).to render_template :results
        end
      end

      context "vimeo" do
        it "renders the results page" do
          new_spy.save
          session[:spy_id] = new_spy.id
          get :results, provider: "vimeo", username: "loganmeetsworld"
          expect(response).to render_template :results
        end
      end
    end

    context "not logged in" do
      context "twitter" do
        it "redirects to the home page" do
          get :results, provider: "twitter"
          expect(response).to redirect_to root_path
        end

        it "adds a flash error" do
          get :results, provider: "twitter"
          expect(flash[:error]).to_not be nil
        end
      end

      context "vimeo" do
        it "redirects to the home page" do
          get :results, provider: "vimeo"
          expect(response).to redirect_to root_path
        end

        it "adds a flash error" do
          get :results, provider: "vimeo"
          expect(flash[:error]).to_not be nil
        end
      end
    end
  end

  describe "GET #index" do
    it "renders the index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #vimeo_subscribe" do
    it "redirects to the marks index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :vimeo_subscribe, name: "hi"
      expect(response).to redirect_to marks_path
    end

    it "creates a new mark" do
      new_spy.save
      session[:spy_id] = new_spy.id
      expect{ post :vimeo_subscribe, name: "hi" }.to change(Mark, :count).by(1)
    end

    it "doesn't create a new mark if one already exists" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :vimeo_subscribe, name: "hi"

      expect{ post :vimeo_subscribe, name: "hi" }.to change(Mark, :count).by(0)

    end
  end

  describe "POST #twitter_subscribe" do
    it "redirects to the marks index page" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :twitter_subscribe, name: "hi"
      expect(response).to redirect_to marks_path
    end

    it "creates a new mark" do
      new_spy.save
      session[:spy_id] = new_spy.id
      expect{ post :twitter_subscribe, name: "hi" }.to change(Mark, :count).by(1)
    end

    it "doesn't create a new mark if one already exists" do
      new_spy.save
      session[:spy_id] = new_spy.id
      post :twitter_subscribe, name: "hi"

      expect{ post :twitter_subscribe, name: "hi" }.to change(Mark, :count).by(0)

    end
  end

  describe "DELETE #destroy" do
    it "deletes marks from the users marks" do
      new_spy.save
      new_mark.save
      new_spy.marks << new_mark
      session[:spy_id] = new_spy.id
      delete :destroy, id: new_mark.id

      expect(new_spy.marks.size).to eq 0
    end

    it "redirects to the marks_path" do
      new_spy.save
      new_mark.save
      new_spy.marks << new_mark
      session[:spy_id] = new_spy.id
      delete :destroy, id: new_mark.id

      expect(response).to redirect_to marks_path
    end
  end

end
