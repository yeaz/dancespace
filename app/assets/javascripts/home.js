var randomUsedLast = false;

function resetMapper() {

    $("#listpane").html("<div id='page_title'></div>"
    	+ "<div id='panel'>"
    	+ "<input id='events_feed_address' type='textbox' class='form-group' placeholder='Stanford, CA'/> "
    	+ "<input type='submit' onclick='codeAddressAndUpdateEvents()' class='btn btn-default' value='Go to new address'/>"
    	+ "</div>"
		+ "<div id='events_feed_error'></div>"
		+ "<div id='all_events'></div>"
		+ "<br>"
		+ "<div id='events-feed-map-canvas'></div>");
}



function loadEventsFeed() {
    // $( "#listpane" ).hide();
   // $( "#foot" ).hide(); 
    // $( "#sidebar" ).hide(); 
    if (randomUsedLast) {
    	resetMapper();    						  
    	randomUsedLast = false;
    }
	url = "eventsfeed_title";
	jQuery.get(url, function(data) {
                document.getElementById("page_title").innerHTML = data; 
	});
    loadFeedMap("/get_events_in_bounds"); 
	$( "#finderheader").html("Studio Finder");
	$( "#eventheader").html("<strong>Events Feed</strong>");
	$( "#randomheader").html("Randomizer");
 //   $( "#listpane" ).fadeIn(750);
//	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadStudiosNearby() {
  //  $( "#listpane" ).hide();
    //$( "#foot" ).hide();
    // $( "#sidebar" ).hide();
    if (randomUsedLast) {
    	resetMapper();    						  
    	randomUsedLast = false;
    }
	url = "studiosfeed_title"
	jQuery.get(url, function(data) {
		document.getElementById("page_title").innerHTML = data; // needs work
	});
    loadFeedMap("/get_studios_in_bounds"); 
	$( "#finderheader").html("<strong>Studio Finder</strong>");
	$( "#eventheader").html("Events Feed");
	$( "#randomheader").html("Randomizer");
//	$( "#listpane" ).fadeIn(750);
//	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadRandomizer(type) {
	randomUsedLast = true;
	// Animations
	  $( "#finderheader").html("Studio Finder");
	  $( "#eventheader").html("Events Feed");
	  $( "#randomheader").html("<strong>Randomizer</strong>");

	  $( "#listpane" ).hide();
	  $( "#foot" ).hide();
	// Logging
	  console.log(type);

	// Random Dancer
	if (type == "dancer") {
		url = "random_user";
		jQuery.get(url, function(data) {
		$("#listpane").html("<h1>Random Dancer</h1>"
			+ "<div class='col-md-5' style='padding-bottom:20px;'>"
			+ "<img src='/assets/blank_profile.jpg'>"
			+ "</div>"
			+ "<div class='col-md-4' >"
			+ "<h2><a href='/users/" + data.id + "'>"
			+ data.first_name + " " + data.last_name 
			+ "</a></h2>"
			+	"<div class='listing-blurb'><h5>" 
			+ data.email + "<br>" + data.blurb 
			+ "</h5></div>"
			+ "</div>");
			// TODO: insert videos eventually
		});
	}
	else {
		url = "random_video";
		jQuery.get(url, function(data) {
			console.log(data);
			$("#listpane").html("<h1>Random Video</h1>"
				// video box
				+ "<div class='col-md-8' style='padding-bottom:20px; margin-right:15px;' id='video'>"
				+ "<iframe width='560' height='315' src='//www.youtube.com/embed/" 
				+ data.youtube_id 
				+ "?rel=0' frameborder='0' allowfullscreen></iframe>"
				+ "</div>"
				// description
				+ "<div class='col-md-3'>"
				+ "<h2><a href='/videos/" + data.id + "'>" + data.title + "</a></h2>"
				+ "<p class='lead' style='font-size:150%'>" + data.description + "</p>"
				+ "</div>");
		});	
	}

	// Animations
	$( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
}
