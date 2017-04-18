package webservices;

import java.io.IOException;
import java.util.Arrays;

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

import client.common.ClientAppDAO;

@Path("GetWS")
public class GestService extends Application {
	// REST/GetWS/GetWSRFID

	@GET
	@Path("/SetRFID")
	@Produces("application/json")
	public String setRFID(@QueryParam("checkPointId") int checkPointId,
			@QueryParam("time") String dateTime,
			@QueryParam("tagCode") String tagCode) {
		String json = "success";
		return 1 + "";
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
			json = mapper.writeValueAsString(getDAO().getAllNOTTaggedRiders(searchKey));
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
