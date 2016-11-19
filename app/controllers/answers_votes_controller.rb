#Make it work 
#Make it right
#make it fast, pretty and optimized

post '/answers/:id/vote' do
	message = {}
	vote_type = params[:vote_type]
	@answer = Answer.find_by_id(params[:id])
	return {:status => 400, :type => 'votes', :message => "answer Does Not Exist"}.to_json if @answer.nil?
	@vote = AnswerVote.voted?(@answer.id, @current_user.id).first
	if @vote
		if @vote.vote_type.eql?(vote_type)
			@vote.delete
			message = {:status => 200, :type => 'votes', :vote_type => @vote.vote_type, :action => "Delete Vote"}
		else
			@vote.update(:vote_type => vote_type)
			message = {:status => 200, :type => 'votes', :vote_type => @vote.vote_type, :action => "Update Vote"}
		end
	else
		white_list = {
			:answer_id => @answer.id,
			:user_id => @current_user.id,
			:vote_type => vote_type
		}
		vote = AnswerVote.new(white_list)
		if vote.save
			message = {:status => 200, :type => 'votes', :vote_type => vote.vote_type}
		else
			flash[:notice] = "Something Went Terribly Wrong! #{vote.errors.full_messages}"
			message = {:status => 400, :type => 'votes', :message => "Something Went Terribly Wrong! #{vote.errors.full_messages}"}
		end	
	end
	message.to_json
end
