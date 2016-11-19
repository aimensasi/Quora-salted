

post '/answers' do 
	puts params.inspect
	@answer = Answer.new
	@answer.content = params[:answer]
	@answer.user = @current_user
	@answer.question = Question.find_by_id(params[:question_id])
	white_list = {
		:content => params[:answer],
		:user_id => @current_user.id,
		:question => params[:question_id]
	}
	if @answer.save
		{:status => 200, :type => 'answers',  :template => erb(:'answer/show_answer', :layout => false, :locals => {:answer => @answer}), :question_id => @answer.question.id}.to_json
	else	
		{:status => 400, :type => 'answers', :message => @answer.errors.full_messages.first}.to_json
	end
end

get '/answers/:id/edit' do
	@answer = Answer.find_by_id(params[:id])
	if @answer
		erb :"answer/edit_answer"
	else
		redirect to("/index")
	end
end

patch '/answers/:id', allows: [:id, :content] do 
	@answer = Answer.find_by_id(params['id'])

	if @answer.update_attributes(params)
		redirect to("/index")
	else
		puts "ERROR #{@answer.errors.full_messages}"
		redirect to("/answer/#{params['id']}/edit")
	end
end

get '/answers/:id' do
	@answer = Answer.find_by_id(params[:id])
	@answer.delete
	redirect back
end
