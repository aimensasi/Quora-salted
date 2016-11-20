WillPaginate.per_page = 10

class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	self.per_page = 10

	UP_VOTE = 'Upvote'
	belongs_to :user
	has_many :answers, :dependent => :destroy
	has_many :votes, :foreign_key => "question_id", :class_name => "QuestionVote", :dependent => :destroy

	validates :title, :presence => true, :length => {:maximum => 200}
	
	scope :top, -> {  joins(:votes).where('vote_type = ?', UP_VOTE).group(:id).order(id: :desc).count }

	

	
end

