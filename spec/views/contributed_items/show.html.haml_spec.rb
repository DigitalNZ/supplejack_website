require 'spec_helper'

describe "contributed_items/show" do
  before(:each) do
    @contributed_item = assign(:contributed_item, stub_model(ContributedItem,
      :category => "Category",
      :name => "Name",
      :status => "Status",
      :description => "MyText",
      :creator => "Creator",
      :copyright => "Copyright",
      :item_path => "Item Path",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Category/)
    rendered.should match(/Name/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
    rendered.should match(/Creator/)
    rendered.should match(/Copyright/)
    rendered.should match(/Item Path/)
    rendered.should match(/1/)
  end
end
