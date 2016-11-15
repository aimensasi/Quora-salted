class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	belongs_to :user
	has_many :answers

	validates :title, :presence => true, :length => {:maximum => 70}
	validates :description, :length => {:maximum => 220}
	



end
