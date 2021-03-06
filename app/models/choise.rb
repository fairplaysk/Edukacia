# -*- encoding : utf-8 -*-

class Choise < ActiveRecord::Base
  belongs_to :answer
  belongs_to :submission
  
  def self.submission_history_statistics
    #FIXME: refactor
    submissions = Submission.select('count(questions.id) as quantity, month(submissions.created_at) as month, year(submissions.created_at) as year').joins(:quiz => :questions).where('submissions.created_at > ? and submissions.is_repeated = ? and ((quizzes.published_at < ? and quizzes.is_active = ?) or quizzes.is_generated = ?)', 1.year.ago, false, 2.days.ago, true, true).group('month(submissions.created_at)')
    submissions_hash = {
  	"cols" =>
  	    [
  	        {"id" => "year", "label" => "Rok", "type" => "string"},
  	        {"id" => "answered_questions", "label" => I18n.translate('homepages.statistics.history_statistics'), "type" => "number"}
  	    ],
  	"rows" =>[]
  	}
  	
  	index = 1.year.ago.at_beginning_of_month
  	end_time = Time.now.at_beginning_of_month
  	while index <= end_time
  	  if selected_submission = submissions.select{|s| s.month == index.strftime("%m").to_i && s.year == index.strftime("%Y").to_i}.first
  	    submissions_hash['rows'] << {
    	    "c" => [ {"v" => I18n.localize(index, :format => :month)}, {"v" => selected_submission.quantity} ]
    	  }
	    else
	      submissions_hash['rows'] << {
    	    "c" => [ {"v" => I18n.localize(index, :format => :month)}, {"v" => 0.00001} ]
    	  }
      end
      index += 1.month
	  end
    submissions_hash
  end
  
  def self.chart_correct_incorrect
    #FIXME: refactor
    correct_answers_count = correct_answers
    incorrect_answers_count = incorrect_answers
    
    {
  	"cols" =>
  	    [
  	        {"id" => "correctness", "label" => "Correctness", "type" => "string"},
  	        {"id" => "number", "label" => "Number", "type" => "number"}
  	    ],
  	"rows" =>[
  	    {"c" => [ {"v" => I18n.translate('submissions.show.chart_correct')}, {"v" => correct_answers_count} ]},
    	  {"c" => [ {"v" => I18n.translate('submissions.show.chart_incorrect')}, {"v" => incorrect_answers_count} ]}
  	  ]
  	}
  end
  
  def self.chart_hardest
    hardest_question = Question.joins(:answers => :choises).where('choises.id is not null').order(:average_percentage).first
    correct_answers_count = hardest_question.answers.select{|a| a.is_correct? }.map(&:choises).flatten.length
    incorrect_answers_count = hardest_question.answers.map(&:choises).flatten.length - correct_answers_count
    
    category_name = hardest_question.quiz ? hardest_question.quiz.categories.first.name : 'n\a'
    quiz_name = hardest_question.quiz ? hardest_question.quiz.name : 'n\a'
    {
    "text" => "#{hardest_question.content} <br> #{category_name} | #{quiz_name}",
  	"cols" =>
  	  [
  	    {"id" => "correctness", "label" => "Correctness", "type" => "string"},
  	    {"id" => "number", "label" => "Number", "type" => "number"}
  	  ],
  	"rows" =>
  	  [
        {"c" => [ {"v" => I18n.translate('submissions.show.chart_correct')}, {"v" => correct_answers_count} ]},
        {"c" => [ {"v" => I18n.translate('submissions.show.chart_incorrect')}, {"v" => incorrect_answers_count} ]}
  	  ]
  	}
  end
  
  def self.chart_easiest
    #FIXME: refactor
    easiest_question = Question.order(:average_percentage).last
    correct_answers_count = easiest_question.answers.select{|a| a.is_correct? }.map(&:choises).flatten.length
    incorrect_answers_count = easiest_question.answers.map(&:choises).flatten.length - correct_answers_count
    {
    "text" => "#{easiest_question.content} <br> #{easiest_question.quiz.categories.first.name} | #{easiest_question.quiz.name}",
  	"cols" =>
  	  [
  	    {"id" => "correctness", "label" => "Correctness", "type" => "string"},
  	    {"id" => "number", "label" => "Number", "type" => "number"}
  	  ],
  	"rows" =>
  	  [
        {"c" => [ {"v" => I18n.translate('submissions.show.chart_correct')}, {"v" => correct_answers_count} ]},
        {"c" => [ {"v" => I18n.translate('submissions.show.chart_incorrect')}, {"v" => incorrect_answers_count} ]}
  	  ]
  	}
  end
  
  def self.most_popular_quiz
    best_quiz = Quiz.select('quizzes.*, avg(submissions.rating) as average_rating').joins(:submissions).where('((quizzes.published_at < ? and quizzes.is_active = ?) or quizzes.is_generated = ?)', 2.days.ago, true, true).group('quizzes.id').order('avg(submissions.rating) desc').first
    best_rating = best_quiz.average_rating
    
    ratings_hash = {
      "text" => "#{best_quiz.categories.first.name} | #{best_quiz.name}",
    	"cols" =>
    	  [
    	    {"id" => "stars", "label" => "Stars", "type" => "string"},
    	    {"id" => "number", "label" => "Number", "type" => "number"}
    	  ],
    	"rows" => []
    }
    ratings_hash['rows'] << { "c" => [ {"v" => "no star"}, {"v" => Submission.where(:rating => 0, :quiz_id => best_quiz).count} ] }
    1.upto(5) do |index|
      count = Submission.where(:rating => index, :quiz_id => best_quiz).count == 0 ? 0.0001 : Submission.where(:rating => index, :quiz_id => best_quiz).count
      ratings_hash['rows'] << {
  	    "c" => [ {"v" => "#{index} star"}, {"v" => count} ]
  	  }
    end
    
    ratings_hash
  end
  
  
  def self.correct_answers
    Choise.includes({:submission => :quiz}, :answer).where(:submissions => {:is_repeated => false}, :answers => {:is_correct => true}).where('submissions.is_repeated = ? and ((quizzes.published_at < ? and quizzes.is_active = ?) or quizzes.is_generated = ?)', false, 2.days.ago, true, true).count
  end
  
  def self.incorrect_answers
    Submission.joins(:quiz => :questions).where('submissions.is_repeated = ? and ((quizzes.published_at < ? and quizzes.is_active = ?) or quizzes.is_generated = ?)', false, 2.days.ago, true, true).count - correct_answers
  end
end
