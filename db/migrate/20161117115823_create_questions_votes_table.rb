class CreateQuestionsVotesTable < ActiveRecord::Migration
	def up
		create_table :questions_votes do |t|
			t.references :question, :index => true, :foreign_key => 'question_id'
			t.references :user, :index => true, :foreign_key => 'user_id'
			t.string 'type'
			t.timestamps
		end
	end

	def down
		drop_table :questions_votes
	end
end
