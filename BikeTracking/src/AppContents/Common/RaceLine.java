package AppContents.Common;

public class RaceLine {
	int checkPointId;
	String time;
	int riderTagId;
	int headerId;
	int raceLineId;

	public RaceLine() {
	}

	public RaceLine(int checkPointId, int riderTagId, int headerId,
			int raceLineId) {
		super();
		this.checkPointId = checkPointId;
		this.riderTagId = riderTagId;
		this.headerId = headerId;
		this.raceLineId = raceLineId;
	}

	public RaceLine(int checkPointId, String time, int riderTagId,
			int headerId, int raceLineId) {
		super();
		this.checkPointId = checkPointId;
		this.time = time;
		this.riderTagId = riderTagId;
		this.headerId = headerId;
		this.raceLineId = raceLineId;
	}

	public int getCheckPointId() {
		return checkPointId;
	}

	public void setCheckPointId(int checkPointId) {
		this.checkPointId = checkPointId;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getRiderTagId() {
		return riderTagId;
	}

	public void setRiderTagId(int riderTagId) {
		this.riderTagId = riderTagId;
	}

	public int getHeaderId() {
		return headerId;
	}

	public void setHeaderId(int headerId) {
		this.headerId = headerId;
	}

	public int getRaceLineId() {
		return raceLineId;
	}

	public void setRaceLineId(int raceLineId) {
		this.raceLineId = raceLineId;
	}

}
