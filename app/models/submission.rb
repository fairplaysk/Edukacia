class Submission < ActiveRecord::Base
  has_many :choises
  has_many :answers, :through => :choises
  
  belongs_to :quiz
  
  default_scope order('updated_at desc')
  
  def correct_answers_count
    answers.where(:is_correct => true).count
  end
  
  def correct_submissions_percentage
    first_submissions = Submission.where(:is_repeated => nil)
    correct_submissions_count = first_submissions.select do |fs|
      fs.correct_answers_count == fs.quiz.questions.count
    end.count
    first_submissions.count == 0 ? 0 : correct_submissions_count.to_f*100 / first_submissions.count
  end
end
