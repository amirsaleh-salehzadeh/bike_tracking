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
						$.each(data.raceLines, function(m, n) {
						$.each(data.checkPoint, function(k, l) {
							ht += "<th><img src='css/jquery-mobile/images/map.png' title='"+l.name+"' /></th>";
						});});
						ht += "</tr></thead><tbody>";
						
						$.each(data.riders, function(i, j) {
							ht += "<tr><th><img src='css/jquery-mobile/images/bike.png' title='"+j.riderUsername+"' /></th>";
							$.each(data.checkPoint, function(k, l) {
								$.each(data.raceLines, function(m, n) {
									if(n.checkPointId==l.checkPointRaceId
											&&j.tagRaceId==n.riderTagId){
										ht+="<td>"+n.time+"</td>";
									}else{
										ht+="<td>a</td>";
									}
							});
							
						});
							ht +="</tr>";
						});
						
						ht += "</tbody>";
										$("table#raceMonit").html(ht);
						// 				$ul.listview("refresh");
						// 				$ul.trigger("updatelayout");
					}
				});
	}
</script>
</head>
<body>
	<div class="ui-block-a">
		<a style="cursor: pointer;"
			class="ui-btn ui-btn-inline ui-shadow ui-corner-all" onclick=""><img
			src="css/jquery-mobile/images/play.png" />&nbsp;&nbsp;&nbsp;START</a> <a
			class="ui-btn ui-btn-inline ui-shadow ui-corner-all" onclick=""
			style="cursor: pointer;"><img
			src="css/jquery-mobile/images/stop.png" />&nbsp;&nbsp;&nbsp;STOP</a>
	</div>
	<table data-role="table" id="raceMonit"
		class="ui-body-d ui-shadow table-stripe ui-responsive">
	</table>
</body>
</html>