FactoryGirl.define do
  factory :question do
    content 'question 1'
  end
  
  factory :question_with_answers, :parent => :question do
    answers (1..4).collect { Factory(:answer) }
  end
end