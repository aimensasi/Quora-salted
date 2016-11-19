
#Make it work 
#Make it right
#make it fast, pretty and optimized

# post '/question-votes' do

# 	@vote = QuestionVote.voted?(params[:question_id], @current_user.id).first

# 	if @vote
# 		puts "Found #{@vote.inspect}"
# 		if @vote.vote_type == 'Upvote'
# 				@vote.vote_type = 'Downvote'
# 		elsif @vote.vote_type == 'Downvote'
# 				@vote.vote_type = 'Upvote'
# 		end
# 		return if @vote.save
# 	end

# 	@vote = QuestionVote.new
# 	puts "New #{@vote.inspect}"
# 	@vote.vote_type = params[:type]
# 	@vote.question = Question.find_by_id(params[:question_id])
# 	@vote.user = @current_user

# 	if @vote.save
# 		{:status => 200, :type => 'question_vote', :question_id => params[:question_id]}.to_json
# 	else
# 		{:status => 404, :type => 'question_vote', :question_id => params[:question_id]}.to_json
# 	end
# end


# delete '/question-votes/:id' do 
# 	@vote = QuestionVote.voted?(params[:question_id], @current_user.id).first
# 	@vote.delete
# end









