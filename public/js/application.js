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
	var $parent = $(this).parent().parent();
	var $upVoteText = $parent.find('.upvote-txt span');
	var $downVoteText = $parent.find('.downvote-txt span');
	var parentId = $parent.attr('id');
	//when user wants to voteup on a parent
	if ($(this).hasClass('btn-upvote')) {
		$upVote = $(this);
		$downVote = $parent.find('.btn-downvote');

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
		sendPostRequest(`/${$parent.attr('data_name')}/${parentId}/vote`, {'vote_type' : 'Upvote'});
	}else if ($(this).hasClass('btn-downvote')){
		$downVote = $(this);
		$upVote = $parent.find('.btn-upvote');

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
		sendPostRequest(`/${$parent.attr('data_name')}/${parentId}/vote`, {'vote_type' : 'Downvote'});
	}
});

//when user wants to add answer
$(document).on('click', '.btn-answer', function(){
		var question_id = $(this).parent().attr('data_parent');
		var $questionBox = $('#questions').find('#' + question_id);
		var $answerBox = $questionBox.find('.answer-box');
		var answerForm = '<form class="answer-form flex flex-col" id="answer-form" data_parent="'+ question_id +'">';
		answerForm += '<input type="hidden" name="question_id" value="' + question_id + '">';
		answerForm += '<textarea name="answer" class="answer-field" rows="5" placeholder="Answer..."></textarea>';
		answerForm += '<input type="submit" class="btn btn-outline-success btn-answer-submit" id="submit-a">';
		answerForm += '</form>'
		console.log('Clicked');
		if ($questionBox.find('.answer-form').length == 0) {
			console.log(')))0');
			if ($answerBox.length > 0) {
				console.log(')))1');
				$answerBox.remove();
			}
			$questionBox.append(answerForm);
			console.log($questionBox);
		}

		$questionBox.find('.answer-form').off('submit').on('submit', function(e){
			e.preventDefault();
			// prevent user from submitting multipe times
			disableSubmit($(this));
			// enable submit button on form input
			enableSubmit($(this));
			// post an answer
			sendPostRequest('/answers', $(this).serialize());
		});
});

// display answer after submitting
function displayAnswer(data){
	var $question = $(`#${data['question_id']}`);
	var $answerForm = $question.find('#answer-form');
	var $answerList = $question.next('#answers-list');
	var $answerCount = $question.find('.answer-txt span');
	
	$answerCount.text(parseInt($answerCount.text()) + 1);

	if ($answerForm.length > 0) {
				$answerForm.remove();
		}
	if ($answerList.length > 0) {
		$answerList.prepend(data.template);
	}else{
		$question.append(data.template);	
	}	
	
}


function displayQuestion(data){
	$('#questions').prepend(data.template);
}

$(document).on('click', '#edit', function(){
	var $popForm = $($(this).parent().parent().next('#edit_question').get(0));
	$($popForm).modal('show');
});


$(document).on('submit', '#update-form', function(e){
		e.preventDefault();
		var $popForm = $($(this).parent().parent().get(0));
		var $updateForm = $(this);
		var parent = $updateForm.attr('data_name');
		var parentId = $updateForm.attr('data_parent');
		
		$popForm.modal('hide');

		sendPatchRequest(`/${parent}/${parentId}`, $updateForm.serialize());
});

function updateQuestion(data){
	console.log(data);
	var $question = $(`#${data.question_id}`);
	$question.find('.title').text(data.title);
}

function updateAnswer(data){
	console.log(data);
	var $answer = $('#' + data.answer_id);
	$answer.find('.content').text(data.content);
}


$(document).on('click', '#delete', function(){
	var $deleteBtn = $(this);
	var $parent = $('#' + $deleteBtn.attr('data_parent'));
	var parentId = $deleteBtn.attr('data_parent');
	var parentName = $deleteBtn.attr('data_name');

	$parent.remove();
	sendDeleteRequest(`/${parentName}/${parentId}` , {'type' : parentName});
});




// handle ajax respnse of ok status
function onOkResponse(data){
	switch(data.type){
		case 'answers':
			displayAnswer(data);
			break;
		case 'questions':
			displayQuestion(data);
			break;
		case 'votes':
			console.log(data.type);
			break;
		case 'update_questions':
			updateQuestion(data);
			break;
		case 'update_answers':
			updateAnswer(data);
			break;
		case 'delete_questions':
			console.log(data.type);
			break;
		case 'delete_answers':
			console.log(data.type);
	}
}

// handle error messages
function onError(data){
	console.log('onError');

	console.log(data.type);
	console.log(data.message);
	console.log(data);
}

// send A POST Ajax Request
function sendPostRequest(url, data){
	console.log(data);
	$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json',
					cache: false,
					data: data,
					success: function(data){
						if (data.status == 200) {
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

function sendPatchRequest(url, data){

	$.ajax({
		url: url,
		type: 'PATCH',
		dataType: 'json',
		cache: false,
		data: data,
		success: function(data){
			if (data.status == 200) {
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

function sendDeleteRequest(url, data){

	$.ajax({
		url: url,
		type: 'DELETE',
		dataType: 'json',
		cache: false,
		data: data,
		success: function(data){
			if (data.status == 200) {
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















