require 'spec_helper'

describe "communities/new" do
  before(:each) do
    assign(:community, stub_model(Community,
      :name => "MyString",
      :slug => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new community form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", communities_path, "post" do
      assert_select "input#community_name[name=?]", "community[name]"
      assert_select "input#community_slug[name=?]", "community[slug]"
      assert_select "textarea#community_description[name=?]", "community[description]"
    end
  end
end
