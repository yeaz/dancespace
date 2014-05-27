function loadEventsFeed() {
	url = "eventsfeed";
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
}

function loadStudiosNearby() {
	url = "studiosnearby"
	jQuery.get(url, function(data) {
		document.getElementById("listpane").innerHTML = data;
	});
}

	// $("#evbutton").click(function() {
	//    $( "#listpane" ).fadeOut( "fast", function() {
	//     // Animation complete
	//   });

	// 	  $( "#listpane" ).fadeIn( "slow", function() {
	//     // Animation complete
	//     alert("hey fading in");
	//   });
	// });


	// $("#stbutton").click(function() {
	// 	  $( "#listpane" ).fadeIn( "slow", function() {
	//     // Animation complete
	//     	    alert("hey fading in");
	//   });
	// });

