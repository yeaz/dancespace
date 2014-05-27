function loadEventsFeed() {
    $( "#listpane" ).hide(); 
	url = "eventsfeed";
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
    $( "#listpane" ).fadeIn(500);
}

function loadStudiosNearby() {
    $( "#listpane" ).hide();
	url = "studiosnearby"
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
	$( "#listpane" ).fadeIn(500);
}