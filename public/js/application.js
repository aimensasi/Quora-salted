$('#question-form').on('submit', function(e){
	e.preventDefault();
	// prevent user from submitting multipe times
	disableSubmit($(this));
	// enable submit button on form input
	enableSubmit($(this));
	//send post request
	sendPostRequest('/questions', $(this).serialize());
	//clear form input 
	$(this).find('input[type="text"]').val('');
});

function disableSubmit($form){
	$form.find('input[type="submit"]').attr('disabled', 'disabled');
}

function enableSubmit($form){
	$form.on('input', function(){
		$form.find('input[type="submit"]').removeAttr('disabled');
	});
}

// Handle Users Votes
$(document).on('click', '.btn-upvote, .btn-downvote', function(){
	var $upVote = "";
	var $downVote = "";
	var $question = $(this).parent().parent();
	var $upVoteText = $question.find('.upvote-txt span');
	var $downVoteText = $question.find('.downvote-txt span');
	var questionId = $question.attr('id');
	//when user wants to voteup on a question
	if ($(this).hasClass('btn-upvote')) {
		$upVote = $(this);
		$downVote = $question.find('.btn-downvote');

			// Update the view
			if ($upVote.hasClass('clicked')) {
				$upVote.removeClass('clicked');
				$upVote.text('Upvote');
				$upVoteText.text(parseInt($upVoteText.text()) - 1);
			}else{
					if ($downVote.hasClass('clicked')) {
						$downVote.text('Downvote');
					 $downVote.removeClass('clicked');
					 $downVoteText.text(parseInt($downVoteText.text()) - 1);
					}
				$upVote.text('Upvoted');	
				$upVote.addClass('clicked');
				$upVoteText.text(parseInt($upVoteText.text()) + 1);
			}
		// debugger;	
		sendPostRequest(`/questions/${questionId}/vote`, {'vote_type' : 'Upvote'});
	}else if ($(this).hasClass('btn-downvote')){
		$downVote = $(this);
		$upVote = $question.find('.btn-upvote');

			// update votes
			if ($downVote.hasClass('clicked')) {
				$downVote.removeClass('clicked');
				$downVote.text('Downvote');
				$downVoteText.text(parseInt($downVoteText.text()) - 1);
			}else{
				if ($upVote.hasClass('clicked')) { 
					$upVoteText.text(parseInt($upVoteText.text()) - 1);
					$upVote.text('Upvote');
					$upVote.removeClass('clicked');
				}
				$downVote.text('Downvoted');
				$downVote.addClass('clicked');
				$downVoteText.text(parseInt($downVoteText.text()) + 1);
			}
		sendPostRequest(`/questions/${questionId}/vote`, {'vote_type' : 'Downvote'});
	}
});

// Handle Answer Form Display
function displayAnswerForm($answerBox, $answerForm){
	if ($answerForm.children().length <= 1) {
		if ($answerBox.length) {
			$answerBox.remove();
		}
		var answerField = '<textarea name="answer" class="answer-field" rows="5" placeholder="Answer..."></textarea>';
		answerField += '<input type="submit" class="btn btn-outline-success btn-answer-submit" id="submit-a">';
		$answerForm.append(answerField);	
	}
}

//when user wants to add answer
$(document).on('click', '.btn-answer', function(){
		var $answerForm = $(this).parent().next();
		var $answerBox = $answerForm.next();
		displayAnswerForm($answerBox, $answerForm);
		
		$answerForm.off('submit').on('submit', function(e){
			e.preventDefault();
			// prevent user from submitting multipe times
			disableSubmit($(this));
			// enable submit button on form input
			enableSubmit($(this));
			// post an answer
			sendPostRequest('/answers', $answerForm.serialize());
		});
});

// display answer after submitting
function displayAnswer(data){
	var $question = $(`#${data['question_id']}`);
	$question.find('#answer-form').children().not('input[name="question_id"]').remove();
	$question.append(data['template']);
}


function displayQuestion(data){
	$('#questions').prepend(data['template']);
}

// handle ajax respnse of ok status
function onOkResponse(data){
	switch(data['type']){
		case 'answers':
			displayAnswer(data);
			break;
		case 'questions':
			displayQuestion(data);
			break;
		case 'votes':
			console.log(data['type']);
	}
}

// handle error messages
function onError(data){
	console.log('onError');
	console.log(data.type);
}

// send A POST Ajax Request
function sendPostRequest(url, data){
	
	$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json',
					cache: false,
					data: data,
					success: function(data){
						if (data['status'] == 200) {
							onOkResponse(data);
						}else{
							onError(data);
						}
					},
					error: function(err){
						console.log("ERROR");
						console.log(err);
					}
				});
}
















