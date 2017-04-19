<%@page import="AppContents.Common.RiderENT"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><%@page
	import="AppContents.Common.CheckPointENT"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<script>
	function addRider(x) {
		$('#riderID').val(x);
		$('#reqCode').val("addRider");
		submitTheForm();
	}
	function getList() {
		var $ul = $("ul#ridersGrid"), html = "";
		$ul.html("");
		$ul
				.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");
		$
				.ajax({
					url : "http://localhost:8090/BikeTracking/REST/GetWS/GetTaggedRidersTODAY?username="
							+ $("#rider").val(),
					dataType : "json",
					success : function(data) {
						// 						$("#rider").css("width",
						// 								$('#autocomplete-input').css("width"));
						$.each(data, function(k, v) {
							html += "<li id='" + v.riderTagId
									+ "' onclick=\"selectMe(this)\">"
									+ v.riderUsername + "</li>";
						});
						$ul.html(html);
						$ul.listview("refresh");
						$ul.trigger("updatelayout");
					}
				});
	}
	$(document).ready(function() {
		getList();
	});
</script>
</head>
<body>
	<div style="padding: .4em 1em .4em 1em;">
		<input type="text" name="rider" onkeyup="getList();" id="rider"
			placeholder="Rider" value=""
			class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
		<ul data-role="listview" id="ridersGrid" data-inset="true">
		</ul>
	</div>
</body>
</html>