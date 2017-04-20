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
				String ids = "";
				String names ="";
				String req = request.getParameter("param");
				for (int i = 0; i < req.split(";").length; i++) {
					location += "{lat: " + req.split(";")[i].split(",")[0]
							+ ", lng: " + req.split(";")[i].split(",")[1] + "}";
							ids+="'"+req.split(";")[i].split(",")[2]+"'";
							names+= "'"+req.split(";")[i].split(",")[3]+"'";
					if ((i + 1) < req.split(";").length){
						location += ",";
						ids += ",";
						names += ",";
					}
				}%>
		var myLatLng = [
<%=location%>
	];
		var ids = [<%=ids%>];
		var names = [<%=names%>];
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

		for(var i = 0 ; i < myLatLng.length ; i++){
			var marker = new google.maps.Marker({
				position : myLatLng[i],
				map : map,
				title : names[i]
			});
			var longpress = false;
			var tmp = "'ServletRaceManagement?reqCode=removeCheckPoint&checkpointId="+ids[i]+"&rhid=<%=request.getParameter("rhid")%>'";
		    google.maps.event.addListener(marker,'click', function (event) {
			    if(longpress){
					$("div#mainBodyContent").load(tmp);
				           }
		        });
		    google.maps.event.addListener(marker, 'mousedown', function(event){
		                start = new Date().getTime();           
		            });
		    google.maps.event.addListener(marker, 'mouseup', function(event){
		                end = new Date().getTime();
		                    longpress = (end - start < 2000) ? false : true;         
		            });
			}
		RidePath.setMap(map);
<%} %>

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