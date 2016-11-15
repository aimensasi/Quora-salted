# Requiring test environment file
require 'spec_helper'

# Requiring test subject file. Uncomment below.
# require_relative File.join(APP_CONTROLLER, "static")

# Test cases
describe 'AnswersMigration' do
	before(:all) do 
		raise RuntimeError "Should Run rake db:migrate before testing" unless expect(ActiveRecord::Migration.current_version).to be > 0		
	end

	it "should have answers table" do 
		expect(ActiveRecord::Base.connection.data_source_exists?(:answers)).to be true
	end 

	it "should Have the right schema" do 
		columns = {
			:integer => ["id", "user_id", "question_id"],
			:text => ["content"],
			:datetime => ["created_at", "updated_at"]
		}

		ActiveRecord::Base.connection.columns(:answers).each do |col|
			expect(columns[col.type].include?(col.name)).to be true
		end
	end

end
