get '/index' do
	@questions = Question.all
	erb :"question/index"
end

# get '/question/new' do 
# 	@question = Question.new
# 	puts "New Question"
# 	erb :"question/new_question"
# end

get '/questions' do 
	@questions = Question.all
	erb :'question/questions', :layout => false
end

post '/question/create' do 
	@question = Question.new(params)
	@question.user = @current_user
	if @question.save
		redirect to('/index')
	else
		puts "ERROR #{@question.errors.full_messages}"
		redirect to('/question/new')
	end
end

get '/question/:id' do 
	@question = Question.find_by_id(params[:id])
	erb :"question/show_question"
end

get '/question/:id/edit' do
	@question = Question.find_by_id(params[:id])
	if @question
		erb :"question/edit_question"
	else
		redirect to("/index")
	end
end

patch '/question/update', allows: [:id, :title, :description] do 
	@question = Question.find_by_id(params['id'])

	if @question.update_attributes(params)
		redirect to("/index")
	else
		puts "ERROR #{@question.errors.full_messages}"
		redirect to("/question/#{params['id']}/edit")
	end
end

get '/question/:id/delete' do
	@question = Question.find_by_id(params[:id])
	if @question.delete
		puts "User Was Deleted"
		redirect to('/index')
	end
end
