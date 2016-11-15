# Requiring test environment file
require 'spec_helper'

# Requiring test subject file. Uncomment below.
# require_relative File.join(APP_MODELS, "question")

# Test cases
describe 'QuestionsMigration' do
	before(:all) do 
		raise RuntimeError "Should Run rake db:migrate before testing" unless expect(ActiveRecord::Migration.current_version).to be > 0
	end 

	it "should have questions table" do 
		expect(ActiveRecord::Base.connection.data_source_exists?(:questions)).to be true
	end

	it "Should have the right schema " do 
		columns = {
			:integer => ["id", "user_id", "upvote", "downvote"],
			:string => ["title"],
			:text => ["description"],
			:datetime => ["created_at", "updated_at"]
		}

		ActiveRecord::Base.connection.columns(:questions).each do |col|
			expect(columns[col.type].include?(col.name)).to eq(true)
		end
	end
end
