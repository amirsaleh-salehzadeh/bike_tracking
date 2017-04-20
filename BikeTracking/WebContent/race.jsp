<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
$(document).ready(function(){
	raceMonitoring();
});
	function raceMonitoring() {
		$.ajax({
			url : "http://localhost:8090/BikeTracking/REST/GetWS/MonitorRace?raceId=<%=request.getParameter("raceId")%>",
					dataType : "json",
					success : function(data) {
						var ht = "<thead><tr class='ui-bar-d' id='headerT'><th>Rider</th>";
						$
								.each(
										data.checkPoint,
										function(k, l) {
											ht += "<th><img src='css/jquery-mobile/images/map.png' title='"+l.name+"' /></th>";
										});
						ht += "</tr></thead><tbody>";

						$
								.each(
										data.riders,
										function(i, j) {
											ht += "<tr><th><img src='css/jquery-mobile/images/bike.png' title='"+j.riderUsername+"' /></th>";
											$
													.each(
															data.checkPoint,
															function(k, l) {
																ht += "<td id='"
																		+ l.checkPointRaceId
																		+ "-"
																		+ j.riderTagId
																		+ "'";
																$
																		.each(
																				data.raceLines,
																				function(
																						m,
																						n) {
																					if (n.checkPointId == l.checkPointRaceId
																							&& j.riderTagId == n.riderTagId) {
																						ht += " title ='"
																								+ n.time
																								+ "' bgcolor= '#008800'";
																					}
																					console
																							.log(n.raceLineId
																									+ ":"
																									+ j.riderTagId
																									+ "-"
																									+ n.riderTagId
																									+ "-"
																									+ n.checkPointId
																									+ "-"
																									+ l.checkPointRaceId);
																				});
																ht += "></td>";
															});
											ht += "</tr>";
										});

						ht += "</tbody>";
						$("table#raceMonit").html(ht).trigger("create");
						// 				$ul.listview("refresh");
						// 				$ul.trigger("updatelayout");
					}
				});
	}
</script>
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
		<label style="color: red; font-weight: bold;"><img
			src="css/jquery-mobile/images/cautionR.png" />
			&nbsp;&nbsp;&nbsp;&nbsp; <%=error%> </label>
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
	<div class="ui-block-a">
		<a style="cursor: pointer;"
			class="ui-btn ui-btn-inline ui-shadow ui-corner-all" onclick=""><img
			src="css/jquery-mobile/images/play.png" />&nbsp;&nbsp;&nbsp;START</a> <a
			class="ui-btn ui-btn-inline ui-shadow ui-corner-all" onclick=""
			style="cursor: pointer;"><img
			src="css/jquery-mobile/images/stop.png" />&nbsp;&nbsp;&nbsp;STOP</a>
	</div>
	<table data-role="table" class="ui-shadow ui-responsive" id="raceMonit"
		border="1">
	</table>
</body>
</html>