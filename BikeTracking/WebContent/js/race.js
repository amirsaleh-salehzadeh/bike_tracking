$(document).ready(function() {
	loadPage('ServletRaceManagement?reqCode=start');
});
$(document).ajaxComplete(function(event, xhr, settings) {
	$("#systemContainer").trigger("create");
	$("div#mainBodyContent").trigger("create");
});
function loadPage(x) {
	$("div#mainBodyContent").load(x).trigger("create");
}
function validateForm() {
	$("form#formID :input").each(function() {
		if ($(this).val() == "")
			alert($(this).attr("placeholder") + " must have a value");
	});
}
function submitTheForm() {
	var url = $("#RaceForm").attr("action");
	url += "?" + $("#RaceForm").serialize();
	$.ajax({
		url : url,
		cache : false,
		success : function(data) {
			$("#mainBodyContent").html(data);
			$("#systemContainer").trigger("create");
			$(".ui-popup-active").css("display", "none");
			return true;
		}
	});
}
function fetchTheRaceList() {
	var trz = "";
	var counter = 1;
	$.ajax({
		url : "http://localhost:8090/BikeTracking/REST/GetWS/GetAllRaces?name=" + $("#name").val() + "&sdate="
				+ $("#sdate").val() + "&edate=" + $("#edate").val(),
		cache : false,
		success : function(data) {
			trz = "<thead><tr><th data-priority='1'>#</th>" + "<th data-priority='persist'>Race Name</th>"
					+ "<th data-priority='2'>Number of Riders</th>"
					+ "<th data-priority='1'>Number of Checkpoints</th>" + "<th data-priority='5'>Created Date</th>"
					+ "<th data-priority='3'>Started Time</th>" + "<th data-priority='4'>Finished Time</th>"
					+ "<th data-priority='persist'>EXPORT</th></tr></thead><tbody>";
			$.each(data, function(k, l) {
				trz += "<tr><th>" + counter + "</th><td>" + l.raceName + "</td><td>" + l.countRiders + "</td><td>"
						+ l.countCheckpoints + "</td><td>" + l.cDateTime + "</td><td>" + l.sDateTime + "</td><td>"
						+ l.fDateTime + "</td><td> <img src='css/jquery-mobile/images/excel.png' title='" + l.raceName
						+ "' id='" + l.id + "' onclick='exportMe(this);' style='cursor: pointer;'/></td></tr>";
				counter++;
			});
			trz += "</tbody>";
			$("table#rmtablebody").html(trz).trigger("updatelayout");
		}
	});
}
function exportMe(x) {
	// $.ajax({
	// url : "http://localhost:8090/BikeTracking/REST/GetWS/ExportMe?raceId="+x,
	// dataType : "text",
	// cache : false,
	// async : false,
	// success : function(data) {
	window.location.href = 'ServletRaceManagement?reqCode=report&filename=' + $(x).attr("title")+"&raceId="+$(x).attr("id");
	// }
	// });
}
function raceMonitoring(u) {
	$.ajax({
		url : u,
		dataType : "json",
		cache : false,
		async : false,
		success : function(data) {
			var ht = "<thead><tr class='ui-bar-d' id='headerT'><th>&nbsp;</th>";
			$.each(data.checkPoint, function(k, l) {
				ht += "<th><img src='css/jquery-mobile/images/map.png' class='checkpoints' title='" + l.name + "' id='"
						+ l.checkPointRaceId + "' /></th>";
			});
			ht += "</tr></thead><tbody>";
			$.each(data.riders, function(i, j) {
				ht += "<tr><th><img src='css/jquery-mobile/images/bike.png' class='riders' title='" + j.riderUsername
						+ "' id='" + j.riderTagId + "' /></th>";
				$.each(data.checkPoint, function(k, l) {
					ht += "<td class='tdz' id='" + l.checkPointRaceId + "-" + j.riderTagId + "'";
					$.each(data.raceLines, function(m, n) {
						if (n.checkPointId == l.checkPointRaceId && j.riderTagId == n.riderTagId) {
							ht += " title ='" + n.time + "' bgcolor= '#008800'";
						}
					});
					ht += "></td>";
				});
				ht += "</tr>";
			});

			ht += "</tbody>";
			$("table#raceMonit").html(ht).trigger("create");
			clickAdd();
		}
	});

}

function convertTime(t) {
	var seconds = Math.floor((t / 1000) % 60);
	var minutes = Math.floor((t / 1000 / 60) % 60);
	var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
	return hours + ":" + minutes + ":" + seconds;
}

var now;
var timer;
var monitoting;
function getTimeRemaining() {
	var t = Date.parse(new Date()) - now;
	$("#timer").html(convertTime(t));
	timer = setTimeout(getTimeRemaining, 1000);

}

function clickAdd() {
	var dt = new Date();
	$("img.riders").each(function() {
		$(this).css("cursor", "pointer");
		$(this).click(function() {
			$("#riderId").val($(this).attr("id"));
			$("#riderT").val($(this).attr("title"));
			$("#hour").val(dt.getHours());
			$("#min").val(dt.getMinutes());
			$("#sec").val(dt.getSeconds());
		});
	});
	$("img.checkpoints").each(function() {
		$(this).css("cursor", "pointer");
		$(this).click(function() {
			$("#checkpointId").val($(this).attr("id"));
			$("#checkpointT").val($(this).attr("title"));
		});
	});
	$(".tdz").each(function() {
		$(this).css("cursor", "pointer");
		$(this).click(function() {
			if ($(this).attr("bgcolor") != "#008800") {
				addtolist($(this).attr('id'));
			} else
				$(this).css("cursor", "");
		});
	});
}

function addtolist(x) {
	var tmp = x.split("-");
	var d = new Date();
	var url = "http://localhost:8090/BikeTracking/REST/GetWS/SetLine?checkPointId=" + tmp[0] + "&raceId="
			+ $("#raceId").val() + "&time=" + d.getTime() + "&riderTagId=" + tmp[1];
	$.ajax({
		url : url,
		dataType : "json",
		success : function(data) {
			return;
		}
	});
}

function finishTheRace() {
	$.ajax({
		url : "http://localhost:8090/BikeTracking/REST/GetWS/FinishTheRace?push=false&raceId=" + $("#raceId").val(),
		dataType : "json",
		success : function(data) {
			$("div#menuContent").fadeIn();
			$("#mainBodyContent").css("width", "67%");
			$("#mainBodyContent").css("padding-top", "2em");
			$("#mainBodyContent").css("padding-left", "5%");
			$("#mainBodyContent").css("padding-right", "3%");
			$("#mainBodyContent").css("float", "right");
			loadPage("raceManagement.jsp");
			clearTimeout(monitoting);
			clearTimeout(timer);
		}
	});
}

function startTheRace() {
	$("div#menuContent").fadeOut();
	$("#mainBodyContent").css("width", "95%");
	$("#startBTN").html($("#startBTN").html().replace("START", "Press and hold to restart"));
	$("#startBTN").attr("onclick", "");
	$.ajax({
		url : "http://localhost:8090/BikeTracking/REST/GetWS/StartTheRace?push=false&raceId=" + $("#raceId").val(),
		dataType : "json",
		success : function(data) {
			$("#stime").html(convertTime(data.sDateTime));
			$("#startedtime").val(data.sDateTime);
		}
	});
	now = Date.parse(new Date());
	getTimeRemaining();
	monitoringStream();
}

function monitoringStream() {
	url = "http://localhost:8090/BikeTracking/REST/GetWS/MonitorRace?raceId=" + $("#raceId").val();
	raceMonitoring(url);
	console.log("22");
	monitoting = setTimeout(monitoringStream, 3000);
}
function initiateARace() {
	$("#reqCode").val("initateARace");
	submitTheForm();
}
function removeCheckPoint(chk) {
	loadPage($("#RaceForm").attr("action") + "?reqCode=removeCheckPoint&checkpointId=" + chk + "&raceId="
			+ $("#raceId").val());
}
function removeRider(ri, rh) {
	loadPage($("#RaceForm").attr("action") + "?reqCode=removeRider&riderId=" + ri + "&raceId=" + rh);
}
function saveUpdate() {
	$("#reqCode").val("saveUpdate");
	submitTheForm();
}
function removeRace() {
	$("#reqCode").val("removeRace");
	submitTheForm();
}
function errorRemove() {
	alert("Unless there is either one rider or one check point is allocated to the race, "
			+ "the remove action can not be performed. Please remove riders or check points first.");
}