<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="java.util.ArrayList"%>
<head>
<script>
	$(document).ready(function() {
		loadListView();
	});
	function loadListView() {
		$("#checkpointsGrid").load(
				"ServletPopupManagement?reqCode=gridSearchCheckpoint&checkpoint="
						+ $("#checkpoint").val());
		$(document).ajaxComplete(function() {
			$("#checkpointsGrid").trigger("create");
			$("#checkpointsGrid").listview("refresh");
		});
	}
</script>
</head>
<div class="ui-block-solo" style="padding: .4em 1em .4em 1em;">
	<input type="text" name="checkpoint" onkeyup="loadListView();"
		id="checkpoint" placeholder="Check Point Name" value=""
		class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
	<a href="#" data_role="button" style="margin: .4em 5em .4em 5em;"
		class="ui-btn ui-corner-all ui-button-right ui-shadow"
		onclick='loadPage("ServletCheckPointManagement?reqCode=editCheckPoint&chid=0");'>
		<img title="View on map" src="css/jquery-mobile/images/add.png" /> &nbsp;&nbsp;&nbsp;NEW
		CHECK POINT
	</a>
</div>
<ul data-role="listview" id="checkpointsGrid" data-inset="true">
</ul>
