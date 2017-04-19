package AppContents;

import java.util.ArrayList;

import AppContents.Common.*;
import tools.AMSException;

public interface AppDAOInterface {
	
	//TAG IDENTIFICATION
	public boolean allocateATagToARider(int riderId, String tagCode) throws AMSException;
	public boolean updateATagForARider(int riderId, String tagCode) throws AMSException;
	
	//RACE CONFIG
	public RaceHeader defineARace(RaceHeader race) throws AMSException;
	public RaceHeader startTheRace(RaceHeader race, boolean push) throws AMSException;
	public RaceHeader finishTheRace(RaceHeader race) throws AMSException;
	public RaceHeader getTheLatestOpenRace(RaceHeader race) throws AMSException;
	public RaceHeader getArace(RaceHeader race) throws AMSException;
	public RaceHeader allocateACheckPointToTheRace(CheckPointENT ent, int raceID) throws AMSException;
	public RaceHeader allocateATagRiderToARace(RiderENT rider, int raceID) throws AMSException;
	public ArrayList<RiderENT> getAllRiders (String searchKey) throws AMSException;
	public ArrayList<RiderENT> getAllNOTTaggedRiders (String searchKey) throws AMSException;
	public ArrayList<RiderENT> getAllTaggedRidersTODAY (String searchKey) throws AMSException;
	public ArrayList<RiderENT> getTaggedRidersList (String searchKey) throws AMSException;
	public RaceHeader removeATagRiderFromTheRace(int riderTageRaceId, int raceID) throws AMSException;
	public RaceHeader removeACheckPointFromTheRace(int checkpointRaceId, int raceID) throws AMSException;
	public RaceHeader addALineToTheRace (RaceLine line) throws AMSException;
	public RaceHeader getRaceForACheckpoint (CheckPointENT ent) throws AMSException;
	public RaceHeader updateRace (RaceHeader ent) throws AMSException;
	public ArrayList<RaceHeader> getAllRaces(RaceHeader race) throws AMSException;
	public void removeARace(int raceId) throws AMSException;
	public void removeATagFromRider(int id) throws AMSException;
	public void removeAllTags() throws AMSException;

	//CHECKPOINT 
	public CheckPointENT defineAcheckpoint(CheckPointENT ent) throws AMSException;
	public CheckPointENT updateAcheckpoint(CheckPointENT ent) throws AMSException;//returns checkpoint id
	public CheckPointENT getAcheckpoint(CheckPointENT ent) throws AMSException;//returns checkpoint id
	public void removeAcheckpoint(CheckPointENT ent) throws AMSException;//returns checkpoint id
	public ArrayList<CheckPointENT> getAllcheckpoints(CheckPointENT ent) throws AMSException;//returns checkpoint id
	ArrayList<CheckPointENT> getAllcheckpointsToAllocateToRace(int raceId, String search) throws AMSException;
	
	
	
	
	
	//check the number of checkpoints before finalize the race
	//the race has been started do u want to push it
	//getAllTaggedRiders and not in a race
	//priority in UI
	//form validation
	//check point duplicate name
	// check during a race not removing a rider or checkpoint
	
}
