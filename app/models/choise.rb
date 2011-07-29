# -*- encoding : utf-8 -*-

class Choise < ActiveRecord::Base
  belongs_to :answer
  belongs_to :submission
  
  def self.submission_history_statistics
    #FIXME: refactor
    submissions = Choise.select('count(id) as quantity, month(created_at) as month, year(created_at) as year').where('created_at > ?', 1.year.ago).group('MONTH(created_at)')
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
    correct_answers_count = correct_answers.count
    incorrect_answers_count = incorrect_answers.count
    
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
    percentage, correct_answers_count, incorrect_answers_count, hardest_question = 1, 0, 0, Question.first
    Question.includes({:answers => {:choises =>:submission}}, :quizzes).where('quizzes.is_active = ? and submissions.is_repeated = ?', true, false).each do |question|
      correct_answers = question.answers.select{|a| a.is_correct? }.map(&:choises).flatten.length
      all_answers = question.answers.map(&:choises).flatten.length
      
      if (correct_answers.to_f / all_answers.to_f) < percentage
        percentage = correct_answers.to_f / all_answers.to_f
        correct_answers_count = correct_answers
        incorrect_answers_count = all_answers - correct_answers
        hardest_question = question
      end
    end
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
    percentage, correct_answers_count, incorrect_answers_count, easiest_question = 0, 0, 0, Question.first
    Question.includes({:answers => {:choises =>:submission}}, :quizzes).where('quizzes.is_active = ? and submissions.is_repeated = ?', true, false).all.each do |question|
      correct_answers = question.answers.select{|a| a.is_correct? }.map(&:choises).flatten.length
      all_answers = question.answers.map(&:choises).flatten.length
      
      if (correct_answers.to_f / all_answers.to_f) > percentage
        percentage = correct_answers.to_f / all_answers.to_f
        correct_answers_count = correct_answers
        incorrect_answers_count = all_answers - correct_answers
        easiest_question = question
      end
    end
    
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
    best_quiz = Quiz.select('quizzes.*, avg(submissions.rating) as average_rating').joins(:submissions).group('quizzes.id').order('avg(submissions.rating) desc').first
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
    1.upto(5) do |index|
      count = Submission.where(:rating => index, :quiz_id => best_quiz).count == 0 ? 0.0001 : Submission.where(:rating => index, :quiz_id => best_quiz).count
      ratings_hash['rows'] << {
  	    "c" => [ {"v" => "#{index} star"}, {"v" => count} ]
  	  }
    end
    
    ratings_hash
  end
  
  
  def self.correct_answers
    Choise.includes(:submission, :answer).where(:submissions => {:is_repeated => false}, :answers => {:is_correct => true})
  end
  
  def self.incorrect_answers
    Choise.includes(:submission, :answer).where(:submissions => {:is_repeated => false}, :answers => {:is_correct => false})
  end
end
