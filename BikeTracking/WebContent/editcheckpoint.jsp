<!DOCTYPE html>
<%@page import="AppContents.Common.CheckPointENT"%>
<html>
<head>
<%
	CheckPointENT chkENT = (CheckPointENT) request.getSession()
			.getAttribute("chkENT");
%>
<title>Edit a check Point</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 33em;
	width: 40em;
	text-align: center;
}
/* Optional: Makes the sample page fill the window. */
html,body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
<%
	String error = (String) request.getSession().getAttribute("error");
	String success = (String) request.getSession().getAttribute(
			"success");
	if (!error.equalsIgnoreCase("") || !success.equalsIgnoreCase("")) {
%>
<div class="ui-block-solo" class="ui-corner-all"
	style="background-color: white" id="messageDiv">
	<a
		style="color: black; cursor: pointer; bold; position: relative; top: 0; right: 0; float: right;"
		title="close" onclick="$('div#messageDiv').fadeOut();">X</a>
	<%
		if (!error.equalsIgnoreCase("")) {
	%>
	<label
		style="color: red; font-weight: bold;"><img src="css/jquery-mobile/images/cautionR.png" /> &nbsp;&nbsp;&nbsp;&nbsp; <%=error%>
	</label>
	<%
		} else if (!success.equalsIgnoreCase("")) {
	%>
	<label style="color: green; font-weight: bold;"><img
		src="css/jquery-mobile/images/cautionG.png" />&nbsp;&nbsp;&nbsp;&nbsp;<%=success%></label>
	<%
		}
	%>
</div>
<%
	}
%>
	<form id="RaceForm" action="ServletCheckPointManagement">
		<input name="reqCode" type="hidden" value="save"> <input
			type="text" name="name" placeholder="Check Point Name"
			value="<%=chkENT.getName()%>"> <input type="text" name="ip"
			placeholder="IP Address" value="<%=chkENT.getIp()%>"> <input
			type="text" name="mac" placeholder="MAC Address"
			value="<%=chkENT.getMac()%>"> <input type="text" name="gps"
			id="gps" placeholder="GPS Location Lat - Lng"
			value="<%=chkENT.getGps()%>"> <input type="hidden" name="id"
			value="<%=chkENT.getId()%>">
	</form>
	<div data-role="navbar">
		<ul>
			<li><a href="#" data_role="button"
				style="margin: .4em 5em .4em 5em;"
				class="ui-btn ui-corner-all ui-button-right ui-shadow"
				onclick='loadPage("ServletCheckPointManagement?reqCode=listCheckPoints");'>
					<img title="View on map" src="css/jquery-mobile/images/back.png" />
					&nbsp;&nbsp;&nbsp;BACK
			</a></li>
			<li><a href="#" data_role="button"
				style="margin: .4em 5em .4em 5em;"
				class="ui-btn ui-corner-all ui-button-right ui-shadow"
				onclick='submitTheForm();'> <img title="View on map"
					src="css/jquery-mobile/images/save.png" /> &nbsp;&nbsp;&nbsp; <%if(chkENT.getId()>0){%>UPDATE<%}else{ %>SAVE<%}%>
			</a></li>
		</ul>
	</div>
	<div id="map"></div>
	<script>
		var map;
		function initMap() {
			var pos;
			map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : -34.397,
					lng : 150.644
				},
				zoom : 15
			});
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					pos = {
						lat : position.coords.latitude,
						lng : position.coords.longitude
					};
	<%if (chkENT.getId() > 0) {%>
		pos = {
						lat :
	<%=chkENT.getGps().split(",")[0]%>
		,
						lng :
	<%=chkENT.getGps().split(",")[1]%>
		};
	<%}%>
		var marker = new google.maps.Marker({
						position : pos,
						map : map
					});
					map.setCenter(pos);
	<%if (chkENT.getId() <= 0) {%>
		$("#gps").val(pos.lat + ", " + pos.lng);
	<%}%>
		}, function() {
					handleLocationError(true, infoWindow, map.getCenter());
				});
			} else {
				// Browser doesn't support Geolocation
				handleLocationError(false, infoWindow, map.getCenter());
			}
			google.maps.event.addListener(map, "click", function(event) {
				var lat = event.latLng.lat();
				var lng = event.latLng.lng();
				$("#gps").val(lat + ", " + lng);
			});
		}
		function handleLocationError(browserHasGeolocation, infoWindow, pos) {
			infoWindow.setPosition(pos);
			infoWindow
					.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
							: 'Error: Your browser doesn\'t support geolocation.');
			infoWindow.open(map);
		}
	</script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDzM7cjbo3EJiW8nnTSBcY-fNIdppA_6AA&callback=initMap">
		
	</script>
</body>

</html>