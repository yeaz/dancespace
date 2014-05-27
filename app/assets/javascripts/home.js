function loadEventsFeed() {
    $( "#listpane" ).hide();
    $( "#foot" ).hide(); 
    // $( "#sidebar" ).hide(); 
	url = "eventsfeed";
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
	$( "#finderheader").html("Studio Finder");
	$( "#eventheader").html("<strong>Events Feed</strong>");
    $( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadStudiosNearby() {
    $( "#listpane" ).hide();
    $( "#foot" ).hide();
    // $( "#sidebar" ).hide();
	url = "studiosnearby"
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
	$( "#finderheader").html("<strong>Studio Finder</strong>");
	$( "#eventheader").html("Events Feed");
	$( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

$(document).ready(function() {
	$( "#jstest" ).click(function() {
	  $( "#sidebar" ).hide();
	  $( "#sidebar").html("<h1>Randomizer</h1><p>Find a random dancer or video!</p><p><b>INSERT CONTROLS HERE</b></p>");
	  $( "#sidebar" ).fadeIn(1000);

	  $( "#listpane" ).hide();
	  $( "#listpane").html("<h1>Dancer Info</h1><h2>This is where the dancer would go</h2><p style='font-size:35px;'>and info about the dancer...basically use the script to get the data for a dancer and put it in the pane</p>");
	  $( "#listpane" ).fadeIn(1000);

	  $( "#foot" ).hide();
	  $( "#foot" ).fadeIn(1000);
	});

});
