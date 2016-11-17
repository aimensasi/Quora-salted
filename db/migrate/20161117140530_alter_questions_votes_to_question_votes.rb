class AlterQuestionsVotesToQuestionVotes < ActiveRecord::Migration
	def up
		rename_table :questions_votes, :question_votes
	end

	def down
		rename_table :question_votes, :questions_votes
	end
end
