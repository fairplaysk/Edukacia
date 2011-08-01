module Kwizzer
  class StatisticsController < ApplicationController
    before_filter :super_user!
    
    def index
      @quizzes = Quiz.where(:is_generated => false)
      @random_quizzes = Quiz.where(:is_generated => true)
      @questions = Question.includes(:quizzes => :submissions)
    end
    
    def download
      if params[:content] == 'quizzes'
        data = quiz_csv(Quiz.where(:is_generated => false))
      elsif params[:content] == 'questions'
        data =  question_csv(Question.includes(:quizzes => :submissions))
      end
      send_data data, :type => 'text/csv', :filename => "#{params[:content]}.csv"
    end
    
    private
    def quiz_csv(quizzes)
      export = "title,submitted,average_rating,average_percentage\n"
      quizzes.each do |quiz|
        export << "\"#{quiz.name.gsub('"',"'")}\",#{quiz.submissions.size},#{quiz.submissions.average(:rating)},#{quiz.average_percentage}\n"
      end
      export
    end
    
    def question_csv(questions)
      export = "title,all,correct,incorrect,skipped\n"
      questions.each do |question|
        all_count = Submission.where(:quiz_id => question.quizzes, :is_repeated => false).count
        correct_count = question.answers.select{|a| a.is_correct? }.map{|a| a.submissions.group('submissions.id')}.flatten.select{|s| !s.is_repeated?}.flatten.length
        export << "\"#{question.content.gsub('"',"'")}\",#{all_count},#{correct_count},#{all_count - correct_count},#{all_count - question.answers.map{|a| a.submissions}.flatten.select{|s| !s.is_repeated?}.flatten.length}\n"
      end
      export
    end
  end
end