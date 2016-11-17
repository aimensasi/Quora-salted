class AlterAnswersVotesToAnswerVotes < ActiveRecord::Migration
	def up
		rename_table :answers_votes, :answer_votes
	end

	def down
		rename_table :answer_votes, :answers_votes
	end
end
