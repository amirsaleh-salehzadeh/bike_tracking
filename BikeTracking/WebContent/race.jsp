<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
	raceMonitoring("http://localhost:8090/BikeTracking/REST/GetWS/MonitorRace?raceId=<%=request.getParameter("raceId")%>");
					});
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
	<div class="ui-block-solo">
		<a style="cursor: pointer;" data-role="button"
			class="ui-btn ui-btn-inline ui-shadow ui-corner-all"
			onclick="startTheRace();" id="startBTN"><img
			src="css/jquery-mobile/images/play.png" />&nbsp;&nbsp;&nbsp;START</a> <span
			id="timer"
			style="font-size: 32pt; font-family: Orbitron, sans-serif;"></span>
			
		<a class="ui-btn ui-shadow ui-corner-all" onclick="finishTheRace();"
			style="cursor: pointer; float: right; position: relative; top: 0; right: 0;"><img
			src="css/jquery-mobile/images/stop.png" />&nbsp;&nbsp;&nbsp;FINISH</a>
			<span id="stime" style="float: right; position: relative; font-size: 16px; font-family: Orbitron, sans-serif;"></span>
			<span id="stime" style="float: right; position: relative; font-size: 16px; font-weight:bold; letter-spacing:15px; font-family:arial,sans-serif">START TIME:</span>
	</div>

	<input id="raceId" type="hidden"
		value="<%=request.getParameter("raceId")%>">
	<input id="riderId" name="riderId" type="hidden" value="">
	<input id="startedtime" type="hidden" value="">
	<input id="checkpointId" name="checkpointId" type="hidden">
	<div class="ui-block-solo">
		<div class="ui-grid-b">
			<div class="ui-block-a">
				<input id="hour" placeholder="Hours">
			</div>
			<div class="ui-block-b">
				<input id="min" placeholder="Minutes">
			</div>
			<div class="ui-block-c">
				<input id="sec" placeholder="Seconds">
			</div>
		</div>
	</div>
	<div class="ui-block-solo">
		<div class="ui-grid-b">
			<div class="ui-block-a">
				<input id="riderT" placeholder="Select a rider" disabled="disabled">
			</div>
			<div class="ui-block-b">
				<input id="checkpointT" placeholder="Select a checkpoint"
					disabled="disabled">
			</div>
			<div class="ui-block-c">
				<a style="cursor: pointer;" data-role="button"
					class="ui-btn ui-btn-inline ui-shadow ui-corner-all"
					onclick="" id="startBTN"><img
					src="css/jquery-mobile/images/save.png" style="float: right;" />&nbsp;&nbsp;REGISTER</a>
			</div>
		</div>
	</div>
	<table data-role="table" class="ui-shadow ui-responsive" id="raceMonit"
		border="1">
	</table>
</body>
</html>