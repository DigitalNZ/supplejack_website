require 'spec_helper'

describe "contributed_items/index" do
  before(:each) do
    assign(:contributed_items, [
      stub_model(ContributedItem,
        :category => "Category",
        :name => "Name",
        :status => "Status",
        :description => "MyText",
        :creator => "Creator",
        :copyright => "Copyright",
        :item_path => "Item Path",
        :user_id => 1
      ),
      stub_model(ContributedItem,
        :category => "Category",
        :name => "Name",
        :status => "Status",
        :description => "MyText",
        :creator => "Creator",
        :copyright => "Copyright",
        :item_path => "Item Path",
        :user_id => 1
      )
    ])
  end

  it "renders a list of contributed_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Creator".to_s, :count => 2
    assert_select "tr>td", :text => "Copyright".to_s, :count => 2
    assert_select "tr>td", :text => "Item Path".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
