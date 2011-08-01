namespace :kwizzer do
  task :update_quiz_percentage => :environment do
    Quiz.all.each do |quiz|
      quiz.update_attribute(:average_percentage, quiz.quiz_submission_percentage)
    end
  end
end