class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	UP_VOTE = 'Upvote'
	belongs_to :user
	has_many :answers, :dependent => :destroy
	has_many :votes, :foreign_key => "question_id", :class_name => "QuestionVote", :dependent => :destroy

	validates :title, :presence => true, :length => {:maximum => 200}
	
	scope :top, -> {  joins(:votes).where('vote_type = ?', UP_VOTE).group(:id).order(id: :desc).count }
end

# question_id, COUNT(question_id)
# as counter from question_votes where vote_type 
# = 'Upvote' GROUP BY question_id order by counter DESC;


# count(:question_id, 
# 									:conditions => 'vote_type = Upvote', 
# 									:joins => 'JOIN votes ON votes.question_id = question.id')


# 


# 