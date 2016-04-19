require 'spec_helper'

RSpec.describe StaticPagesController do

  describe "GET 'about'" do
    it "returns http success" do
      get :about
      expect(response.status).to eq 200
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get :contact
      expect(response.status).to eq 200
    end
  end

  describe "GET 'terms'" do
    it "returns http success" do
      get :terms
      expect(response.status).to eq 200
    end
  end

end
