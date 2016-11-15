class CreateAnswersTable < ActiveRecord::Migration
	def up
		create_table :answers do |t|
			t.text "content", :null => false, :limit => 200
			t.timestamps

			t.references :user, :index => true, :foreign_key => "user_id"
			t.references :question, :index => true, :foreign_key => "question_id"
		end
	end

	def down
		drop_table :answers
	end
end
