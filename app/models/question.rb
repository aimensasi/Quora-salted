class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	belongs_to :user
	has_many :answers
	has_many :votes, :foreign_key => "question_id", :class_name => "QuestionVote"

	validates :title, :presence => true, :length => {:maximum => 200}
	
end
