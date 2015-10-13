require 'spec_helper'

describe "contributed_items/new" do
  before(:each) do
    assign(:contributed_item, stub_model(ContributedItem,
      :category => "MyString",
      :name => "MyString",
      :status => "MyString",
      :description => "MyText",
      :creator => "MyString",
      :copyright => "MyString",
      :item_path => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new contributed_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contributed_items_path, "post" do
      assert_select "input#contributed_item_category[name=?]", "contributed_item[category]"
      assert_select "input#contributed_item_name[name=?]", "contributed_item[name]"
      assert_select "input#contributed_item_status[name=?]", "contributed_item[status]"
      assert_select "textarea#contributed_item_description[name=?]", "contributed_item[description]"
      assert_select "input#contributed_item_creator[name=?]", "contributed_item[creator]"
      assert_select "input#contributed_item_copyright[name=?]", "contributed_item[copyright]"
      assert_select "input#contributed_item_item_path[name=?]", "contributed_item[item_path]"
      assert_select "input#contributed_item_user_id[name=?]", "contributed_item[user_id]"
    end
  end
end
