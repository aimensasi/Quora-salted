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
	(@current_user == @user ? (@is_current = true) : (@is_current = false))
	erb :"user/profile"	
end


patch '/users/:id' do
	white_list = {
		:first_name => params[:first_name],
		:last_name => params[:last_name]
	}
	@user = User.find_by_id(params[:id])
	if @user.update_columns(white_list)
		flash['notice'] = "Your Profile Was Updated Successfully"
		redirect back
	else
		puts "errors #{@user.errors.full_messages}"
		flash['notice'] = "Somethig went wrong : #{@user.errors.full_messages.first}"
		redirect back
	end
end







