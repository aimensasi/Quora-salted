class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

	PASSWORD_REGEX = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}\z/
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password

	validates :first_name, :presence => true, :length => {:maximum => 45}
	validates :last_name, :presence => true, :length => {:maximum => 45}
	validates :email, :presence => true, :uniqueness => true, :length => {:maximum => 120}, :format => {:with => EMAIL_REGEX}
	validates :password, :length => {:minimum => 8}, :format => {:with => PASSWORD_REGEX}


	def name 
		"#{first_name} #{last_name}"
	end

	def self.is_valid?(params)
		user = self.find_by(:email => params[:email])
		if user && user.authenticate(params[:password])
			user
		else
			nil
		end
	end
end
