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
		}
	}else if(input.length==0){
		switch(type){
			case "studio":
				displayAllStudios(results_container);
				break;
			case "dancer":
				displayAllDancers(results_container);
		}
	}
}

function searchDancers(container, input){
	url = "autosearch_dancers?query=" + input;
	jQuery.get(url, function(data){
		var HTML = "";
		if(data.length>0){
			for(var i=0; i<data.length; i++){
				HTML+=createDancerListing(data[i]);
			}
		}
		container.innerHTML = HTML;
	});
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

function createStudioListing(entry){
	var string = "<div class=\"row\">" + 
				"<div class=\"listing-photo col-md-2\"><img src=\"/assets/studio1.jpg\"></div>" + 
				"<div class=\"listing-info col-md-6\">" +
					"<h3><b><a href= \"/studios/" + entry.id + " \" data-no-turbolink=\"true\" >" + entry.name + " </a></h3></b>" +  
					"<div class=\"listing-blurb\"><h5>" + entry.description + "</h5></div>" +
				"</div>" + 
				"<div class=\"col-md-4 social-media\">" + 
					"<h4>" + entry.address_line1 +"<br/> " + entry.city+", "+entry.state + entry.zip_code + "</h4>" +
					"<b>E-MAIL: </b>" + entry.email + " <br/>" + 
					"<b>PHONE: </b>(" + entry.phone_area_code + ") " + entry.phone_1 + "-" + entry.phone_2 + 
				"</div></div><hr>";
	return string;
}

function createDancerListing(entry){
	var string = "<div class=\"row\">" +
				"<div class=\"listing-photo col-md-2\"><img src=\"assets/blank_profile.jpg\"></div>" +  
				"<div class=\"col-md-6\">" + 
					"<h3><b><a href=\"/users/" + entry.id + "\" data-no-turbolink=\"true\">" + entry.first_name + " " + entry.last_name + "</a></b></h3>" +
					"<div class=\"listing-blurb\"><h5>" + entry.blurb + "</h5></div>" + 
				"</div>" + 
				"<div class=\"col-md-4 social-media\">" + 
					"<h4>" + entry.city + ", " + entry.state + "</h4>" +
					"<b>E-MAIL:</b>" + entry.email + "<br/>" + 
					"<b>PHONE: </b>(" + entry.phone_area_code + ") "+ entry.phone_1 + "-" + entry.phone_2 + 
				"</div><hr></div>";
	return string;
}


