<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="AppContents.Common.RiderENT"%>
<%@page import="java.util.ArrayList"%>
<%@page import="AppContents.Common.RaceHeader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function initiateARace() {
		$("#reqCode").val("initateARace");
		submitTheForm();
	}
	function removeCheckPoint(chk, rh){
		loadPage($("#RaceForm").attr("action")
				+"?reqCode=removeCheckPoint&checkpointId="+chk+"&raceId="+rh);
	}
	function removeRider(ri, rh){
		loadPage($("#RaceForm").attr("action")
				+"?reqCode=removeRider&riderId="+ri+"&raceId="+rh);
	}
	function saveUpdate(){
		$("#reqCode").val("saveUpdate");
		submitTheForm();
	}
	function removeRace(){
		$("#reqCode").val("removeRace");
		submitTheForm();
	}
	function errorRemove(){
alert("Unless there is either one rider or one check point is allocated to the race, " +
		"the remove action can not be performed. Please remove riders or check points first.");
		}
</script>
</head>
<body>
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
			    <label for="name">Race Title</label><input type="text"
				name="name" id="name" placeholder="Race Title"
				value="<%=rh.getRaceName()%>"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		</div>
		<div class="ui-block-solo">
			<label for="lapNo">Number of Laps</label> <input type="number"
				name="lapNo" id="lapNo" value="<%=rh.getLap_no()%>"
				placeholder="Number of Laps"
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
						src="css/jquery-mobile/images/save.png" />&nbsp;&nbsp;&nbsp;SAVE
				</a></li>
				<%
					if(rider.size()>0&&chks2.size()>0){
				%>
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					href="#"> <img src="css/jquery-mobile/images/goto.png" />&nbsp;&nbsp;&nbsp;GO
						TO RACE
				</a></li>
				<%
					}
				%>
			</ul>
		</div>
		<div class="ui-block-solo">
			<label for="name">Race Title</label> <input type="text" name="name"
				id="name" placeholder="Race Name" value="<%=rh.getRaceName()%>"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c"
				data-inline="true">
		</div>
		<div class="ui-block-solo">
			<label for="lapNo">Number of Laps</label><input type="number"
				name="lapNo" id="lapNo" value="<%=rh.getLap_no()%>"
				placeholder="Number of laps"
				class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		</div>
		<div data-role="navbar">
			<ul style="word-wrap: break-word;">
				<li><a data_role="button" class="ui-corner-all ui-shadow"
					onclick='showDialog("ServletPopupManagement?reqCode=searchRiders");'>
						<img src="css/jquery-mobile/images/bike.png" />&nbsp;&nbsp;&nbsp;ADD
						RIDER
				</a></li>
				<li><a data_role="button"
					class="ui-btn ui-corner-all ui-button-inline ui-shadow"
					onclick='$("#PopupCheckP").load("ServletPopupManagement?reqCode=searchCheckpoint");'><img
						src="css/jquery-mobile/images/map.png" />&nbsp;&nbsp;&nbsp;ADD
						CHECK POINT</a></li>
			</ul>
		</div>
		<div class="ui-grid-a ui-responsive">
			<div class="ui-block-a">
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
				<%
					if(chks2.size()>0){
				%>
				<div class="i-corner-all ui-shadow" data-role="collapsible"
					data-collapsed="false"
					style="padding: .1em .2em .1em .2em; background-color: #d9d9d9;">
					<h3>
						<img src="css/jquery-mobile/images/map.png" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Check Points
					</h3>
					<ol data-role="listview">
						<%
							for(int i = 0; i < chks2.size(); i++){
						%>
						<li data-icon="false"><%=chks2.get(i).getName()%>
							<p class="ui-li-aside">
								<img src="css/jquery-mobile/images/remove.png"
									style="cursor: pointer;"
									onclick="removeCheckPoint(<%=chks2.get(i).getCheckPointRaceId()%>, <%=rh.getId()%>);" />
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
		</div>
		<%
			}
		%>
	</form>
</body>
</html>