require "spec_helper"

describe CommunitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/communities").should route_to("communities#index")
    end

    it "routes to #new" do
      get("/communities/new").should route_to("communities#new")
    end

    it "routes to #show" do
      get("/communities/1").should route_to("communities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/communities/1/edit").should route_to("communities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/communities").should route_to("communities#create")
    end

    it "routes to #update" do
      put("/communities/1").should route_to("communities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/communities/1").should route_to("communities#destroy", :id => "1")
    end

  end
end
