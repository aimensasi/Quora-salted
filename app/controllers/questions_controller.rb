get '/questions' do
	@questions = Question.paginate(:page => params[:page], :per_page => 30)
	erb :"question/questions"
end

post '/questions' do 
	@question = Question.new(params)
	@question.user = @current_user
	if @question.save
		{:status => 200, :type => 'questions',  :template => erb(:'question/show_question', :layout => false, :locals => {:question => @question})}.to_json
	else
		{:status => 400, :type => 'questions', :message => @question.errors.full_messages.first}.to_json
	end
end


get '/questions/:id' do
	@question = Question.find_by_id(params[:id])
	erb :"question/show_question_answers"
end

patch '/questions/:id' do 
	@question = Question.find_by_id(params['id'])

	if @question.update_attributes(:title => params[:title])
		{:status => 200, :type => 'update_questions',  :title => @question.title, :question_id => @question.id}.to_json
	else
		{:status => 400, :type => 'update_questions', :message => @question.errors.full_messages.first}.to_json
	end
end

delete '/questions/:id' do
	@question = Question.find_by_id(params[:id])
	@question.destroy
	{:status => 200, :type => 'destroy_questions'}.to_json
end
