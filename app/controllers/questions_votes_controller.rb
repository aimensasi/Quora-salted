#Make it work 
#Make it right
#make it fast, pretty and optimized

post '/questions/:id/vote' do
	message = {}
	vote_type = params[:vote_type]
	@question = Question.find_by_id(params[:id])
	return {:status => 400, :type => 'votes', :message => "Question Does Not Exist"}.to_json if @question.nil?
	@vote = QuestionVote.voted?(@question.id, @current_user.id).first
	if @vote
		if @vote.vote_type.eql?(vote_type)
			@vote.delete
			message = {:status => 200, :type => 'votes', :vote_type => @vote.vote_type, :action => "Delete Vote"}
		else
			@vote.update(:vote_type => vote_type)
			message = {:status => 200, :type => 'votes', :vote_type => @vote.vote_type, :action => "Update Vote"}
		end
	else
		vote = QuestionVote.new
		vote.question = @question
		vote.user = @current_user
		vote.vote_type = vote_type
		if vote.save
			message = {:status => 200, :type => 'votes', :vote_type => vote.vote_type}
		else
			flash[:notice] = "Something Went Terribly Wrong! #{vote.errors.full_messages}"
			message = {:status => 400, :type => 'votes', :message => "Something Went Terribly Wrong! #{vote.errors.full_messages}"}
		end	
	end
	message.to_json
end
