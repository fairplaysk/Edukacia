Factory.define :quiz do |quiz|
  quiz.name 'quiz'
  quiz.comment 'comment for the quiz'
  quiz.sponsor 'sponsor for the quiz'
  quiz.funny_comment 'funny comment for the quiz'
  quiz.placement_comments (1..4).collect { Factory(:placement_comment) }
  quiz.categories [Factory(:category)]
end