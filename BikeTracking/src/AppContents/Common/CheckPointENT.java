package AppContents.Common;

public class CheckPointENT {
	int id;
	String ip = "";
	String mac = "";
	String name = "";
	String gps = "";
	int checkPointRaceId = 0;
	int priority;

	public CheckPointENT() {
	}

	public CheckPointENT(int id, String ip, String mac, String name, String gps, int checkPointRaceId) {
		super();
		this.id = id;
		this.ip = ip;
		this.mac = mac;
		this.name = name;
		this.gps = gps;
		this.checkPointRaceId = checkPointRaceId;
	}

	public CheckPointENT(int id, int priority) {
		super();
		this.id = id;
		this.priority = priority;
	}

	public CheckPointENT(int id) {
		super();
		this.id = id;
	}

	public int getCheckPointRaceId() {
		return checkPointRaceId;
	}

	public void setCheckPointRaceId(int checkPointRaceId) {
		this.checkPointRaceId = checkPointRaceId;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGps() {
		return gps;
	}

	public void setGps(String gps) {
		this.gps = gps;
	}

}
