require 'spec_helper'

describe "stories/index" do
  before(:each) do
    assign(:stories, [
      stub_model(Story,
        :user_set_id => "User Set",
        :content => "MyText"
      ),
      stub_model(Story,
        :user_set_id => "User Set",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of stories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User Set".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
