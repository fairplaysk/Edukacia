require 'spec_helper'

describe "quizzes/index.html.haml" do
  before(:each) do
    assign(:quizzes, [
      stub_model(Quiz,
        :name => "Name"
      ),
      stub_model(Quiz,
        :name => "Name"
      )
    ])
  end

  it "renders a list of quizzes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
