FactoryGirl.define do
  factory :question do
    sequence(:content) {|n| "question #{n}" }
  end
  
  factory :question_one_with_answers, :parent => :question do
    content 'question 1'
    answers { [Factory(:answer, :content => 'answer 1', :is_correct => true), Factory(:answer, :content => 'answer 2'), Factory(:answer, :content => 'answer 3'), Factory(:answer, :content => 'answer 4')]  }
  end
  
  factory :question_two_with_answers, :parent => :question do
    content 'question 2'
    answers { [Factory(:answer, :content => 'answer 5',:is_correct => true), Factory(:answer, :content => 'answer 6'), Factory(:answer, :content => 'answer 7'), Factory(:answer, :content => 'answer 8')]  }
  end
end