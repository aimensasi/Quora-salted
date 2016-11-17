class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	belongs_to :user
	has_many :answers

	validates :title, :presence => true, :length => {:maximum => 200}
	
end
