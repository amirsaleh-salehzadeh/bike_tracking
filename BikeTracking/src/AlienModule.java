import java.awt.FlowLayout;
//import java.util.ArrayList;
import java.util.HashMap;
import java.net.InetAddress;

import javax.swing.JFrame;
//import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextArea;
//import javax.swing.JTextField;

import com.alien.enterpriseRFID.notify.Message;
import com.alien.enterpriseRFID.notify.MessageListener;
import com.alien.enterpriseRFID.notify.MessageListenerService;
import com.alien.enterpriseRFID.reader.*;
import com.alien.enterpriseRFID.tags.*;
import com.sun.corba.se.impl.encoding.OSFCodeSetRegistry.Entry;

public class AlienModule {
  HashMap<String, Integer> srTest;
  AlienClass1Reader reader;
  public AlienModule() {
    reader = new AlienClass1Reader();
    reader.setConnection("COM1");
    // To connect to a networked reader instead, use the following:
    reader.setConnection("150.164.7.72", 23);
    reader.setUsername("alien");
    reader.setPassword("password");
  }
  
  public void AlienPulse(){
    // Open a connection to the reader
    try {
      reader.open();
   //  Ask the reader to read tags and print them
     Tag tagList[] = reader.getTagList();
      if (tagList == null) {
        System.out.println("No Tags Found");
      } else {
        System.out.println("Tag(s) found:");
        JFrame frame = new JFrame("TP-IOT");
        JPanel controlPanel = new JPanel();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        controlPanel.setLayout(new FlowLayout());
        String result = "Tags Found:\n";
        for (int i=0; i<tagList.length; i++) {
          Tag tag = tagList[i];
         result = result + "ID:" + tag.getTagID() +
                  ", Discovered: " + tag.getDiscoverTime() +
                  ", | Last Seen:" + tag.getRenewTime() +
                  ", | Antenna:" + tag.getAntenna() +
                  ", | Reads:" + tag.getRenewCount() + "\n";
          
          
          System.out.println("ID:" + tag.getTagID() +
                           ", Discovered:" + tag.getDiscoverTime() +
                           ", Last Seen:" + tag.getRenewTime() +
                           ", Antenna:" + tag.getAntenna() +
                           ", Reads:" + tag.getRenewCount()
                           );
          }
        if (tagList.length == 0)
        	result = "No tags found";
        JTextArea label = new JTextArea(result);
        controlPanel.add(label);
        frame.getContentPane().add(controlPanel);
        frame.pack();
        frame.setVisible(true);
      } // Close the connection
      
        reader.close();
    }
    catch (AlienReaderException e){
      System.out.println("Error: " + e.toString());
    }
  }
  
  public void SRTest(String degree, String distance, String type){
	srTest = new HashMap<String, Integer>();
    try {
	  reader.open();
	  //Itera 10x
	  for(int j = 0; j < 10; j++){
	    Tag tagList[] = reader.getTagList();
	    if (tagList == null) {
	      System.out.println("No Tags Found");
	    } else {
	      System.out.println("Tag(s) found:");	          
	      for (int i=0; i<tagList.length; i++) {
	        Tag tag = tagList[i];
	        System.out.println(tag.getTagID());
	        if (!srTest.containsKey(tag.getTagID())){
	          srTest.put(tag.getTagID(), 1);
	        } else{
	    	  srTest.put(tag.getTagID(), srTest.get(tag.getTagID()) + 1 );
	        }
	      }
	    }
	  }
    
	  JFrame frame = new JFrame("TP-IOT");
	  JPanel controlPanel = new JPanel();
	  controlPanel.setLayout(new FlowLayout());
	  frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	  String result_text = "Tipo: " + type + "\n" +
	    "Distância: " + distance + "\n" +
		"Grau: " + degree + "\n";
	  for(java.util.Map.Entry<String, Integer> entry: srTest.entrySet()){
		  result_text = result_text + "Tag: " + entry.getKey() +
				  " Lida: " + entry.getValue().toString() + "\n";
	  }
	  JTextArea label = new JTextArea(result_text);
	  controlPanel.add(label);
	  frame.getContentPane().add(controlPanel);
	  frame.pack();
	  frame.setVisible(true);
	  // Close the connection
	  reader.close();
	} catch (AlienReaderException e){
	    System.out.println("Error: " + e.toString());
	}
	  
  }
  
  public void GenerateReport(){
	  
  }
  
  public void AlienAutonomous(){
	try{
	  MessageListenerModule service = new MessageListenerModule(3000);
	  reader.open();
	  reader.setAutoMode(AlienClass1Reader.ON);
	  reader.setTagStreamFormat(AlienClass1Reader.TEXT_FORMAT); // Make sure service can decode it.
	  //reader.setTagStreamMode(AlienClass1Reader.ON);
	  //reader.setNotifyAddress(InetAddress.getLocalHost().getHostAddress(), service.getListenerPort());
	  reader.setNotifyAddress("192.168.1.66", 23);
	  //reader.setNotifyFormat(AlienClass1Reader.XML_FORMAT); // Make sure service can decode it.
	  reader.setNotifyTrigger("TrueFalse"); // Notify whether there's a tag or not
	  reader.setAutoStopTimer(1000); // Read for 1 second
	  reader.autoModeReset();
	  reader.setNotifyMode(AlienClass1Reader.ON);
	  reader.close();
	} catch (Exception e){
	  System.out.println("Error: " + "Autonomous Refused" + e.toString());
	}
  }
  
  public void AlienOff(){
	try{
	  reader.open();
	  reader.autoModeReset();
	  //reader.setAutoMode(AlienClass1Reader.OFF);
	  reader.close();
	} catch (AlienReaderException e){
	  System.out.println("Error: " + "Autonomous command Refused " + e.toString());
	}
  }
  
  public class MessageListenerModule implements MessageListener  {
	  int listenerPort;
	/**
	 * Constructor.
	 */
	  public MessageListenerModule(int i) throws Exception {
	  // Set up the message listener service
	    listenerPort = i;
	    MessageListenerService service = new MessageListenerService(i);
	    service.setMessageListener(this);
	    service.startService();
	    System.out.println("Listener has started");
	  
	  }


	/**
	 * A single Message has been received from a Reader.
	 *
	 * @param message the notification message received from the reader
	 */
	  public void messageReceived(Message message){
		System.out.println("\nMessage Received:");
	    if (message.getTagCount() == 0) {
	      System.out.println("(No Tags)");
	    } else {
	      for (int i = 0; i < message.getTagCount(); i++) {
	        Tag tag = message.getTag(i);
	        System.out.println(tag.toLongString());
	      }
	    }
	  }
	  
	  public int getListenerPort(){
	    return listenerPort;
	  }
	}
  
}

