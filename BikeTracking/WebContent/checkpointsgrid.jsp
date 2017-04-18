<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="java.util.ArrayList"%>
<head>
<script type="text/javascript">
	function addCheckpoint(x) {
		$('#checkpointID').val(x);
		$('#reqCode').val("addCheckPoint");
		submitTheForm();
	}
</script>
<style type="text/css">
p {
	font-weight: normal !important;
}
</style>
</head>
<%
	ArrayList<CheckPointENT> chks = (ArrayList<CheckPointENT>)request.getSession().getAttribute("checkpoints");
	if(chks!=null){
		for(int i = 0; i < chks.size(); i++){
%>
<li style="padding: .4em .4em .4em .4em"><a href="#"
	data-inline="true"><h3><%=chks.get(i).getName()%></h3></a>
	<p>
		<span style="font-weight: bold; font-style: italic;">IP
			Address:</span>
		<%=chks.get(i).getIp()%>
		&nbsp;&nbsp;--&nbsp;&nbsp; <span
			style="font-weight: bold; font-style: italic;">Mac Address:</span>
		<%=chks.get(i).getMac()%>
		&nbsp;&nbsp;--&nbsp;&nbsp; <a data-role="button" data-inline="true"
			href="#popupMap<%=chks.get(i).getId()%>" data-rel="popup"
			class="ui-corner-all ui-shadow ui-btn-inline"> Map-View<img
			title="View on map" src="css/jquery-mobile/images/map.png" />
		</a> <a data-role="button" data-inline="true"
			onclick='loadPage("ServletCheckPointManagement?reqCode=editCheckPoint&chid=<%=chks.get(i).getId()%>")'
			class="ui-corner-all ui-shadow ui-btn-inline">Edit<img
			title="Edit" src="css/jquery-mobile/images/update.png" />
		</a>
	<div data-role="popup" id="popupMap<%=chks.get(i).getId()%>"
		data-overlay-theme="a" data-theme="a" data-corners="false"
		data-tolerance="15,15">
		<a href="#" data-rel="back" data-role="button" data-theme="a"
			data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
		<iframe
			src="map.jsp?lat=<%=chks.get(i).getGps().split(",")[0]%>&long=<%=chks.get(i).getGps().split(",")[1]%>"
			width="480" height="320" seamless></iframe>
	</div>
	</p></li>
<%
	}}
%>
<!-- <img -->
<!-- 	<a
		href="#" onclick="addCheckpoint(<%//chks.get(i).getId()%>);">	alt="add to the race" src="css/jquery-mobile/images/add.png"></a><a -->
<!-- 	href="#"><img alt="Show on map" -->
<!-- 		src="css/jquery-mobile/images/map.png"></a> -->