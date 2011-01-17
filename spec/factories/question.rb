FactoryGirl.define do
  factory :question do
    content 'question 1'
  end
  
  factory :question_with_answers, :parent => :question do
    answers { [Factory(:answer, :is_correct => true), Factory(:answer), Factory(:answer), Factory(:answer)]  }
  end
end