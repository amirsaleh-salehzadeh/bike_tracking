package tools;

import AppContents.AppDAOInterface;
import AppContents.DAO;


public class DAOManager {
	
	static AppDAOInterface _dao ;
	
	public static AppDAOInterface getAppDAOInterface(){
		if (_dao == null) {
			_dao = new DAO();
		}
		return _dao; 
	}
	
}