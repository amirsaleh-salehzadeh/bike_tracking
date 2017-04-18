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
		String reqCode = request.getParameter("reqCode");
		if (reqCode == null)
			reqCode = "";
		String searchKey = "";
		if (request.getParameter("searchKey") != null)
			searchKey = request.getParameter("searchKey");
		if (reqCode.equalsIgnoreCase("save")) {
			try {
				getDAO().allocateATagToARider(
						Integer.parseInt(request.getParameter("riderID")),
						request.getParameter("tagCode"));
			} catch (AMSException e) {
				e.printStackTrace();
			}
		}
		try {
			request.getSession().setAttribute("tagsList",
					getDAO().getTaggedRidersList(searchKey));
		} catch (AMSException e) {
			e.printStackTrace();
		}
		try {
			response.sendRedirect("tagriders.jsp");
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