package AppContents;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tools.AMSException;
import tools.DAOManager;

import AppContents.Common.CheckPointENT;
import AppContents.Common.RaceHeader;
import AppContents.Common.RiderENT;

@WebServlet("/ServletRaceManagement")
public class ServletRaceManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletRaceManagement() {
		super();
	}

	public void servletEnv(HttpServletRequest request,
			HttpServletResponse response) {
		String reqCode = request.getParameter("reqCode");
		RaceHeader rh = new RaceHeader();
		String error = "";
		String success = "";
		request.getSession().setAttribute("error", "");
		request.getSession().setAttribute("success", "");
		if (reqCode.equalsIgnoreCase("report")) {
			response.setContentType("text/csv");
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ request.getParameter("filename") + ".csv\"");
			try {
				OutputStream outputStream = response.getOutputStream();
				String outputResult = getDAO().exportToCSV(
						Integer.parseInt(request.getParameter("raceId")));
				outputStream.write(outputResult.getBytes());
				outputStream.flush();
				outputStream.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		if (reqCode.equalsIgnoreCase("removeRace")) {
			try {
				getDAO().removeARace(
						Integer.parseInt(request.getParameter("raceId")));
				success = "The race removed successfully";
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (AMSException e) {
				e.printStackTrace();
				error = e.getMessage();
			}
			request.getSession().setAttribute("error", error);
			request.getSession().setAttribute("success", success);
			reqCode = "start";
		}
		if (reqCode.equalsIgnoreCase("start")) {
			try {
				request.getSession().setAttribute("raceHeader",
						getDAO().getTheLatestOpenRace(rh));
			} catch (AMSException e) {
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("initateARace")
				|| reqCode.equalsIgnoreCase("saveUpdate")) {
			rh.setId(Integer.parseInt(request.getParameter("raceId")));
			rh.setRaceName(request.getParameter("name"));
			rh.setLap_no(Integer.parseInt(request.getParameter("lapNo")));
			try {
				if (reqCode.equalsIgnoreCase("initateARace")) {
					rh = getDAO().defineARace(rh);
					success = "The race initiated";
				}
				if (reqCode.equalsIgnoreCase("saveUpdate")) {
					rh = getDAO().updateRace(rh);
					success = "The race updated successfully";
				}
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
			request.getSession().setAttribute("raceHeader", rh);
		} else if (reqCode.equalsIgnoreCase("addRider")) {
			try {
				rh = getDAO().allocateATagRiderToARace(
						new RiderENT(0, "", Integer.parseInt(request
								.getParameter("riderID"))),
						Integer.parseInt(request.getParameter("raceId")));
				success = "The rider added to the race successfully";
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("addCheckPoint")) {
			try {
				rh = getDAO().allocateACheckPointToTheRace(
						new CheckPointENT(Integer.parseInt(request
								.getParameter("checkpointID"))),
						Integer.parseInt(request.getParameter("raceId")));
				success = "The checkpoint added to the race successfully";
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("removeCheckPoint")) {
			try {
				rh = getDAO().removeACheckPointFromTheRace(
						Integer.parseInt(request.getParameter("checkpointId")),
						Integer.parseInt(request.getParameter("raceId")));
				success = "The checkpoint removed from the race successfully";
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
			request.getSession().setAttribute("raceHeader", rh);
		} else if (reqCode.equalsIgnoreCase("removeRider")) {
			try {
				rh = getDAO().removeATagRiderFromTheRace(
						Integer.parseInt(request.getParameter("riderId")),
						Integer.parseInt(request.getParameter("raceId")));
				success = "The rider removed from the race successfully";
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
			request.getSession().setAttribute("raceHeader", rh);
		}
		try {
			request.getSession().setAttribute("error", error);
			request.getSession().setAttribute("success", success);
			response.sendRedirect("setupRace.jsp?reqCode=" + reqCode);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		servletEnv(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		servletEnv(request, response);
	}

	public static void main(String[] args) {
		DateFormat dateFormat = new SimpleDateFormat("MMMM dd");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
	}

	private static AppDAOInterface getDAO() {
		return DAOManager.getAppDAOInterface();
	}

}
