class CreateQuestionsVotesTable < ActiveRecord::Migration
	def up
		create_table :questions_votes do |t|
			t.string 'type'
			t.references :user, :index => true, :foreign_key => 'user_id'
			t.references :question, :index => true, :foreign_key => 'question_id'
			t.timestamps
		end
	end

	def down
		drop_table :questions_votes
	end
end
