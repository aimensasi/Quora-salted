class AnswerVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	UP_VOTE = 'Upvote'
	DOWN_VOTE = 'Downvote'
	validates :user_id, :uniqueness => { scope: :answer_id}
	validates :vote_type, :inclusion => {:in => [DOWN_VOTE, UP_VOTE], :message => 'Not Valid Vote Type'}

	belongs_to :user
	belongs_to :answer

	scope :upvote, -> { where('vote_type = ?', UP_VOTE) }
	scope :downvote, -> { where('vote_type = ?', DOWN_VOTE) }
	scope :voted?, -> (answer_id, user_id) { where('answer_id = ? AND user_id = ?', answer_id, user_id) }
end
