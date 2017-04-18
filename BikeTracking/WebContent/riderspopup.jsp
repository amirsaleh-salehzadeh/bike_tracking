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
		loadListViewRiders();
	});
	function loadListViewRiders() {
		$("#ridersGrid").load(
				"ServletPopupManagement?reqCode=gridSearchRiders&rider="
						+ $("#rider").val());
		$(document).ajaxComplete(function() {
			$("#ridersGrid").trigger("create");
		});
	}
</script>
</head>
<div class="ui-block-solo" style="padding: .4em 1em .4em 1em;">
	<input type="text" name="rider" onkeyup="loadListViewRiders();"
		id="rider" placeholder="Rider" value=""
		class="ui-input-text ui-body-null ui-corner-all ui-shadow-inset ui-body-c">
	<ul data-role="listview" id="ridersGrid" data-inset="true">
	</ul>
</div>
