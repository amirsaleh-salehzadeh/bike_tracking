package AppContents.Common;

public class RiderENT {
	int riderId;
	String riderUsername;
	int riderTagId;
	String tagCode;
	String date;
	int tagID;

	public RiderENT() {
	}

	public RiderENT(int riderId, String riderUsername, int riderTagId,
			String tagCode, String date, int tagID) {
		super();
		this.riderId = riderId;
		this.riderUsername = riderUsername;
		this.riderTagId = riderTagId;
		this.tagCode = tagCode;
		this.date = date;
		this.tagID = tagID;
	}

	public String getTagCode() {
		return tagCode;
	}

	public void setTagCode(String tagCode) {
		this.tagCode = tagCode;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getTagID() {
		return tagID;
	}

	public void setTagID(int tagID) {
		this.tagID = tagID;
	}

	public RiderENT(int riderId, String riderUsername, int riderTagId) {
		super();
		this.riderId = riderId;
		this.riderUsername = riderUsername;
		this.riderTagId = riderTagId;
	}

	public RiderENT(int riderId, String riderUsername) {
		super();
		this.riderId = riderId;
		this.riderUsername = riderUsername;
	}

	public int getRiderTagId() {
		return riderTagId;
	}

	public void setRiderTagId(int riderTagId) {
		this.riderTagId = riderTagId;
	}

	public int getRiderId() {
		return riderId;
	}

	public void setRiderId(int riderId) {
		this.riderId = riderId;
	}

	public String getRiderUsername() {
		return riderUsername;
	}

	public void setRiderUsername(String riderUsername) {
		this.riderUsername = riderUsername;
	}

}
