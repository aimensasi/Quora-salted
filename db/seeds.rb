FILE_NAME =  APP_ROOT.join('db/', 'question_votes.csv')

class QuestionVotesImport
	def self.import
		
		votes = CSV.open(FILE_NAME, 
										:headers => true,
										:header_converters => :symbol
										).to_a.map! { |row| row.to_hash }
		
		votes.each do |row|
			QuestionVote.create(row)
		end
		
	end

end 