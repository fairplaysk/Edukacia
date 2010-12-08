require 'spec_helper'

describe "quizzes/show.html.haml" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
