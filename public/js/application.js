$(document).ready(function(){
	sendGetRequest('/questions', 'html');
});

$(document).on('click', '.btn-answer', function(){
		answerField = '<textarea name="answer" class="answer-field" rows="5" placeholder="Answer..."></textarea>';
		answerField += '<input type="submit" class="btn btn-outline-success btn-answer-submit" id="submit-a">';
		$answerForm = $(this).parent().next();
		$answerForm.append(answerField);
		$answerForm.on('submit', function(e){
			e.preventDefault();
			sendPostRequest('/answer/create', "html", $answerForm.serialize());
		});
});


function displayQuestions(data){
	$('#questions').append(data);
}

function displayAnswer(data){
	console.log(data);
	var $question = $(`#${data['question_id']}`);
	$question.find('#answer-form').remove();
	$question.find('#answer-box').css('background-color', '#f6f7f9').append(data['template']);
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
















