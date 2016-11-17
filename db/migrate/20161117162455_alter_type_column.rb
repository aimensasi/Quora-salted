class AlterTypeColumn < ActiveRecord::Migration
	def up
		rename_column :question_votes, :type, :vote_type
		rename_column :answer_votes, :type, :vote_type
	end

	def down
		rename_column :answer_votes, :vote_type, :type
		rename_column :question_votes, :vote_type, :type
	end
end
