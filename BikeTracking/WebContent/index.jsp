<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.4.5.min.css">
<link rel="shortcut icon" href="">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/jquery-mobile/jqm-demos.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<script src="js/jquery.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/index.js"></script>
<script src="js/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		loadPage('main.jsp');
		// 		$("div#menuContent").load('menu.jsp').trigger("create");
	});
	$(document).ajaxComplete(function(event, xhr, settings) {
		$("#systemContainer").trigger("create");
	});
	function loadPage(x) {
		$("div#mainBodyContent").load(x).trigger("create");
	}
</script>
</head>
<body>
	<div data-role="page" class="jqm-demos jqm-home" id="systemContainer">
		<div data-role="header" class="jqm-header">
			<h2>
				<img src="css/jquery-mobile/images/rovermcc-logo-1.png"
					alt="NMMU Web Application">
			</h2>
			<a href="#"
				class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-gear ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
		</div>
		<div role="main" id="mainBodyContent" class="jqm-content">ddd</div>
		<div data-role="panel" class="jqm-navmenu-panel" data-position="left"
			data-display="overlay" data-theme="a" id="menuContent">
			<ul class="jqm-list ui-alt-icon ui-nodisc-icon">
				<li data-filtertext="demos homepage" data-icon="home"><a
					href="index.jsp">Home</a></li>
				<li data-filtertext="demos homepage"><a href="#" onclick="loadPage('rider_reg.jsp');">Register
						Riders</a></li>
				<li data-role="collapsible" data-enhanced="true"
					data-collapsed-icon="carat-d" data-expanded-icon="carat-u"
					data-iconpos="right" data-inset="false"
					class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
					<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed">
						<a href="#"
							class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">
							Settings<span class="ui-collapsible-heading-status"> click
								to expand contents</span>
						</a>
					</h3>
					<div
						class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed"
						aria-hidden="true">
						<ul>
							<li
								data-filtertext="form checkboxradio widget radio input radio buttons controlgroups"><a
								href="t_user.do?reqCode=userManagement" data-ajax="false">User
									Management</a></li>
							<li
								data-filtertext="form checkboxradio widget checkbox input checkboxes controlgroups"><a
								href="t_security.do?reqCode=roleManagement" data-ajax="false">Role
									Management</a></li>
							<li
								data-filtertext="form checkboxradio widget radio input radio buttons controlgroups"><a
								href="t_security.do?reqCode=groupManagement" data-ajax="false">Group
									Management</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>