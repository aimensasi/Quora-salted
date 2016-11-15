get '/' do
	if logged_in
		@current_user = current_user
		redirect to('/index')
	else
		erb :"user/register", :layout => :'layouts/register_layout'	
	end
end

post '/log-in' do 
	@user = User.is_valid?(params)

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
	if logged_in
		@current_user = current_user
		erb :"user/profile"	
	else
		redirect to('/')
	end
end







