require "spec_helper"

describe ContributedItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/contributed_items").should route_to("contributed_items#index")
    end

    it "routes to #new" do
      get("/contributed_items/new").should route_to("contributed_items#new")
    end

    it "routes to #show" do
      get("/contributed_items/1").should route_to("contributed_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contributed_items/1/edit").should route_to("contributed_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contributed_items").should route_to("contributed_items#create")
    end

    it "routes to #update" do
      put("/contributed_items/1").should route_to("contributed_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contributed_items/1").should route_to("contributed_items#destroy", :id => "1")
    end

  end
end
