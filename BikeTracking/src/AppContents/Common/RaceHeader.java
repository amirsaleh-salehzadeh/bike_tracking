package AppContents.Common;

import java.util.ArrayList;

public class RaceHeader {
	int id;
	int lap_no;
	String sDateTime;
	String fDateTime;
	String cDateTime;
	String raceName;
	int countRiders;
	int countCheckpoints;
	ArrayList<RaceLine> raceLines;
	ArrayList<CheckPointENT> checkPoint;
	ArrayList<RiderENT> riders;

	public int getCountRiders() {
		return countRiders;
	}

	public void setCountRiders(int countRiders) {
		this.countRiders = countRiders;
	}

	public int getCountCheckpoints() {
		return countCheckpoints;
	}

	public void setCountCheckpoints(int countCheckpoints) {
		this.countCheckpoints = countCheckpoints;
	}

	public RaceHeader() {
	}

	public RaceHeader(int id, int lap_no, String sDateTime, String fDateTime,
			String raceName, ArrayList<RaceLine> raceLines,
			ArrayList<CheckPointENT> checkPoint, ArrayList<RiderENT> riders) {
		super();
		this.id = id;
		this.lap_no = lap_no;
		this.sDateTime = sDateTime;
		this.fDateTime = fDateTime;
		this.raceLines = raceLines;
		this.checkPoint = checkPoint;
		this.riders = riders;
		this.raceName = raceName;
	}

	public RaceHeader(int id) {
		super();
		this.id = id;
	}

	public RaceHeader(int lap_no, String raceName) {
		super();
		this.lap_no = lap_no;
		this.raceName = raceName;
	}

	public RaceHeader(int id, String sDateTime, String fDateTime) {
		super();
		this.id = id;
		this.sDateTime = sDateTime;
		this.fDateTime = fDateTime;
	}

	public String getRaceName() {
		return raceName;
	}

	public void setRaceName(String raceName) {
		this.raceName = raceName;
	}

	public ArrayList<CheckPointENT> getCheckPoint() {
		return checkPoint;
	}

	public void setCheckPoint(ArrayList<CheckPointENT> checkPoint) {
		if(this.checkPoint == null)
			this.checkPoint = new ArrayList<>();
		this.checkPoint = checkPoint;
	}

	public ArrayList<RiderENT> getRiders() {
		return riders;
	}

	public void setRiders(ArrayList<RiderENT> riders) {
		if(this.riders == null)
			this.riders = new ArrayList<>();
		this.riders = riders;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getLap_no() {
		return lap_no;
	}

	public void setLap_no(int lap_no) {
		this.lap_no = lap_no;
	}

	public String getsDateTime() {
		return sDateTime;
	}

	public void setsDateTime(String sDateTime) {
		this.sDateTime = sDateTime;
	}

	public String getfDateTime() {
		return fDateTime;
	}

	public void setfDateTime(String fDateTime) {
		this.fDateTime = fDateTime;
	}

	public String getcDateTime() {
		return cDateTime;
	}

	public void setcDateTime(String cDateTime) {
		this.cDateTime = cDateTime;
	}

	public ArrayList<RaceLine> getRaceLines() {
		return raceLines;
	}

	public void setRaceLines(ArrayList<RaceLine> raceLines) {
		if(this.raceLines == null)
			this.raceLines = new ArrayList<>();
		this.raceLines = raceLines;
	}

}
