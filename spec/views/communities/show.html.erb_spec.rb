require 'spec_helper'

describe "communities/show" do
  before(:each) do
    @community = assign(:community, stub_model(Community,
      :name => "Name",
      :slug => "Slug",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Slug/)
    rendered.should match(/MyText/)
  end
end
