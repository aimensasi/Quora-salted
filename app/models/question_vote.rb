class QuestionVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	validates :user_id, :uniqueness => { scope: :question_id}
	validates :type, :inclusion => {:in => ['Downvote', 'Upvote'], :message => 'Not Valid Vote Type'}

	belongs_to :user
	belongs_to :question

	scope :upvote, -> { where('type = ?', 'Upvote') }
	scope :downvote, -> { where('type = ?', 'Downvote') }

end
