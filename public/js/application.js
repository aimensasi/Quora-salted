$(document).ready(function(){
	sendGetRequest('/questions', 'html');
});

$(document).on('click', '.btn-answer', function(){
		var $answerForm = $(this).parent().next();
		var $answerBox = $answerForm.next();

		if ($answerForm.children().length <= 1) {

			if ($answerBox.length) {
				$answerBox.remove();
			}

			answerField = '<textarea name="answer" class="answer-field" rows="5" placeholder="Answer..."></textarea>';
			answerField += '<input type="submit" class="btn btn-outline-success btn-answer-submit" id="submit-a">';

			$answerForm.append(answerField);	
		}

		$answerForm.off('submit').on('submit', function(e){
			e.preventDefault();
			// prevent user from submitting multipe times
			$(this).find('input[type="submit"]').attr('disabled', 'disabled');
			// enable submit button on form input
			$(this).on('input', function(){
				$(this).find('input[type="submit"]').removeAttr('disabled');
			});
			// post an answer
			console.log('First');
			sendPostRequest('/answer/create', "html", $answerForm.serialize());
		});
});



function displayQuestions(data){
	$('#questions').append(data);
}

function displayAnswer(data){
	var $question = $(`#${data['question_id']}`);
	$question.find('#answer-form').children().not('input[name="question_id"]').remove();
	if ($question.has(data['template']).length == 0) {
				
	}
	$question.append(data['template']);
}

function sendGetRequest(url, dataType){
	if (url === null || url === "" || dataType === null || dataType === "") { return; }
	$.ajax({
		url: url,
		type: 'GET',
		dataType: dataType,
		cache: false,
		success: function(data){
			// console.log(data)
			displayQuestions(data);
		},
		error: function(err){
			console.log("ERROR: ");
			console.log(err);
		}
	});
}

// send A POST Ajax Request
function sendPostRequest(url, dataType, data){
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
								displayAnswer(data);
								console.log('got Answer');
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
















