package AppContents;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.struts.taglib.tiles.GetAttributeTag;

import AppContents.Common.CheckPointENT;
import AppContents.Common.RaceHeader;
import AppContents.Common.RaceLine;
import AppContents.Common.RiderENT;

import tools.AMSException;

public class DAO implements AppDAOInterface {
	private static final String DBADDRESS = "jdbc:mysql://localhost:3306/ridertracking";
	private static final String DBDRIVER = "com.mysql.jdbc.Driver";

	public static void main(String[] args) {
		DAO dao = new DAO();
//		try {
			// ///////////////////////
//			System.out.println(dao.allocateATagToARider(11, "dfafZ"));
//			System.out.println(dao.getTagID("asdfasdfaf"));
			// ///////////////////////
			// RaceHeader h = new RaceHeader(3, "amir3");
			// h = dao.defineARace(h);
			// System.out.println(h.getId());
			// //////////
			// RaceHeader h = new RaceHeader(8);
			// h = dao.startTheRace(h, true);
			// System.out.println(h.getsDateTime());
			// //////////////
			// CheckPointENT ch = new CheckPointENT(0, "ipp", "mac", "test",
			// "gps");
			// ch = dao.defineAcheckpoint(ch);
			// System.out.println(ch.getGps());
//		} catch (AMSException e) {
//			// TODO Auto-generated catch block
//			throw getAMSException(e.getMessage(),e);
//		}
	}

	@Override
	public boolean allocateATagToARider(int UID, String TagCode)
			throws AMSException {
		int TagID = getTagID(TagCode);
		if (!checkDuplicateDateAndTagEntry(UID, TagID)) {
			throw getAMSException(
					"Either the tag is allocated to another rider or the rider has been allocated by a tag",
					null);
		}
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " INSERT INTO rider_tag_date (rider_id, tag_id)"
					+ " values (?, ?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, UID);
			ps.setInt(2, TagID);
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return true;
	}

	@Override
	public boolean updateATagForARider(int riderId, String tagCode)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		boolean res = false;
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " UPDATE rider_tag_date SET rider_id = ?, tag_id = ? and and date like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, riderId);
			ps.setInt(2, getTagID(tagCode));
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setString(3, "%" + dateFormat.format(date) + "%");
			ps.execute();
			ps.close();
			conn.close();
			res = true;
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	private boolean checkDuplicateDateAndTagEntry(int UID, int TagID) throws AMSException {
		try {
			Class.forName(DBDRIVER);
			Connection conn = DriverManager
					.getConnection(DBADDRESS, "root", "");
			String query = "SELECT rider_tag_id FROM rider_tag_date WHERE (rider_id = ? "
					+ "or tag_id = ?) and date like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setInt(1, UID);
			ps.setInt(2, TagID);
			ps.setString(3, "%" + dateFormat.format(date) + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return false;
			}
			ps.close();
			conn.close();
		} catch (Exception e) {
			throw getAMSException(e.getMessage(),e);
		}
		return true;
	}

	private int getTagID(String TagCode) throws AMSException{
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		int tagId = 0;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "INSERT INTO tags (tag_code) SELECT * FROM "
					+ "(SELECT ?) AS tmp WHERE NOT EXISTS "
					+ "(SELECT tag_code FROM tags WHERE tag_code = ?) LIMIT 1;";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, TagCode);
			ps.setString(2, TagCode);
			ps.execute();
			ps.close();
			query = "SELECT tag_id FROM tags WHERE tag_code = ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, TagCode);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				tagId = rs.getInt("tag_id");
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return tagId;
	}

	@Override
	public RaceHeader defineARace(RaceHeader race) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " INSERT INTO race_header (lap_no, name) SELECT * FROM "
					+ "(SELECT ? , ?) AS tmp WHERE NOT EXISTS "
					+ "(SELECT race_header_id FROM race_header WHERE name = ? and created_time like ?) LIMIT 1;";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, race.getLap_no());
			ps.setString(2, race.getRaceName());
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setString(3, race.getRaceName());
			ps.setString(4, "%" + dateFormat.format(date) + "%");
			ps.execute();
			ps.close();
			query = "SELECT race_header_id FROM race_header ORDER BY race_header_id DESC LIMIT 1";
			ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				race = this
						.getArace(new RaceHeader(rs.getInt("race_header_id")));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return race;
	}

	@Override
	public RaceHeader getArace(RaceHeader race) throws AMSException {
		if (race.getId() <= 0)
			return race;
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT * FROM race_header WHERE race_header_id = ?";
			// String query = " SELECT rh.*, c.*, r.* FROM race_header rh " +
			// "INNER JOIN race_tags rt ON rt.race_header_id = rh.race_header_id "
			// +
			// "INNER JOIN rider_tag_date rtd ON rtd.rider_tag_id = rt.rider_tag_id "
			// +
			// "INNER JOIN race_checkpoints rc ON rc.race_header_id = rh.race_header_id "
			// +
			// "LEFT OUTER JOIN checkpoints c ON c.checkpoint_id = rc.checkpoint_id "
			// +
			// "LEFT OUTER JOIN riders r ON r.rider_id = rtd.rider_id " +
			// "WHERE rh.race_header_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, race.getId());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				race = new RaceHeader(rs.getInt("race_header_id"),
						rs.getInt("lap_no"), rs.getString("start_time"),
						rs.getString("finish_time"), rs.getString("name"),
						null, null, null);
				race.setcDateTime(rs.getString("created_time"));
			}
			ps.close();
			query = "SELECT rtd.*, r.*, t.* FROM rider_tag_date rtd "
					+ "LEFT JOIN riders r ON r.rider_id = rtd.rider_id "
					+ " LEFT JOIN tags t ON t.tag_id = rtd.tag_id WHERE race_header_id = "
					+ race.getId();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			ArrayList<RiderENT> r = new ArrayList<>();
			while (rs.next()) {
				RiderENT re = new RiderENT(rs.getInt("rider_id"),
						rs.getString("username"), rs.getInt("rider_tag_id"),
						rs.getString("tag_code"), rs.getString("date"),
						rs.getInt("tag_id"));
				r.add(re);
			}
			race.setRiders(r);
			query = "SELECT rc.*, c.* FROM race_checkpoints rc "
					+ "INNER JOIN race_header rh on rh.race_header_id = rc.race_header_id "
					+ "LEFT OUTER JOIN checkpoints c ON c.checkpoint_id = rc.checkpoint_id "
					+ "WHERE rc.race_header_id = " + race.getId();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			ArrayList<CheckPointENT> c = new ArrayList<>();
			while (rs.next()) {
				c.add(new CheckPointENT(rs.getInt("checkpoint_id"), rs
						.getString("ip_address"), rs.getString("mac_address"),
						rs.getString("checkpoint_name"), rs.getString("gps"),
						rs.getInt("race_checkpoint_id")));
			}
			race.setCheckPoint(c);
			query = "SELECT * FROM race_line " + "WHERE race_header_id = "
					+ race.getId();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			ArrayList<RaceLine> rl = new ArrayList<>();
			while (rs.next()) {
				long milliseconds = Long.parseLong(rs.getString("time"));
				String t = (int) ((milliseconds / (1000 * 60 * 60)) % 24)
						+ ":"
						+ (int) ((milliseconds / (1000 * 60)) % 60)
						+ ":"
						+ (int) (milliseconds / 1000)
						% 60
						+ "-"
						+ rs.getString("time").substring(
								rs.getString("time").length() - 3,
								rs.getString("time").length());
				System.out.println(t);
				rl.add(new RaceLine(rs.getInt("checkpoint_race_id"), t, rs
						.getInt("rider_tag_id"), rs.getInt("race_header_id"), rs
						.getInt("race_line_id")));

			}
			race.setRaceLines(rl);
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return race;
	}

	@Override
	public RaceHeader startTheRace(RaceHeader race, boolean push)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		if (this.getArace(race).getsDateTime() != null && !push)
			throw getAMSException("The race has been already started", null);
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " UPDATE race_header SET start_time = ? WHERE race_header_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, System.currentTimeMillis() + "");
			ps.setInt(2, race.getId());
			ps.execute();
			ps.close();
			conn.close();
			race = getArace(race);
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return race;
	}

	@Override
	public RaceHeader finishTheRace(RaceHeader race) throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RaceHeader allocateACheckPointToTheRace(CheckPointENT ent, int raceID)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " INSERT INTO race_checkpoints (race_header_id, checkpoint_id, priority) SELECT * FROM "
					+ "(SELECT ? , ?, ?) AS tmp WHERE NOT EXISTS "
					+ "(SELECT race_checkpoint_id FROM race_checkpoints WHERE race_header_id = ? and checkpoint_id = ?) LIMIT 1;";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, raceID);
			ps.setInt(2, ent.getId());
			ps.setInt(3, ent.getPriority());
			ps.setInt(4, raceID);
			ps.setInt(5, ent.getId());
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(new RaceHeader(raceID));
	}

	@Override
	public RaceHeader allocateATagRiderToARace(RiderENT rider, int raceID)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " UPDATE rider_tag_date SET race_header_id = ? WHERE rider_tag_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, raceID);
			ps.setInt(2, rider.getRiderTagId());
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(new RaceHeader(raceID));
	}

	@Override
	public RaceHeader removeATagRiderFromTheRace(int riderTagRaceId, int raceID)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " UPDATE rider_tag_date SET race_header_id = NULL WHERE rider_tag_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, riderTagRaceId);
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(new RaceHeader(raceID));
	}

	@Override
	public RaceHeader removeACheckPointFromTheRace(int checkpointRaceId,
			int raceID) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " DELETE FROM race_checkpoints WHERE race_checkpoint_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, checkpointRaceId);
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(new RaceHeader(raceID));
	}

	@Override
	public RaceHeader addALineToTheRace(RaceLine line) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " INSERT INTO race_line (race_header_id, rider_tag_id, checkpoint_id, time) values (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, line.getHeaderId());
			ps.setInt(2, line.getRiderTagId());
			ps.setInt(3, line.getCheckPointId());
			ps.setString(4, line.getTime());
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(new RaceHeader(line.getHeaderId()));
	}

	@Override
	public RaceHeader getRaceForACheckpoint(CheckPointENT ent)
			throws AMSException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<RaceHeader> getAllRaces(RaceHeader race)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT rh.*, c.*, ri.* FROM race_header rh "
					+ "INNER JOIN race_checkpoints rc ON rc.race_header_id = rh.race_header_id "
					+ "INNER JOIN race_line rl ON rl.race_header_id = rh.race_header_id "
					+ "INNER JOIN race_checkpoints rc ON rc.race_header_id = rh.race_header_id "
					+ "LEFT OUTER JOIN checkpoints c ON c.checkpoint_id = rc.checkpoint_id "
					+ "LEFT OUTER JOIN checkpoints c ON c.checkpoint_id = rc.checkpoint_id "
					+ "LEFT OUTER JOIN checkpoints c ON c.checkpoint_id = rc.checkpoint_id "
					+ "WHERE race_header_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, race.getId());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				race = new RaceHeader(rs.getInt("race_header_id"),
						rs.getInt("lap_no"), rs.getString("start_time"),
						rs.getString("finish_time"), rs.getString("name"),
						null, null, null);
				race.setcDateTime(rs.getString("created_time"));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return null;
	}

	@Override
	public CheckPointENT defineAcheckpoint(CheckPointENT ent)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		if (getAcheckpoint(ent).getId() > 0) {
			throw getAMSException("The checkpoint already exists", null);
		}
		Connection conn;
		
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT * FROM checkpoints WHERE mac_address = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, ent.getMac());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				throw getAMSException("The current MAC address has been registered as the checkpoint name: " +rs.getString("checkpoint_name"), null);
			}
			query = "SELECT * FROM checkpoints WHERE checkpoint_name = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ent.getName());
			rs = ps.executeQuery();
			while (rs.next()) {
				throw getAMSException("The current checkpoint NAME has been registered before", null);
			}
			ps.close();
			query = "INSERT INTO checkpoints (ip_address, mac_address, checkpoint_name, gps) values (?, ?, ?, ?) ";
			ps = conn.prepareStatement(query);
			ps.setString(1, ent.getIp());
			ps.setString(2, ent.getMac());
			ps.setString(3, ent.getName());
			ps.setString(4, ent.getGps());
			ps.execute();
			ps.close();
			query = "SELECT checkpoint_id FROM checkpoints WHERE checkpoint_name = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ent.getName());
			rs = ps.executeQuery();
			while (rs.next()) {
				ent = this.getAcheckpoint(new CheckPointENT(rs
						.getInt("checkpoint_id")));
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return ent;
	}

	@Override
	public CheckPointENT updateAcheckpoint(CheckPointENT ent)
			throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT * FROM checkpoints WHERE mac_address = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, ent.getMac());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				throw getAMSException("The current MAC address has been registered as the checkpoint name: " +rs.getString("checkpoint_name"), null);
			}
			query = "SELECT * FROM checkpoints WHERE checkpoint_name = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ent.getName());
			rs = ps.executeQuery();
			while (rs.next()) {
				throw getAMSException("The current checkpoint NAME has been registered before", null);
			}
			ps.close();
			query = " UPDATE checkpoints SET ip_address = ?, mac_address = ?, checkpoint_name = ?, gps = ? WHERE checkpoint_id = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ent.getIp());
			ps.setString(2, ent.getMac());
			ps.setString(3, ent.getName());
			ps.setString(4, ent.getGps());
			ps.setInt(5, ent.getId());
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return ent;
	}

	@Override
	public CheckPointENT getAcheckpoint(CheckPointENT ent) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		if (ent.getId() <= 0)
			return new CheckPointENT();
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT * FROM checkpoints WHERE checkpoint_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, ent.getId());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ent = new CheckPointENT(rs.getInt("checkpoint_id"),
						rs.getString("ip_address"),
						rs.getString("mac_address"),
						rs.getString("checkpoint_name"), rs.getString("gps"), 0);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return ent;
	}

	@Override
	public void removeAcheckpoint(CheckPointENT ent) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " DELETE FROM checkpoints WHERE checkpoint_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, ent.getId());
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
	}

	@Override
	public ArrayList<CheckPointENT> getAllcheckpoints(CheckPointENT ent)
			throws AMSException {
		ArrayList<CheckPointENT> res = new ArrayList<>();
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT * FROM checkpoints WHERE checkpoint_name like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + ent.getName() + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CheckPointENT entTMP = new CheckPointENT(
						rs.getInt("checkpoint_id"), rs.getString("ip_address"),
						rs.getString("mac_address"),
						rs.getString("checkpoint_name"), rs.getString("gps"), 0);
				res.add(entTMP);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	@Override
	public ArrayList<CheckPointENT> getAllcheckpointsToAllocateToRace(
			int raceId, String search) throws AMSException {
		ArrayList<CheckPointENT> res = new ArrayList<>();
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT c.* FROM checkpoints c "
					+ " WHERE c.checkpoint_id NOT IN (SELECT checkpoint_id FROM race_checkpoints WHERE"
					+ " race_header_id = ?) AND c.checkpoint_name like ? ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, raceId);
			ps.setString(2, "%" + search + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CheckPointENT entTMP = new CheckPointENT(
						rs.getInt("checkpoint_id"), rs.getString("ip_address"),
						rs.getString("mac_address"),
						rs.getString("checkpoint_name"), rs.getString("gps"), 0);
				res.add(entTMP);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	private AMSException getAMSException(String defaultMessage, Exception ex) {
		if (ex == null) {
			return new AMSException(defaultMessage);
		}
		ex.printStackTrace();
		return new AMSException(defaultMessage, ex);
	}

	@Override
	public ArrayList<RiderENT> getAllRiders(String searchKey)
			throws AMSException {
		ArrayList<RiderENT> res = new ArrayList<>();
		String[] usernames = null;
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT * FROM riders WHERE username like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			rs.last();
			usernames = new String[rs.getRow()];
			rs.beforeFirst();
			int j = 0;
			while (rs.next()) {
				RiderENT entTMP = new RiderENT(rs.getInt("rider_id"),
						rs.getString("username"));
				res.add(entTMP);
				usernames[j] = rs.getString("username");
				j++;
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	@Override
	public ArrayList<RiderENT> getAllTaggedRidersTODAY(String searchKey)
			throws AMSException {
		ArrayList<RiderENT> res = new ArrayList<>();
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT r.*, rtd.* FROM riders r "
					+ "INNER JOIN rider_tag_date rtd ON rtd.rider_id = r.rider_id "
					+ "WHERE rtd.date like ? AND r.username like ? and rtd.race_header_id IS NULL";
			PreparedStatement ps = conn.prepareStatement(query);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setString(1, "%" + dateFormat.format(date) + "%");
			ps.setString(2, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RiderENT entTMP = new RiderENT(rs.getInt("rider_id"),
						rs.getString("username"), rs.getInt("rider_tag_id"),
						"", rs.getString("date"), rs.getInt("tag_id"));
				res.add(entTMP);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	@Override
	public ArrayList<RiderENT> getAllNOTTaggedRiders(String searchKey)
			throws AMSException {
		ArrayList<RiderENT> res = new ArrayList<>();
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT r.* FROM riders r "
					+ "WHERE r.rider_id NOT IN  "
					+ "(SELECT rtd.rider_id FROM rider_tag_date rtd "
					+ "WHERE rtd.date like ?) AND r.username like ?";
			PreparedStatement ps = conn.prepareStatement(query);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setString(1, "%" + dateFormat.format(date) + "%");
			ps.setString(2, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RiderENT entTMP = new RiderENT(rs.getInt("rider_id"),
						rs.getString("username"));
				res.add(entTMP);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	@Override
	public RaceHeader getTheLatestOpenRace(RaceHeader race) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " SELECT * FROM race_header WHERE created_time like ? and "
					+ "start_time IS NULL or finish_time IS NULL order by race_header_id desc limit 1";
			PreparedStatement ps = conn.prepareStatement(query);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			ps.setString(1, "%" + dateFormat.format(date) + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				race = this
						.getArace(new RaceHeader(rs.getInt("race_header_id")));
			}
			ps.close();
			conn.close();
			if (race.getId() <= 0) {
				dateFormat = new SimpleDateFormat("MMMM-dd HH:mm");
				date = new Date();
				race = new RaceHeader(1, "Roof-Of-Africa-"
						+ dateFormat.format(date));
				return race;
			}
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return race;
	}

	@Override
	public void removeARace(int raceId) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " DELETE FROM race_header WHERE race_header_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, raceId);
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}

	}

	@Override
	public RaceHeader updateRace(RaceHeader ent) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " UPDATE race_header SET name = ?, lap_no = ? WHERE race_header_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, ent.getRaceName());
			ps.setInt(2, ent.getLap_no());
			ps.setInt(3, ent.getId());
			ps.execute();
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return this.getArace(ent);
	}

	@Override
	public ArrayList<RiderENT> getTaggedRidersList(String searchKey)
			throws AMSException {
		ArrayList<RiderENT> res = new ArrayList<>();
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = "SELECT r.*, rtd.*, t.tag_code FROM riders r "
					+ "INNER JOIN rider_tag_date rtd ON rtd.rider_id = r.rider_id  "
					+ "LEFT OUTER JOIN tags t ON t.tag_id = rtd.tag_id "
					+ "WHERE r.username like ? ORDER BY rtd.date DESC";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + searchKey + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RiderENT entTMP = new RiderENT(rs.getInt("rider_id"),
						rs.getString("username"), rs.getInt("rider_tag_id"),
						rs.getString("tag_code"), rs.getString("date"),
						rs.getInt("tag_id"));
				res.add(entTMP);
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
		return res;
	}

	@Override
	public void removeATagFromRider(int id) throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " DELETE FROM rider_tag_date WHERE rider_tag_id = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
	}

	@Override
	public void removeAllTags() throws AMSException {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			throw getAMSException(e.getMessage(),e);
		}
		Connection conn;
		try {
			conn = DriverManager.getConnection(DBADDRESS, "root", "");
			String query = " DELETE FROM rider_tag_date";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			ps.close();
		} catch (SQLException e) {
			throw getAMSException(e.getMessage(),e);
		}
	}

}
