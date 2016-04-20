require 'spec_helper'

RSpec.describe StaticPagesController do
  it "about page is successful" do
    get :about
    expect(response.status).to eq 200
  end

  it "contact page is successful" do
    get :contact
    expect(response.status).to eq 200
  end

  it "terms page is successful" do
    get :terms
    expect(response.status).to eq 200
  end
end
