post '/answers/new' do 
	@answer = Answer.new
	@answer.content = params[:answer]
	@answer.user = @current_user
	@answer.question = Question.find_by_id(params[:question_id])
	if @answer.save
		{:status => 200, :type => 'answers',  :template => erb(:'answer/show_answer', :layout => false, :locals => {:answer => @answer}), :question_id => @answer.question.id}.to_json
	else	
		{:status => 404, :message => @answer.errors.full_messages.first}.to_json
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
