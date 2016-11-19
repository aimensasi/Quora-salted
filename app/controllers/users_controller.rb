get '/' do
	if logged_in
		@current_user = current_user
		redirect to('/questions')
	else
		erb :"layouts/register", :layout => false
	end
end

post '/users' do
	white_list = {
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:password => params[:password],
		:email => params[:email]
	}
	@user = User.new(params)

	if @user.save
		session['user_id'] = @user.id
		flash['notice'] = "Welcome To Quora Salted"
		redirect to('/questions')
	else
		flash['notice'] = "Somethig went wrong : #{@user.errors.full_messages.first}"
		redirect to('/')
	end
end


get '/users/:id' do 
	@user = User.find_by_id(params[:id])
	(@current_user ? (@is_current = true) : (@is_current = false))
	erb :"user/profile"	
end

get '/users/:id/edit' do 
	@user = User.find_by_id(params[:id])
	puts "Edit User"
end







