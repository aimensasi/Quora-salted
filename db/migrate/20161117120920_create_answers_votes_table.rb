class CreateAnswersVotesTable < ActiveRecord::Migration
	def up
		create_table :answers_votes do |t|
			t.string 'type'
			t.references :user, :index => true, :foreign_key => 'user_id'
			t.references :answer, :index => true, :foreign_key => 'answer_id'
			t.timestamps
		end
	end

	def down
		drop_table :answers_votes
	end
end
