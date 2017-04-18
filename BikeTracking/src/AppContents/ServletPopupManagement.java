package AppContents;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import AppContents.Common.CheckPointENT;
import AppContents.Common.RiderENT;

import tools.AMSException;
import tools.DAOManager;

/**
 * Servlet implementation class ServletCheckpointManagement
 */
@WebServlet("/ServletPopupManagement")
public class ServletPopupManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletPopupManagement() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void servletEnv(HttpServletRequest request,
			HttpServletResponse response) {
		String reqCode = request.getParameter("reqCode");
		if (reqCode.equalsIgnoreCase("searchCheckpoint")) {
			try {
				response.sendRedirect("checkpointspopup.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("gridSearchCheckpoint")) {
			try {
				String searchKey = "";
				if (request.getParameter("checkpoint") != null)
					searchKey = request.getParameter("checkpoint");
				try {
					request.getSession()
							.setAttribute(
									"checkpoints",
									getDAO().getAllcheckpoints(
											new CheckPointENT(0, "", "",
													searchKey, "",0)));
				} catch (AMSException e) {
					e.printStackTrace();
				}
				response.sendRedirect("checkpointsgrid.jsp?popup=true");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("searchRiders")) {
			try {
				response.sendRedirect("riderspopup.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (reqCode.equalsIgnoreCase("gridSearchRiders")) {
			try {
				String searchKey = "";
				if (request.getParameter("rider") != null)
					searchKey = request.getParameter("rider");
				try {
					request.getSession()
							.setAttribute(
									"riders",
									getDAO().getAllTaggedRidersTODAY(searchKey));
				} catch (AMSException e) {
					e.printStackTrace();
				}
				response.sendRedirect("ridersgrid.jsp?popup=true");
			} catch (IOException e) {
				// TODO Auto-generated catch block
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
