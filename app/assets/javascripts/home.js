function loadEventsFeed() {
    $( "#listpane" ).hide();
    $( "#foot" ).hide(); 
    // $( "#sidebar" ).hide(); 
	url = "eventsfeed_title";
	jQuery.get(url, function(data) {
                document.getElementById("page_title").innerHTML = data; 
	//	document.getElementById("listpane").innerHTML = data;
	});
	$( "#finderheader").html("Studio Finder");
	$( "#eventheader").html("<strong>Events Feed</strong>");
	$( "#randomheader").html("Randomizer");
    $( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadStudiosNearby() {
    $( "#listpane" ).hide();
    $( "#foot" ).hide();
    // $( "#sidebar" ).hide();
	url = "studiosfeed_title"
	jQuery.get(url, function(data) {
		document.getElementById("page_title").innerHTML = data;
	});
	$( "#finderheader").html("<strong>Studio Finder</strong>");
	$( "#eventheader").html("Events Feed");
	$( "#randomheader").html("Randomizer");
	$( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadRandomizer() {
	  $( "#finderheader").html("Studio Finder");
	  $( "#eventheader").html("Events Feed");
	  $( "#randomheader").html("<strong>Randomizer</strong>");

	  $( "#listpane" ).hide();
	  $( "#foot" ).hide();
	  $( "#listpane").html("<h1>Dancer Info</h1><h2>This is where the dancer would go</h2><p style='font-size:35px;font-family:monospace;font-weight:100'>and info about the dancer...basically use the script to get the data for a dancer and put it in the pane...<br><br>where should i put the option for dancer or video?</p>");
	  $( "#listpane" ).fadeIn(750);
	  $( "#foot" ).fadeIn(750);
}
