require 'spec_helper'

describe "communities/index" do
  before(:each) do
    assign(:communities, [
      stub_model(Community,
        :name => "Name",
        :slug => "Slug",
        :description => "MyText"
      ),
      stub_model(Community,
        :name => "Name",
        :slug => "Slug",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of communities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
