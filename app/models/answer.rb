class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	validates :content, :presence => true, :length => {:maximum => 9999}

	belongs_to :user
	belongs_to :question
	has_many :votes, :foreign_key => "answer_id", :class_name => "AnswerVote", :dependent => :destroy

end
