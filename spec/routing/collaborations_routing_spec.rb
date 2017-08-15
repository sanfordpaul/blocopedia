require "rails_helper"

RSpec.describe CollaborationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/collaborations").to route_to("collaborations#index")
    end

    it "routes to #new" do
      expect(:get => "/collaborations/new").to route_to("collaborations#new")
    end

    it "routes to #show" do
      expect(:get => "/collaborations/1").to route_to("collaborations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/collaborations/1/edit").to route_to("collaborations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/collaborations").to route_to("collaborations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/collaborations/1").to route_to("collaborations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/collaborations/1").to route_to("collaborations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/collaborations/1").to route_to("collaborations#destroy", :id => "1")
    end

  end
end
