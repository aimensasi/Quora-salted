class AnswerVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	validates :user_id, :uniqueness => { scope: :answer_id}
	validates :type, :inclusion => {:in => ['Downvote', 'Upvote'], :message => 'Not Valid Vote Type'}

	belongs_to :user
	belongs_to :answer
end
