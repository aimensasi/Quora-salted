class CreateAnswersVotesTable < ActiveRecord::Migration
	def up
		create_table :answers_votes do |t|
			t.references :answer, :index => true, :foreign_key => 'answer_id'
			t.references :user, :index => true, :foreign_key => 'user_id'
			t.string 'type'
			t.timestamps
		end
	end

	def down
		drop_table :answers_votes
	end
end
