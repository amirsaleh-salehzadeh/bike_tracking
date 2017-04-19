<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Map</title>
<script>
	function initMap() {
<%if (request.getParameter("param") == null) {%>
	var myLatLng = {
			lat :
<%=request.getParameter("lat")%>
	,
			lng :
<%=request.getParameter("long")%>
	};
	var myOptions = {
			zoom : 10,
			center : myLatLng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_canvas"),
				myOptions);
		var marker = new google.maps.Marker({
			position : myLatLng,
			map : map,
			title : 'Hello World!'
		});

<%} else {
				String location = "";
				String req = request.getParameter("param");
				for (int i = 0; i < req.split(";").length; i++) {
					location += "{lat: " + req.split(";")[i].split(",")[0]
							+ ", lng: " + req.split(";")[i].split(",")[1] + "}";
					if ((i + 1) < req.split(";").length)
						location += ",";
				}%>
		var myLatLng = [
<%=location%>
	];
		var myOptions = {
			zoom : 10,
			center : myLatLng[0],
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_canvas"),
				myOptions);
		var RidePath = new google.maps.Polyline({
			path : myLatLng,
			geodesic : true,
			strokeColor : '#FF0000',
			strokeOpacity : 1.0,
			strokeWeight : 2
		});

		for(var i = 0 ; i <= myLatLng.length ; i++){
			var marker = new google.maps.Marker({
				position : myLatLng[i],
				map : map,
				title : 'Hello World!'
			});

			}

		RidePath.setMap(map);
<%}%>
	}
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDzM7cjbo3EJiW8nnTSBcY-fNIdppA_6AA&callback=initMap"
	type="text/javascript"></script>
<style>
html {
	height: 100%;
	overflow: hidden;
}

body {
	margin: 0;
	padding: 0;
	height: 100%;
}

#map_canvas {
	height: 100%;
}
</style>
</head>
<body onload="initMap()">
	<div id="map_canvas"></div>
</body>
</html>