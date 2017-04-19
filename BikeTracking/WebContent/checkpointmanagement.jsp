<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="java.util.ArrayList"%>
<head>
<script>
	
<%String raceId = request.getParameter("raceId");%>
	$(document).ready(function() {
		getList();
	});
	function getList() {
		var $ul = $("ul#chkpointGrid"), html = "", url = "";
<%if (raceId.equalsIgnoreCase("null")) {%>
	url = "http://localhost:8090/BikeTracking/REST/GetWS/GetAllCheckPoints?searchKey="
						+ $("#chkpoint").val();
<%} else {%>
	url = "http://localhost:8090/BikeTracking/REST/GetWS/GetAllCheckPointsToAllocateToRace?searchKey="
						+ $("#chkpoint").val()+"&raceId=<%=request.getParameter("raceId")%>";
<%}%>
	$ul.html("");
		$ul
				.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");

		$
				.ajax({
					url : url,
					dataType : "json",
					success : function(data) {
						$
								.each(
										data,
										function(k, v) {
<%if (raceId.equalsIgnoreCase("null")) {%>
	html += "<li data-icon='false' style='padding: .4em .4em .4em .4em'><span style='font-weight: bold;'>"
													+ v.name
													+ "</span>&nbsp;&nbsp;--&nbsp;&nbsp;<span style='font-style: italic;'>IP Address: </span>"
													+ v.ip
													+ "&nbsp;&nbsp;--&nbsp;&nbsp; <span style='font-style: italic;'>Mac Address: </span>"
													+ v.mac
													+ "&nbsp;&nbsp;--&nbsp;&nbsp; <a data-inline='true' href='#popupMap"+v.id+
"' data-rel='popup' class='ui-corner-all ui-shadow ui-btn-inline'>"
													+ "Map-View<img title='View on map' src='css/jquery-mobile/images/map.png' /></a>"
													+ "&nbsp;&nbsp;--&nbsp;&nbsp;<img style='cursor: pointer;' onclick=\"loadPage('ServletCheckPointManagement?reqCode=editCheckPoint&chid="
													+ v.id
													+ "')\" title='Edit' src='css/jquery-mobile/images/update.png' class='ui-btn-inline'/>"
													+ "<div data-role='popup' id='popupMap"+v.id+"'data-overlay-theme='a' data-theme='a' data-corners='false' data-tolerance='15,15'>"
													+ "<a href='#' data-rel='back' data-theme='a' data-icon='delete' data-iconpos='notext' class='ui-btn-right'>Close</a>"
													+ "<iframe src='map.jsp?lat="
													+ v.gps.split(',')[0]
													+ "&long="
													+ v.gps.split(',')[1]
													+ "'width='480' height='320' seamless></iframe></div></li>";
<%} else {%>
	html += "<li data-icon='false' style='padding: .4em .4em .4em .4em'><span style='font-weight: bold;'>"
													+ v.name
													+ "</span>&nbsp;&nbsp;--&nbsp;&nbsp; <a data-inline='true' href='#popupMap"+v.id+
"' data-rel='popup' class='ui-corner-all ui-shadow ui-btn-inline'>Map-View<img title='View on map' src='css/jquery-mobile/images/map.png' /></a>"
													+ "<div data-role='popup' id='popupMap"+v.id+"'data-overlay-theme='a' data-theme='a' data-corners='false' data-tolerance='15,15'>"
													+ "<a href='#' data-rel='back' data-theme='a' data-icon='delete' data-iconpos='notext' class='ui-btn-right'>Close</a>"
													+ "<iframe src='map.jsp?lat="
													+ v.gps.split(',')[0]
													+ "&long="
													+ v.gps.split(',')[1]
													+ "'width='480' height='320' seamless></iframe></div>"
													+ "&nbsp;&nbsp;--&nbsp;&nbsp;<img style='cursor: pointer;' onclick=\"loadPage('ServletCheckPointManagement?reqCode=addToTheRace&chid="
													+ v.id
													+ "&raceId=<%=request.getParameter("raceId")%>')\" title='Add to the race' src='css/jquery-mobile/images/add.png' class='ui-btn-inline'/></li>";
<%}%>
	});
						$ul.html(html);
						$ul.listview("refresh");
						$ul.trigger("updatelayout");
					}
				});
	}
</script>
</head>

<div class="ui-block-solo" id="dialog"
	style="padding: .4em 1em .4em 1em;">
	<input type="text" name="checkpoint" onkeyup="getList();" id="chkpoint"
		placeholder="Check Point Name" value=""
		class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
	<%
		if (raceId.equalsIgnoreCase("null")) {
	%>
	<a href="#" data_role="button" style="margin: .4em 5em .4em 5em;"
		class="ui-btn ui-corner-all ui-button-right ui-shadow"
		onclick='loadPage("ServletCheckPointManagement?reqCode=editCheckPoint&chid=0");'>
		<img title="View on map" src="css/jquery-mobile/images/add.png" />
		&nbsp;&nbsp;&nbsp;NEW CHECK POINT
	</a>
	<%
		}
	%>
</div>
<ul data-role="listview" id="chkpointGrid" data-inset="false">
</ul>
<%
	if (!raceId.equalsIgnoreCase("null")) {
%>
<div class="ui-block-solo">
	<a data_role="button" class="ui-btn ui-corner-all" onclick="loadPage('ServletRaceManagement?reqCode=start');">Back to Race </a>
</div>
<%
	}
%>
