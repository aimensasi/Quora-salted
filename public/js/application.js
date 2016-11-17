$('#question-form').on('submit', function(e){
	e.preventDefault();
	// prevent user from submitting multipe times
	disableSubmit($(this));
	// enable submit button on form input
	enableSubmit($(this));
	//send post request
	sendPostRequest('/questions/new', $(this).serialize());
	//clear form input 
	$(this).find('input[type="text"]').val('');
});

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
			console.log('First');
			sendPostRequest('/answers/new', $answerForm.serialize());
		});
});


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

		if ($upVote.hasClass('clicked')) {
			$upVote.removeClass('clicked');
			$upVoteText.text(parseInt($upVoteText.text()) - 1);
			sendDeleteRequest('/question-votes/:id', {'question_id': questionId});
		}else{
			if ($downVote.hasClass('clicked')) {
			 $downVote.removeClass('clicked');
			 $downVoteText.text(parseInt($downVoteText.text()) - 1);
			}

			$upVote.addClass('clicked');
			$upVoteText.text(parseInt($upVoteText.text()) + 1);
			sendPostRequest('/question-votes/new', {'question_id': questionId, 'type': 'Upvote'});
		}

	}else if ($(this).hasClass('btn-downvote')){
		$downVote = $(this);
		$upVote = $question.find('.btn-upvote');

		if ($downVote.hasClass('clicked')) {
			$downVote.removeClass('clicked');
			$downVoteText.text(parseInt($downVoteText.text()) - 1);
			sendDeleteRequest('/question-votes/:id', {'question_id': questionId});
		}else{
			if ($upVote.hasClass('clicked')) { 
				$upVoteText.text(parseInt($upVoteText.text()) - 1);
				$upVote.removeClass('clicked');
			}
			
			$downVote.addClass('clicked');
			$downVoteText.text(parseInt($downVoteText.text()) + 1);
			sendPostRequest('/question-votes/new', {'question_id': questionId, 'type': 'Downvote'});
		}
	}

	// if ($voteUp.hasClass('clicked')) {
	// 	$voteUp.removeClass('clicked');
	// 	sendDeleteRequest('/question-votes/:id', {'question_id': questionId});
	// }else if ($downVote.hasClass('clicked')){
	// 	$downVote.removeClass('clicked');
	// 	$voteUp.addClass('clicked');
	// 	sendPostRequest('/question-votes/new', {'question_id': questionId, 'type': 'Upvote'});
	// }
	
});




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

function disableSubmit($form){
	$form.find('input[type="submit"]').attr('disabled', 'disabled');
}

function enableSubmit($form){
	$form.on('input', function(){
		$form.find('input[type="submit"]').removeAttr('disabled');
	});
}

function displayQuestions(data){
	console.log(data['template']);
	$('#questions').prepend(data['template']);
}

function displayAnswer(data){
	var $question = $(`#${data['question_id']}`);
	$question.find('#answer-form').children().not('input[name="question_id"]').remove();
	$question.append(data['template']);
}

function sendDeleteRequest(url, data){
	$.ajax({
		url: url,
		type: 'DELETE',
		cache: false,
		data: data,
		success: function(data){
			console.log(data);
		},
		error: function(err){
			console.log(err);
		}
		
	});
}

function sendGetRequest(url, dataType){
	if (url === null || url === "" || dataType === null || dataType === "") { return; }
	$.ajax({
		url: url,
		type: 'GET',
		dataType: dataType,
		cache: false,
		success: function(data){
			console.log('Who?');
		},
		error: function(err){
			console.log("ERROR: ");
			console.log(err);
		}
	});
}

// send A POST Ajax Request
function sendPostRequest(url, data){
	console.log('Sending..');
	$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json',
					cache: false,
					data: data,
					success: function(data){
						switch(data['status']){
							case 200:
								switch(data['type']){
									case 'answers':
										console.log(data)
										displayAnswer(data);
										break;
									case 'questions':
										displayQuestions(data);
								}
							break;
							case 404:
							console.log(data['message']);
						}
					},
					error: function(jqXHR, textString, err){
						console.log(jqXHR['responseText']);
					}
				});
}
















