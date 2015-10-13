require 'spec_helper'

describe "stories/edit" do
  before(:each) do
    @story = assign(:story, stub_model(Story,
      :user_set_id => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", story_path(@story), "post" do
      assert_select "input#story_user_set_id[name=?]", "story[user_set_id]"
      assert_select "textarea#story_content[name=?]", "story[content]"
    end
  end
end
