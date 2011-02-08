FactoryGirl.define do
  factory :quiz do
    name 'quiz'
    comment 'comment for the quiz'
    sponsor 'sponsor for the quiz'
    funny_comment 'funny comment for the quiz'
    placement_comments (1..4).collect { Factory(:placement_comment) }
    categories { [Factory(:category)] }
  end
  
  factory :quiz_with_questions, :parent => :quiz do
    questions { [Factory(:question_one_with_answers), Factory(:question_two_with_answers)] }
  end
end