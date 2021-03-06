FactoryGirl.define do
  factory :quiz do
    name 'quiz'
    comment 'comment for the quiz'
    sponsor 'sponsor for the quiz'
    funny_comment 'funny comment for the quiz'
    placement_comments { (1..4).collect { |i| Factory(:placement_comment, :content => "placement_comment #{i}") } }
    categories { [Factory(:category)] }
  end
  
  factory :quiz_with_questions, :parent => :quiz do
    questions { [Factory(:question_one_with_answers), Factory(:question_two_with_answers)] }
  end
  
  factory :quiz_with_category, :parent => :quiz_with_questions do
    categories { [Factory(:category, :name => "Category", :short_name => 'category')] }
  end
end