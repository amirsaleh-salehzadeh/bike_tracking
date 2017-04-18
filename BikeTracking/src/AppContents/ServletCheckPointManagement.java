package AppContents;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tools.AMSException;
import tools.DAOManager;

import AppContents.Common.CheckPointENT;
import AppContents.Common.RaceHeader;

/**
 * Servlet implementation class ServletBikeTracking
 */
@WebServlet("/ServletCheckPointManagement")
public class ServletCheckPointManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletCheckPointManagement() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void servletEnv(HttpServletRequest request,
			HttpServletResponse response) {
		String reqCode = request.getParameter("reqCode");
		if (reqCode.equalsIgnoreCase("listCheckPoints")) {
			String checkpoinString = "";
			try {
				response.sendRedirect("checkpointmanagement.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("editCheckPoint")) {
			int chid = 0;
			if (request.getParameter("chid") != null)
				chid = Integer.parseInt(request.getParameter("chid"));
			try {
				request.getSession().setAttribute("chkENT",
						getDAO().getAcheckpoint(new CheckPointENT(chid)));
				try {
					response.sendRedirect("editcheckpoint.jsp");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (AMSException e) {
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("save")) {
			int id = 0;
			CheckPointENT ent = new CheckPointENT(id,
					request.getParameter("ip"), request.getParameter("mac"),
					request.getParameter("name"), request.getParameter("gps"),0);
			if (request.getParameter("id") == null
					|| Integer.parseInt(request.getParameter("id")) <= 0) {

				try {
					ent = getDAO().defineAcheckpoint(ent);
				} catch (AMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				ent.setId(Integer.parseInt(request.getParameter("id")));
				try {
					ent = getDAO().updateAcheckpoint(ent);
				} catch (AMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			request.getSession().setAttribute("chkENT", ent);
			try {
				response.sendRedirect("editcheckpoint.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		servletEnv(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		servletEnv(request, response);
	}

	private static AppDAOInterface getDAO() {
		return DAOManager.getAppDAOInterface();
	}

}
