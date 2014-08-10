var board_size = 4
$(document).ready(function () {
	$('#evaluate_spinner').hide();






});



function evaluate_board(){
	console.log("u tryin to do the request");
	$('#evaluate_spinner').show();
	var board_string = document.getElementById("board_string").value;
	// document.getElementById("loading_view").showwww
	var url = 'evaluate/' + board_string.slice(0, (board_size * board_size))

	$.ajax({
	  type: "GET",
	  url: url
	})
	  .done(function( html_response ) {
		console.log("udid the ajax request");
	    document.getElementById("results").innerHTML = html_response;
	    $('#evaluate_spinner').hide();
	  });




}


function update_board_view(){
	console.log("updating board view right now");
	console.log(document.getElementById("board_string").value);
	var board_string = document.getElementById("board_string").value;
	if (board_size == 4){
		console.log("is 4!!");
		for (var i = 0; i < board_string.length && i < 16 ; i++) {
			document.getElementById("td" + i).innerHTML = board_string[i];
		}
	}
	return 0;
}



