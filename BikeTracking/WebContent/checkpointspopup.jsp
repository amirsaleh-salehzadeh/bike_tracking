<%@page import="AppContents.Common.CheckPointENT"%>
<%@page import="java.util.ArrayList"%>
<head>
<script>
	$("[data-role=popup]").enhanceWithin().popup({
		afterclose : function() {
			$(this).remove();
		}
	}).popup("open");
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
		id="checkpoint" placeholder="Checkpoint" value=""
		class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
	<ul data-role="listview" id="checkpointsGrid" data-inset="true">
	</ul>
</div>
