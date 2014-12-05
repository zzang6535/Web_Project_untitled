function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(37.555775, 126.972472),
			zoom : 13,
		};
		var map = new google.maps.Map(document.getElementById('map'),
				mapOptions);		
		
		var inputStart =document.getElementById('start_search');
		var inputDest = document.getElementById('dest_search');
		var searchBar = document.getElementById('search_bar');
		var options = {
			componentRestrictions : {
				country : 'kr'
			}
		}
		
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBar);
		
		var autocompleteStart = new google.maps.places.Autocomplete(inputStart, options);
		var autocompleteDest = new google.maps.places.Autocomplete(inputDest, options);
		autocompleteStart.bindTo('bounds', map);
		autocompleteDest.bindTo('bounds', map);
		
		var infowindow = new google.maps.InfoWindow();
		var marker = new google.maps.Marker({
		    map: map,
		    anchorPoint: new google.maps.Point(0, -29)
		  });
		
		google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
			alert("event");
			/*var markers[];
			var place = autocompleteStart.getPlace();
			
			$.ajax({
				type :"post",
				url: "googlemap_show.jsp",
				data: {Pot : place},
				success : function(data){
					alert(data);
				
					var sss = data.split(",");
					markers.push(new google.maps.Marker({
						map: map,
						position: new google.maps.LatLng(sss[1], ss[2])
						})
					);
					
				},
				error : function(request,status,error){
					alert("request : " + request + "\n" + "status : " + status
							+ "\n" + "error : " + error);
				}
			});
			*/
		});	
}

google.maps.event.addDomListener(window, 'load', initialize);