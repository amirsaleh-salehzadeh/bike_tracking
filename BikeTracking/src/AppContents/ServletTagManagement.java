package AppContents;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import AppContents.Common.RiderENT;

import tools.AMSException;
import tools.DAOManager;

/**
 * Servlet implementation class ServletTagManagement
 */
@WebServlet("/ServletTagManagement")
public class ServletTagManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletTagManagement() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void servletEnv(HttpServletRequest request,
			HttpServletResponse response) {
		String error = "";
		String success = "";
		request.getSession().setAttribute("error", "");
		request.getSession().setAttribute("success", "");
		String reqCode = request.getParameter("reqCode");
		if (reqCode == null)
			reqCode = "";
		String searchKey = "";
		String raceId = null;
		if (request.getParameter("raceId") != null)
			raceId = request.getParameter("raceId");
		if (request.getParameter("searchKey") != null)
			searchKey = request.getParameter("searchKey");
		if (reqCode.equalsIgnoreCase("delete")) {
			try {
				getDAO().removeATagFromRider(
						Integer.parseInt(request.getParameter("id")));
				success = "The tag removed from the rider successfully";
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("deleteAll")) {
			try {
				getDAO().removeAllTags();
				success = "All tags that are not allocated to the riders in the race are removed";
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("save")) {
			try {
				if (!request.getParameter("riderID").equalsIgnoreCase("")) {
					getDAO().allocateATagToARider(
							Integer.parseInt(request.getParameter("riderID")),
							request.getParameter("tagCode"));
					success = "The tag has been allocated to the rider successfully";
				} else
					error = "The rider doesn't exist";
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("addRiderToRace")) {
			try {
				getDAO().allocateATagRiderToARace(
						new RiderENT(0, "", Integer.parseInt(request
								.getParameter("tagId"))),
						Integer.parseInt(raceId));
				success = "The rider added to the race successfully";
			} catch (AMSException e) {
				error = e.getMessage();
				e.printStackTrace();
			}
		}
		request.getSession().setAttribute("error", error);
		request.getSession().setAttribute("success", success);
		try {
			if (raceId != null)
				request.getSession().setAttribute("tagsList",
						getDAO().getAllTaggedRidersTODAY(searchKey));
			else
				request.getSession().setAttribute("tagsList",
						getDAO().getTaggedRidersList(searchKey));
		} catch (AMSException e) {
			e.printStackTrace();
		}
		try {
			response.sendRedirect("tagriders.jsp?raceId=" + raceId);
		} catch (IOException e) {
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

	private static AppDAOInterface getDAO() {
		return DAOManager.getAppDAOInterface();
	}

}
