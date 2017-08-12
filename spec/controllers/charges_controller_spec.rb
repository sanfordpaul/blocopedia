require 'rails_helper'
include RandomData


RSpec.describe ChargesController, type: :controller do


  let(:my_user) {create(:user)}

  before(:each) do
    sign_in my_user
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
  end
end
=begin
  describe "POST create" do
    context "on the happy path" do

      it "returns http success" do
        post :create
        expect(response).to have_http_status(:success)
      end

      it "renders the #create view" do
        post :create
        expect(response).to render_template :create
      end

      it "creates a customer object" do
        expect(customer).to exist
      end

      it "creates a charge" do
          expect(charge).to exist
      end

      it "upgrades user role to premium" do
        expect(curent_user.role).to eq("premium")
      end

      it "sets user charge to charge.id" do
        expect(curent_user.charge).to eq(charge.id)
      end

      it "renders the create view" do
        expect(response).to render_template(:create)
      end

    end
  end
=end
