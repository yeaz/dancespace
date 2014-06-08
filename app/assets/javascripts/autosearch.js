function allautosearch(input, resultsID){
	var container = document.getElementById(resultsID);
	container.innerHTML="<p id=\"search-notif\">Press esc to cancel search.</p><br/>";
	container.style.visibility = "visible";


	if(input.length > 1){
		//search dancers
		url = "/autosearch_dancers?query=" + input;
		jQuery.get(url, function(data){
			if(data.length>0){
				container.innerHTML += "<h3>Dancers</h3><p> &nbsp;<i>(" + data.length + " results)</i></p><br/>";
				for(var i=0; i<data.length; i++){
					container.innerHTML+=miniListing(data[i], "dancer");
				}
			}
		});

		//search studios
		url = "/autosearch_studios?query=" + input;
		jQuery.get(url, function(data){
			if(data.length>0){
				container.innerHTML += "<h3>Studios</h3><p> &nbsp;<i>(" + data.length + " results)</i></p><br/>";
				for(var i=0; i<data.length; i++){
					container.innerHTML+=miniListing(data[i], "studio");
				}				
			}
		});
		
		//search events
		url = "/autosearch_events?query=" + input;
		jQuery.get(url, function(data){
			if(data.length>0){
				container.innerHTML += "<h3>Events</h3><p> &nbsp;<i>" + data.length + " results)</i></p>";
				for(var i=0; i<data.length; i++){
					container.innerHTML +=miniListing(data[i], "event");
				}				
			}
		});

		//search tags
		url = "/autosearch_tags?query=" + input;
		jQuery.get(url, function(data){
			if (data != null){
				container.innerHTML += "<h3>Tags</h3>";
				container.innerHTML += miniListing(data, "tag");
			}
		});
	}

	// esc	
	$(document).keyup(function(e) {
	  if (e.keyCode == 27) {
		container.style.visibility = "hidden";
		}   
	});
}



function autosearch(input, resultsdivID, type){
	var results_container = document.getElementById(resultsdivID);
	if(input.length>1){
		switch(type){
			case "studio":
				searchStudios(results_container, input);
				break;
			case "dancer":
				searchDancers(results_container, input);
				break;
			case "event":
				searchEvents(results_container, input);
				break;
		}
	}else if(input.length==0){
		switch(type){
			case "studio":
				displayAllStudios(results_container);
				break;
			case "dancer":
				displayAllDancers(results_container);
				break;
			case "event":
				displayAllEvents(results_container);
				break;
		}
	}
}


function searchStudios(container, input){
	url = "autosearch_studios?query=" + input;
	jQuery.get(url, function(data){
		var HTML = "";
		if(data.length==0){
			container.innerHTML = "";
		}else{
			for(var i=0; i<data.length; i++){
				HTML+=createStudioListing(data[i]);
				container.innerHTML = HTML;
			}
		}
	});
}

function searchDancers(container, input){
	url = "autosearch_dancers?query=" + input;
	jQuery.get(url, function(data){
		var HTML = "";
		for(var i=0; i<data.length; i++){
			HTML+=createDancerListing(data[i]);
		}
		container.innerHTML = HTML;
	});
}

function searchEvents(container, input){
	url = "autosearch_events?query=" + input;
	jQuery.get(url, function(data){
		var HTML = "";
		for(var i=0; i<data.length; i++){
			HTML +=createEventListing(data[i]);
		}
		container.innerHTML = HTML;
	});
}

function displayAllStudios(container){
	url = "all_studios";
	jQuery.get(url, function(data){
		var HTML = "";
		for(var i = 0; i < data.length; i++){
			HTML+=createStudioListing(data[i]);
		}
		container.innerHTML= HTML;
	});
}

function displayAllDancers(container){
	url = "all_dancers";
	jQuery.get(url, function(data){
		var HTML = "";
		for(var i=0; i<data.length; i++){
			HTML+=createDancerListing(data[i]);
		}
		container.innerHTML = HTML;
	});
}

function displayAllEvents(container){
	url = "all_events";
	jQuery.get(url, function(data){
		var HTML = "";
		for(var i=0; i<data.length; i++){
			HTML +=createEventListing(data[i]);
		}
		container.innerHTML = HTML;
	})
}

function createStudioListing(entry){
	var string = "<div class=\"row\">" + 
				"<div class=\"listing-photo col-md-2\">";
				if(entry.photo_path!="" && entry.photo_path!=null){
					string+="<img src='/images/" + entry.photo_path + "'>";
				}else{
					string+="<img src=\"/assets/studio1.jpg\">";
				}
				string+= "</div><div class=\"listing-info col-md-6\">" +
					"<h3><b><a href= \"/studios/" + entry.id + " \" data-no-turbolink=\"true\" >" + entry.name + " </a></h3></b>" +  
					"<div class=\"listing-blurb\"><h5>" + entry.description + "</h5></div>" +
				"</div>" + 
				"<div class=\"col-md-4 social-media\">" + 
					"<h4>" + entry.address_line1 +"<br/> " + entry.city+", "+entry.state + entry.zip_code + "</h4>" +
					"<b>E-MAIL: </b>" + entry.email + " <br/>";
				if(entry.phone_area_code!="" && entry.phone_area_code!=null){
					string+="<b>PHONE: </b>(" + entry.phone_area_code + ") " + entry.phone_1 + "-" + entry.phone_2;
				}
				string+="</div></div><hr>";
	return string;
}

function createDancerListing(entry){
	var string = "<div class=\"row\">" +
				"<div class=\"listing-photo col-md-2\">";
				if(entry.photo_path!="" && entry.photo_path!=null){
					string+="<img src='/images/" + entry.photo_path + "'>";
				}else{
					string+="<img src=\"assets/blank_profile.jpg\">";
				}
				string+= "</div><div class=\"col-md-6\">" + 
					"<h3><b><a href=\"/users/" + entry.id + "\" data-no-turbolink=\"true\">" + entry.first_name + " " + entry.last_name + "</a></b></h3>" +
					"<div class=\"listing-blurb\"><h5>" + entry.blurb + "</h5></div>" + 
				"</div>" + 
				"<div class=\"col-md-4 social-media\">";
					if(entry.city!="" && entry.city!= null){
						string += "<h4>" + entry.city + ", " + entry.state + "</h4>";
					}
					string += "<b>E-MAIL:</b>" + entry.email + "<br/>";
					if(entry.phone_area_code!="" && entry.phone_area_code!=null){
						string += "<b>PHONE: </b>(" + entry.phone_area_code + ") "+ entry.phone_1 + "-" + entry.phone_2;
					} 
					
				string += "</div></div><hr>";
	return string;
}


function createEventListing(entry){
	var string = "<h3><b><a href=\"/events/" + entry.id + "\"  data-no-turbolink=\"true\">" + entry.name + "</a></b></h3>" +
	  "<div>Description:" + entry.description + "</div>" +
	  "<div>Created by: <a href=\"/studios/" + entry.studio_id + "\">" + "STUDIO" + "</a></div>" +
 	  "<div>Date:" + entry.event_date  + "</div>" +
          "<div>Time:" + entry.event_time + "</div>";
	return string;
}

function miniListing(entry, type){
	var string = "";
	switch(type){
		case "dancer":
			string+="<h5><a href=\"/users/" + entry.id + "\" data-no-turbolink=\"true\">" + entry.first_name + " " + entry.last_name + "</a></h5>";
			break;
		case "studio":
			string+="<h5><a href= \"/studios/" + entry.id + " \" data-no-turbolink=\"true\" >" + entry.name + " </a></h5>";
			break;
		case "event":
			string +="<h5><a href=\"/events/" + entry.id + "\"  data-no-turbolink=\"true\">" + entry.name + "</a></h5>"
			break;
		case "tag":
			string +="<h5><a href=\"/tags/" + entry.id + "\"  data-no-turbolink=\"true\">" + entry.name + "</a></h5>";
	} 
	return string;
}


