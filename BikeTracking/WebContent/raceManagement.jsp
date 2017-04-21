<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1;
		var yyyy = today.getFullYear();
		$('#sdate').val(01 + '-' + 01 + '-' + 2017).trigger("create");
		$('#sdate').datepicker( "setDate" , today );
		$('input#sdate').datepicker("refresh");
		$('input#edate').val(dd + '-' + mm + '-' + yyyy);
		$('input#edate').datepicker("refresh");
		fetchTheRaceList();
	});
</script>
</head>
<body>
	<div class="ui-block-solo">
		<div class="ui-grid-b">
			<div class="ui-block-a">
				<input type="date" id="sdate" placeholder="Hours"
					onchange="fetchTheRaceList();">
			</div>
			<div class="ui-block-b">
				<input type="date" id="edate" placeholder="Minutes"
					onchange="fetchTheRaceList();">
			</div>
			<div class="ui-block-c">
				<input id="name" type="text" placeholder="Race Name"
					onkeyup="fetchTheRaceList();">
			</div>
		</div>
	</div>
	<div class="ui-block-solo">
		<table data-role="table" data-filter="true"
			data-input="#filterTable-input" class="ui-responsive" id="rmtablebody">
		</table>
	</div>
</body>
</html>