get '/questions' do
	@questions = Question.all
	erb :"question/questions"
end

post '/questions' do 
	@question = Question.new(params)
	@question.user = @current_user
	if @question.save
		{:status => 200, :type => 'questions',  :template => erb(:'question/partials/question', :layout => false, :locals => {:question => @question})}.to_json
	else
		{:status => 400, :type => 'questions', :message => @question.errors.full_messages.first}.to_json
	end
end


get '/questions/:id' do
	@question = Question.find_by_id(params[:id])
	erb :"question/show_question"
end


get '/questions/:id/edit' do
	@question = Question.find_by_id(params[:id])
	if @question
		erb :"question/edit_question"
	else
		redirect to("/questions")
	end
end

patch '/questions/:id', allows: [:id, :title] do 
	@question = Question.find_by_id(params['id'])

	if @question.update_attributes(params)
		redirect to("/questions")
	else
		puts "ERROR #{@question.errors.full_messages}"
		redirect to("/question/#{params['id']}/edit")
	end
end


delete '/questions/:id' do
	@question = Question.find_by_id(params[:id])
	if @question.delete
		puts "User Was Deleted"
		redirect to('/questions')
	end
end
