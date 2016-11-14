
# Requiring test environment file
require 'spec_helper'

# Requiring test subject file. Uncomment below.
require_relative File.join(APP_MODELS, "user")
#turn off logging during testing 
ActiveRecord::Base.logger = nil


# Test cases
describe 'UsersInsertion' do
	before(:all) do 
		raise RuntimeError "Should Run rake db:migrate before testing " unless expect(ActiveRecord::Base.connection.data_source_exists?(:users)).to be(true)
		User.delete_all
	end

	before(:each) do 
		@user = User.create(
		:first_name => "James",
		:last_name => "Jorden",
		:password => "Aa1234567",
		:email => "James@yahoo.com"
		)

	end
	


	it "Should Accept Valid Data" do 
		expect(@user).to be_valid
	end

	it "Should not Accept InValid Data" do 
		@user.update_attributes(:password => "1234232")	
		expect(@user).to_not be_valid
	end

	it "should not allow two users with the same email" do 
		second_user = User.create(
		:first_name => "James",
		:last_name => "Lamela",
		:password => "Aa1234567",
		:email => "James@yahoo.com"
		)

		expect(second_user).to_not be_valid
	end


end
