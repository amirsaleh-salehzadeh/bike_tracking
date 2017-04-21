<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="AppContents.Common.RiderENT"%>
<%@page import="java.util.ArrayList"%>
<%@page import="AppContents.Common.RaceHeader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
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
	<form action="ServletRaceManagement" id="RaceForm">
		<%
			RaceHeader rh = (RaceHeader) session.getAttribute("raceHeader");
		%>
		<input type="hidden" name="reqCode" id="reqCode"
			value="<%=request.getParameter("reqCode")%>" /> <input type="hidden"
			name="raceId" id="raceId" value="<%=rh.getId()%>" /> <input
			type="hidden" name="checkpointID" id="checkpointID" value="" /> <input
			type="hidden" name="riderID" id="riderID" value="" />
		<%
			if (rh.getId() <= 0) {
		%>
		<div class="ui-block-solo">
			    <input type="text" name="name" id="name" placeholder="Race Title"
				value="<%=rh.getRaceName()%>"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		</div>
		<div class="ui-block-solo">
			<input type="number" name="lapNo" id="lapNo"
				value="<%=rh.getLap_no()%>" placeholder="Number of Laps"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		</div>
		<div class="ui-block-solo">
			<a data_role="button" class="ui-btn ui-corner-all"
				onclick="initiateARace();">INITIATE RACE</a>
		</div>
		<%
			} else {
		%>
		<%
			ArrayList<RiderENT> rider = rh.getRiders();
		%>
		<%
			ArrayList<CheckPointENT> chks2 = rh.getCheckPoint();
		%>
		<div data-role="navbar">
			<ul style="word-wrap: break-word;">
				<%
					if(rider.size()>0&&chks2.size()>0){
				%>
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					href="#" onclick="errorRemove()"> <img
						src="css/jquery-mobile/images/remove.png" />
						&nbsp;&nbsp;&nbsp;REMOVE RACE
				</a></li>
				<%
					} else {
				%>
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					href="#" onclick="removeRace()"> <img
						src="css/jquery-mobile/images/remove.png" />
						&nbsp;&nbsp;&nbsp;REMOVE RACE
				</a></li>
				<%
					}
				%>
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					href="#" onclick="saveUpdate();"> <img
						src="css/jquery-mobile/images/save.png" />&nbsp;&nbsp;&nbsp;UPDATE
				</a></li>
				<%
					if(rider.size()>0&&chks2.size()>0){
				%>
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					href="#" onclick="loadPage('race.jsp?raceId=<%=rh.getId()%>')">
						<img src="css/jquery-mobile/images/goto.png" />&nbsp;&nbsp;&nbsp;GO
						TO RACE
				</a></li>
				<%
					}
				%>
			</ul>
		</div>
		<div class="ui-block-solo">
			<input type="text" name="name" id="name" placeholder="Race Name"
				value="<%=rh.getRaceName()%>"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c"
				data-inline="true">
		</div>
		<div class="ui-block-solo">
			<input type="number" name="lapNo" id="lapNo"
				value="<%=rh.getLap_no()%>" placeholder="Number of laps"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		</div>
		<div class="ui-grid-a ui-responsive">
			<div class="ui-block-a">
				<a class="ui-btn ui-btn-inline ui-shadow ui-corner-all"
					onclick="loadPage('ServletTagManagement?raceId=<%=rh.getId()%>');">
					<img src="css/jquery-mobile/images/bike.png" />&nbsp;&nbsp;&nbsp;ADD
					RIDER
				</a>
				<%
					if(rider.size()>0){
				%>
				<div class="i-corner-all ui-shadow" data-role="collapsible"
					data-collapsed="false"
					style="padding: .1em .2em .1em .2em; background-color: #d9d9d9;">
					<h3>
						<img src="css/jquery-mobile/images/bike.png" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Riders
					</h3>
					<ol data-role="listview">
						<%
							for(int i = 0; i < rider.size(); i++){
						%>
						<li data-icon="false"><%=rider.get(i).getRiderUsername()%>
							<p class="ui-li-aside">
								<img src="css/jquery-mobile/images/remove.png"
									style="cursor: pointer;"
									onclick="removeRider(<%=rider.get(i).getRiderTagId()%>, <%=rh.getId()%>);" />
							</p></li>
						<%
							}
						%>
					</ol>
				</div>
				<%
					}
				%>
			</div>
			<div class="ui-block-b">
				<a class="ui-btn ui-btn-inline ui-shadow ui-corner-all"
					onclick="loadPage('ServletCheckPointManagement?reqCode=listCheckPoints&raceId=<%=rh.getId()%>')"><img
					src="css/jquery-mobile/images/map.png" />&nbsp;&nbsp;&nbsp;CHECK
					POINT</a>
				<%
					if(chks2.size()>0){
				%>
				<%
					String location = "";
																			for(int i = 0; i < chks2.size(); i++){
																					location += chks2.get(i).getGps().split(",")[0] 
																							+"," + chks2.get(i).getGps().split(",")[1]
																									+","+chks2.get(i).getId()+","+chks2.get(i).getName();
																							if(i<chks2.size())
																								location += ";";
																				}
				%>
				<iframe src="map.jsp?param=<%=location%>&rhid=<%=rh.getId()%>"
					width="400" height="400" seamless></iframe>
				<%
					}
				%>
			</div>
		</div>
		<%
			}
		%>
	</form>
</body>
</html>