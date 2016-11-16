class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	validates :content, :presence => true, :length => {:maximum => 9999}

	belongs_to :user
	belongs_to :question


end
