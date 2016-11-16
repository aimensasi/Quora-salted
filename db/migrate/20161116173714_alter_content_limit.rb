class AlterContentLimit < ActiveRecord::Migration
	def up
		change_column :answers, :content, :string
	end

	def down
		change_column :answers, :content, :string, :limit => 200
	end
end
