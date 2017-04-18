<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Map</title>
<script>
	function initMap() {
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