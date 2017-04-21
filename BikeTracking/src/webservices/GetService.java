package webservices;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Application;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import tools.AMSException;
import tools.DAOManager;
import AppContents.AppDAOInterface;
import AppContents.Common.CheckPointENT;
import AppContents.Common.RaceHeader;
import AppContents.Common.RaceLine;

import client.common.ClientAppDAO;

@Path("GetWS")
public class GetService extends Application {
	// REST/GetWS/.....

	@GET
	@Path("/SetLine")
	@Produces("application/json")
	public String setLine(@QueryParam("checkPointId") int checkPointId,
			@QueryParam("time") String dateTime,
			@QueryParam("raceId") int raceId,
			@QueryParam("riderTagId") int riderTagId) {
		try {
			getDAO().addALineToTheRace(
					new RaceLine(checkPointId, dateTime, riderTagId, raceId, 0));
		} catch (AMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@GET
	@Path("/ExportMe")
	@Produces("application/json")
	public String exportMe(@QueryParam("raceId") int raceId) {
		String res = "";
		try {
			res = getDAO().exportToCSV(raceId);
		} catch (AMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@GET
	@Path("/GetAllRaces")
	@Produces("application/json")
	public String getAllRaces(@QueryParam("name") String name,
			@QueryParam("sdate") String sdate, @QueryParam("edate") String edate) {
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		String edateD = null;
		String sdateD = null;
		try {
			if (!edate.equalsIgnoreCase("")) {
				edateD = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(edate + " 23:59:59").getTime()+"";
			} else {
				edateD = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.format(new Date());
			}
			if (!sdate.equalsIgnoreCase("")) {
				sdateD = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse(sdate + " 00:00:01").getTime()+"";
			} else {
				sdateD = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.parse("2017-01-01 00:00:01").getTime()+"";
			}
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		try {
			json = mapper.writeValueAsString(getDAO().getAllRace(
					new RaceHeader(0, 0, sdateD, edateD, name, null, null, null)));
		} catch (AMSException e) {
			e.printStackTrace();
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/StartTheRace")
	@Produces("application/json")
	public String startRace(@QueryParam("raceId") int raceId,
			@QueryParam("push") boolean push) {
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().startTheRace(
					new RaceHeader(raceId), push));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/FinishTheRace")
	@Produces("application/json")
	public String finishRace(@QueryParam("raceId") int raceId,
			@QueryParam("push") boolean push) {
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().finishTheRace(
					new RaceHeader(raceId), push));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetRidersList")
	@Produces("application/json")
	public String getRidersList(@QueryParam("username") String username) {
		String json = "";
		String searchKey = "";
		if (username != null) {
			searchKey = username;
		}
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().getAllNOTTaggedRiders(
					searchKey));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetAllCheckPoints")
	@Produces("application/json")
	public String getAllCheckPoints(@QueryParam("searchKey") String searchKey) {
		String json = "";
		if (searchKey == null) {
			searchKey = "";
		}
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().getAllcheckpoints(
					new CheckPointENT(0, "", "", searchKey, "", 0)));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetAllCheckPointsToAllocateToRace")
	@Produces("application/json")
	public String getAllCheckPointsToAllocateToRace(
			@QueryParam("searchKey") String searchKey,
			@QueryParam("raceId") int raceId) {
		String json = "";
		if (searchKey == null) {
			searchKey = "";
		}
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO()
					.getAllcheckpointsToAllocateToRace(raceId, searchKey));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetCheckPointsForARace")
	@Produces("application/json")
	public String getCheckPointsForARace(@QueryParam("raceId") int raceId) {
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			RaceHeader rh = getDAO().getArace(new RaceHeader(raceId));
			json = mapper.writeValueAsString(rh.getCheckPoint());
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/GetTaggedRidersTODAY")
	@Produces("application/json")
	public String getTaggedRidersTODAY(@QueryParam("username") String username) {
		String json = "";
		String searchKey = "";
		if (username != null) {
			searchKey = username;
		}
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().getAllTaggedRidersTODAY(
					searchKey));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/MonitorRace")
	@Produces("application/json")
	public String monitorRace(@QueryParam("raceId") int raceId) {
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			json = mapper.writeValueAsString(getDAO().getArace(
					new RaceHeader(raceId)));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AMSException e) {
			e.printStackTrace();
		}
		System.out.println(json);
		return json;
	}

	@GET
	@Path("/Connect")
	@Produces("application/json")
	public String connect(@QueryParam("ip") String ip,
			@QueryParam("mac") String mac) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(System.currentTimeMillis());
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	@GET
	@Path("/ImAlive")
	@Produces("application/json")
	public String imAlive(@QueryParam("id") String ip) {
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		try {
			json = mapper.writeValueAsString(ClientAppDAO.getMacAddress());
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}

	private static AppDAOInterface getDAO() {
		return DAOManager.getAppDAOInterface();
	}
}
