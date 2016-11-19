

# get '/answers/new' do 
# 	{:status => 200, :type => 'answers', :template => (erb :'answer/new_answer', :layout => false, :locals => {:question_id => params[:question_id]})}.to_json
# end


post '/answers' do 
	puts params.inspect
	question = Question.find_by_id(params[:question_id])
	puts "Q #{question}"
	return ({:status => 404, :type => 'answers', :message => "Question Not Found"}.to_json) if question.nil?
	white_list = {
		:content => params[:answer],
		:user_id => @current_user.id,
		:question_id => question.id
	}
	@answer = Answer.new(white_list)
	if @answer.save
		{:status => 200, :type => 'answers',  :template => erb(:'answer/show_answer', :layout => false, :locals => {:answer => @answer}), :question_id => @answer.question.id}.to_json
	else
		puts 	"Error"
		{:status => 400, :type => 'answers', :message => @answer.errors.full_messages.first}.to_json
	end
end

patch '/answers/:id' do 
	@answer = Answer.find_by_id(params[:id])

	if @answer.update_attributes(:content => params[:content])
		{:status => 200, :type => 'update_answers',  :content => @answer.content, :answer_id => @answer.id}.to_json
	else
		{:status => 400, :type => 'update_answers', :message => @answer.errors.full_messages.first}.to_json
	end
end


delete '/answers/:id' do
	@answers = Answer.find_by_id(params[:id])
	@answers.destroy
	{:status => 200, :type => 'destroy_answers'}.to_json
end

