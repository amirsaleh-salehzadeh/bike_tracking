package webservices;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Application;

@Path("GetWS")
public class GestService extends Application {
	// REST/GetWS/GetWSRFID
	public static String tagVal = "";
	
	//Server
	@GET
	@Path("/SetRFID")
	@Produces("application/json")
	public String setWSRFID(@QueryParam("checkPoint") int checkPoint,
			@QueryParam("tagValue") String tagValue,
			@QueryParam("time") String dateTime) {
		String json = "test";
		return json;
	}
	
	//PIs
	@GET
	@Path("/ValidateConnections")
	@Produces("application/json")
	public boolean validateConnections() {
		return false;
	}
	
}
