
get '/answer/new' do 
	@answer = Answer.new
	erb :"answer/new_answer"
end

post '/answer/create' do 
	@answer = Answer.new(params)
	@answer.user = @current_user
	@answer.question = Question.all.first
	if @answer.save
		redirect to('/index')
	else
		puts "ERROR #{@answer.errors.full_messages}"
		redirect to('/answer/new')
	end
end

get '/answer/:id/edit' do
	@answer = Answer.find_by_id(params[:id])
	if @answer
		erb :"answer/edit_answer"
	else
		redirect to("/index")
	end
end

patch '/answer/update', allows: [:id, :content] do 
	@answer = Answer.find_by_id(params['id'])

	if @answer.update_attributes(params)
		redirect to("/index")
	else
		puts "ERROR #{@answer.errors.full_messages}"
		redirect to("/answer/#{params['id']}/edit")
	end
end

get '/answer/:id/delete' do
	@answer = Answer.find_by_id(params[:id])
	if @answer.delete
		puts "User Was Deleted"
		redirect to('/index')
	end
end
