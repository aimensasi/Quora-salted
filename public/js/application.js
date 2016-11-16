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
			console.log($answerForm.serialize());
			sendPostRequest('/', dataType, );
		});
});


function displayQuestions(data){
	$('#questions').append(data);
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
		error: function(data){
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
					dataType: dataType,
					cache: false,
					data: data,
					success: function(data){
						switch(data.status){
							case '208': //Url Already exist
								console.log(data);
								populateForm(data);
							break;
							case '200': //url was created and saved successfully
								populateForm(data);
							break;
							case '400': //invalid or blank input 
								displayError(data);
						}

					},
					error: function(err){
						console.log("ERROR: ");
						console.log(err);
					}
				});
}
















