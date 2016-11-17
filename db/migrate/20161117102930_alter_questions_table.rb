class AlterQuestionsTable < ActiveRecord::Migration
	def up
		change_column :questions, :title, :string, :null => false
		remove_column :questions, :description
		remove_column :questions, :upvote
		remove_column :questions, :downvote
	end

	def down
		add_column :questions, :downvote, :integer, :null => false, :default => 0
		add_column :questions, :upvote, :integer, :null => false, :default => 0 
		add_column :questions, :description, :text, :null => true
		change_column :questions, :title, :string, :null => false, :limit =>70
	end
end
