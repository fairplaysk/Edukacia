Factory.define :quiz do |quiz|
  quiz.name 'quiz'
  quiz.comment 'comment for the quiz'
  quiz.sponsor 'sponsor for the quiz'
  quiz.funny_comment 'funny comment for the quiz'
  quiz.placement_comments { |pc| (1..4).collect { Factory(:placement_comment, :quiz => pc.result) } }
end

Factory.define :placement_comment do |placement_comment|
  placement_comment.content 'placement comment'
end