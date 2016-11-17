class QuestionVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	validates :user_id, :uniqueness => { scope: :question_id}
	validates :vote_type, :inclusion => {:in => ['Downvote', 'Upvote'], :message => 'Not Valid Vote Type'}

	belongs_to :user
	belongs_to :question

	scope :upvote, -> { where('vote_type = ?', 'Upvote') }
	scope :downvote, -> { where('vote_type = ?', 'Downvote') }
	scope :voted?, -> (question_id, user_id) { where('question_id = ? AND user_id = ?', question_id, user_id) }
end
