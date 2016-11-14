# Requiring test environment file
require 'spec_helper'

# Requiring test subject file. Uncomment below.
# require_relative File.join(APP_CONTROLLER, "static")

# Test cases
describe 'UsersMigration' do
	before(:all) do
		raise RuntimeError "Should run rake db:migrate before testing" unless expect(ActiveRecord::Migration.current_version).to be > 0
	end

	it "Should have a users table" do 
		expect(ActiveRecord::Base.connection.data_source_exists?(:users)).to be(true)
	end

	it "should have the right schema" do 
		columns = {
			:integer => ["id"],
			:string => ["first_name", "last_name", "email", "password_digest"],
			:datetime => ["created_at", "updated_at"]
		}
		ActiveRecord::Base.connection.columns(:users).each do |col|
			expect(columns[col.type].include?(col.name)).to eq(true)
		end
	end
end
