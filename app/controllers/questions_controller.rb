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
		{:status => 404, :message => @question.errors.full_messages.first}.to_json
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

post '/questions/:id/vote-up' do
	message = {}
	@question = Question.find_by_id(params[:id])
	@vote = QuestionVote.voted?(params[:id], @current_user.id).first
	if @vote
		if @vote.upvote?
			@vote.delete
			message = {:status => 200, :vote_type => @vote.vote_type, :action => 'deleted vote'}.to_json
		else
			@vote.update(:vote_type => 'Upvote')
			message = {:status => 200, :vote_type => @vote.vote_type, :action => 'updated vote'}.to_json
		end
	else
		vote = QuestionVote.new
		vote.question = @question
		vote.user = @current_user
		vote.vote_type = 'Upvote'
		if vote.save
			message = {:status => 200, :vote_type => vote.vote_type}.to_json
		else
			flash[:notice] = "Something Went Terribly Wrong! #{vote.errors.full_messages}"
			message = {:status => 400, :message => "Something Went Terribly Wrong! #{vote.errors.full_messages}"}.to_json
		end	
	end
	puts message
	message
end

post '/questions/:id/vote-down' do 
	message = {}
	@question = Question.find_by_id(params[:id])
	@vote = QuestionVote.voted?(params[:id], @current_user.id).first
	if @vote
		if @vote.downvote?
			@vote.delete
			message = {:status => 200, :vote_type => @vote.vote_type, :action => 'deleted vote'}.to_json
		else
			@vote.update(:vote_type => 'Downvote')
			message = {:status => 200, :vote_type => @vote.vote_type, :action => 'updated vote'}.to_json
		end
	else
		vote = QuestionVote.new
		vote.question = @question
		vote.user = @current_user
		vote.vote_type = 'Downvote'
		if vote.save
			message = {:status => 200, :vote_type => vote.vote_type}.to_json
		else
			flash[:notice] = "Something Went Terribly Wrong! #{vote.errors.full_messages}"
			message = {:status => 400, :message => "Something Went Terribly Wrong! #{vote.errors.full_messages}"}.to_json
		end	
	end
	puts message
	message
end







