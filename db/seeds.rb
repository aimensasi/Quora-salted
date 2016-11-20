FILE_NAME =  APP_ROOT.join('db/data/', 'questions.csv')

class ImportData
	
	def self.import_users

		70.times do 
			User.create(
				:first_name => Faker::Name.first_name,
				:last_name => Faker::Name.last_name,
				:email => Faker::Internet.email,
				:password => Faker::Internet.password(8, 70, true)
				)
		end

	end

	def self.import_questions
		user_ids = User.ids

		questions = CSV.open(FILE_NAME, :headers => true, :header_converters => :symbol)
			 .to_a.map! { |row| row.to_hash}	 

		questions.each do |question|
			Question.create(
					:title => question[:title], 
					:user_id => user_ids.sample
					)
		end	

	end

	def self.import_answers
	end

	def self.import_answer_votes
	end

	def self.import_question_votes
		user_ids = User.ids
		question_ids = Question.ids	
		
		100.times do 
			vote = QuestionVote.create!(
					:question_id => question_ids.sample,
					:user_id => user_ids.sample,
					:vote_type => ['Upvote', 'Downvote'].sample
				)
		end	
	end

end 



