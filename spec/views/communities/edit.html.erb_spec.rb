require 'spec_helper'

describe "communities/edit" do
  before(:each) do
    @community = assign(:community, stub_model(Community,
      :name => "MyString",
      :slug => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit community form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", community_path(@community), "post" do
      assert_select "input#community_name[name=?]", "community[name]"
      assert_select "input#community_slug[name=?]", "community[slug]"
      assert_select "textarea#community_description[name=?]", "community[description]"
    end
  end
end
