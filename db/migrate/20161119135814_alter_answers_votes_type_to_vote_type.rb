class AlterAnswersVotesTypeToVoteType < ActiveRecord::Migration
	def up
		rename_column :answer_votes, :type, :vote_type
	end

	def down
		rename_column :answer_votes, :vote_type, :type
	end
end
