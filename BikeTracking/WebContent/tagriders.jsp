<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="AppContents.Common.RiderENT"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<script type="text/javascript">
	function completeMe() {
		$("#autocomplete").css("display", "block");
		var $ul = $("ul#autocomplete"), html = "";
		$ul.html("");
		$ul
				.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");
		$ul.listview("refresh");
		$
				.ajax({
					url : "http://localhost:8090/BikeTracking/REST/GetWS/GetRidersList?username="
							+ $("#autocomplete-input").val(),
					dataType : "json",
					success : function(data) {
						$("#autocomplete").css("width",
								$('#autocomplete-input').css("width"));
						$.each(data, function(k, v) {
							html += "<li style='cursor: pointer;' id='"
									+ v.riderId
									+ "' onclick=\"selectMe(this)\">"
									+ v.riderUsername + "</li>";
						});
						$ul.html(html);
						$ul.listview("refresh");
						$ul.trigger("updatelayout");
					}
				});
	}
	function selectMe(x) {
		$('#autocomplete-input').val($(x).html());
		$("#autocomplete").css("display", "none");
		$('#riderID').val($(x).attr("id"));

	}
</script>
</head>
<form class="ui-filterable" id="RaceForm" autocomplete="off"
	action="ServletTagManagement">
	    <input id="autocomplete-input" onkeyup="completeMe()"
		name="username" data-type="search" placeholder="Find a rider">
	<input name="reqCode" type="hidden" value="save"> <input
		name="riderID" id="riderID" type="hidden" value="">
	<div>
		<ul id="autocomplete" data-role="listview" data-inset="true"
			data-filter="true" data-input="#autocomplete-input"
			style="position: absolute; z-index: 10000; margin: 1em 1em 1em 1em;"></ul>
	</div>
	<input name="tagCode"
		placeholder="Waiting for the RFID tag">
	<div data-role="navbar">
		<ul>
			<li><a data_role="button" class="ui-btn ui-corner-all"
				onclick="submitTheForm();">Confirm</a></li>
			<li><a data_role="button" class="ui-btn ui-corner-all"
				onclick="">Scan</a></li>
		</ul>
	</div>
</form>
<%
	ArrayList<RiderENT> ri = (ArrayList<RiderENT>) session.getAttribute("tagsList");
%>
<%
	if(ri!=null){
%>
<%
	if(ri.size()>0){
%>
<div class="i-corner-all ui-shadow" data-role="collapsible"
	data-collapsed="true"
	style="padding: .1em .2em .1em .2em; background-color: #d9d9d9;">
	<h3>
		<img src="css/jquery-mobile/images/bike.png" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;History
	</h3>
	<ol data-role="listview">
		<%
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			for(int i = 0; i < ri.size(); i++){
				if(!ri.get(i).getDate().contains(dateFormat.format(date))){
		%>

		<li data-icon="false" style="background-color: #AD7833">
			<%
				}else{
			%>
		
		<li data-icon="false">
			<%
				}
			%>
			<h2><%=ri.get(i).getRiderUsername()%>
				&nbsp;&nbsp;&nbsp;---&nbsp;&nbsp;&nbsp; TAG Code: 
				<%=ri.get(i).getTagCode()%> &nbsp;&nbsp;&nbsp;---&nbsp;&nbsp;&nbsp; <%=ri.get(i).getDate()%> </h2>
			<p class="ui-li-aside">
				<img src="css/jquery-mobile/images/remove.png"
					style="cursor: pointer;"
					onclick="removeTag(<%=ri.get(i).getRiderTagId()%>);" />
			</p>
		</li>
		<%
			}
		%>
	</ol>
</div>
<%
	}
%>
<%
	}
%>