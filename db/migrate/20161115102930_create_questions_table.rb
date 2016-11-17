class CreateQuestionsTable < ActiveRecord::Migration
	def up
		create_table :questions do |t|
			t.string "title", :null => false, :limit =>70
			t.text "description", :null => true
			t.integer "upvote", :null => false, :default => 0
			t.integer "downvote", :null => false, :default => 0
			t.timestamps

			t.references :user, :index => true, :foreign_key => "user_id"
			
		end
	end

	def down
		drop_table :questions
	end
end
