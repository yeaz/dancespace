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
	$( "#randomheader").html("Randomizer");
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
	$( "#randomheader").html("Randomizer");
	$( "#listpane" ).fadeIn(750);
	$( "#foot" ).fadeIn(750);
	// $( "#sidebar" ).fadeIn(750);
}

function loadRandomizer(type) {
	  $( "#finderheader").html("Studio Finder");
	  $( "#eventheader").html("Events Feed");
	  $( "#randomheader").html("<strong>Randomizer</strong>");

	  $( "#listpane" ).hide();
	  $( "#foot" ).hide();
	  // url = "random_user";
	  // if (type == "dancer") 
	  // 	url = "random_user";
	  // else {
	  // 	get_it();
	  // }
// 0. get dancer object
// 1. populate listpane with dancer data
	url = "random_user";
	jQuery.get(url, function(data) {
		console.log(data);
		console.log(data.email);
		$("#listpane").html("<h1><b>Random dancer: <a href='/users/" + data.id + "'>"
			+ data.first_name + " " + data.last_name 
			+ "</a></b></h1>"
			+ "<div class='col-md-6'>"
			+	"<div class='listing-blurb'><h5>" 
			+ data.blurb 
			+ "</h5></div>"
			+ "</div>"
			+ "<p class='lead'>info about the dancer...basically use the script to get the data for a dancer and put it in the pane..</p>");
	});

	  $( "#listpane" ).fadeIn(750);
	  $( "#foot" ).fadeIn(750);
}

