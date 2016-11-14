class CreateUsersTable < ActiveRecord::Migration
	def up
		create_table :users do |t|
			t.string "first_name", :null => false, :limit => 45
			t.string "last_name", :null => false, :limit => 45
			t.string "password_digest", :null => false, :limit => 72
			t.string "email", :null => false, :limit => 120
			t.timestamps
		end
	end

	def down
		drop_table :users
	end
end
