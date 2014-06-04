function autosearchstudios(input, resultsdivID){
	var results_container = document.getElementById(resultsdivID);
	if(input.length>1){
		searchStudios(results_container, input);
	}else if(input.length==0){
		displayAllStudios(results_container);
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


