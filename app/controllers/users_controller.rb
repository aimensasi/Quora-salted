before do
	#if path request matches any of the given return 
	if ['/', '/log-in', '/sign-up'].include?(request.path_info)
		return
	end
		puts "In"
	if logged_in

		@current_user = current_user
	else
		redirect to('/')
	end
end

get '/' do
	if logged_in
		@current_user = current_user
		redirect to('/index')
	else
		erb :"layouts/register", :layout => false
	end
end

post '/log-in' do 
	@user = User.is_valid?(params)
	puts "log-in"
	if @user
		session['user_id'] = @user.id	
		redirect to('/index')
	else
		redirect to('/')
	end
end

post '/sign-up' do
	@user = User.new(params) 

	if @user.save
		session['user_id'] = @user.id
		redirect to('/index')
	else
		redirect to('/')	
	end
end

get '/log-out' do
	session['user_id'] = nil
	redirect to('/')
end

get '/user/:id' do 
	@user = User.find_by_id(params[:id])
	#check if there is a user signed in 
	@current_user = current_user
	erb :"user/profile"	
end







