require 'spec_helper'

describe "stories/new" do
  before(:each) do
    assign(:story, stub_model(Story,
      :user_set_id => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stories_path, "post" do
      assert_select "input#story_user_set_id[name=?]", "story[user_set_id]"
      assert_select "textarea#story_content[name=?]", "story[content]"
    end
  end
end
