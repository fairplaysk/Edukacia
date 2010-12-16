FactoryGirl.define do
  factory :quiz do
    name 'quiz'
    comment 'comment for the quiz'
    sponsor 'sponsor for the quiz'
    funny_comment 'funny comment for the quiz'
    placement_comments (1..4).collect { Factory(:placement_comment) }
    categories [Factory(:category)]
  end
end