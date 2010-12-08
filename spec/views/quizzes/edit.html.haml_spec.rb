require 'spec_helper'

describe "quizzes/edit.html.haml" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz,
      :name => "MyString"
    ))
  end

  it "renders the edit quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quiz_path(@quiz), :method => "post" do
      assert_select "input#quiz_name", :name => "quiz[name]"
    end
  end
end
