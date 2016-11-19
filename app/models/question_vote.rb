class QuestionVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	UP_VOTE = 'Upvote'
	DOWN_VOTE = 'Downvote'
	validates :user_id, :uniqueness => { scope: :question_id}
	validates :vote_type, :inclusion => {:in => [DOWN_VOTE, UP_VOTE], :message => 'Not Valid Vote Type'}

	belongs_to :user
	belongs_to :question

	scope :upvote, -> { where('vote_type = ?', UP_VOTE) }
	scope :downvote, -> { where('vote_type = ?', DOWN_VOTE) }
	scope :voted?, -> (question_id, user_id) { where('question_id = ? AND user_id = ?', question_id, user_id) }
	# scope :top, -> { count(:).where('vote_type = ?', UP_VOTE).group(:question_id, :user_id)}

	def upvote?
		QuestionVote.where('vote_type = ?', UP_VOTE).first
	end

	def downvote?
		QuestionVote.where('vote_type = ?', DOWN_VOTE).first
	end
end


