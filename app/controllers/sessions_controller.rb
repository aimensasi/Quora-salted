before do
	#if path request matches any of the given return 
	if ['/', '/log-in', '/sign-up'].include?(request.path_info)
		return
	end
	#check if user logged in
	if logged_in
		@current_user = current_user
	else
		redirect to('/')
	end
end

post '/log-in' do
	white_list = {
		:email => params[:email],
		:password => params[:password]
	}

	@user = User.is_valid?(white_list)

	if @user
		session['user_id'] = @user.id	
		redirect to('/questions')
	else
		puts "Error #{@user.errors.full_messages}"
		redirect to('/')
	end
end

get '/log-out' do
	session['user_id'] = nil
	redirect to('/')
end

