
import java.awt.event.*;

import javax.swing.JTextField;

public class buttonAction implements ActionListener {
	AlienModule aModule;
	JTextField _degree, _distance, _type;
	public buttonAction(AlienModule _alienModule){
		aModule = _alienModule;
		
	}
	
	public buttonAction(AlienModule _alienModule, JTextField _deg, JTextField _dist, JTextField _tp){
		aModule = _alienModule;
		_degree = _deg;
		_distance = _dist;
		_type = _tp;
	}

    public void actionPerformed(ActionEvent e){
        if ("pulse".equals(e.getActionCommand())) {
        	aModule.AlienPulse();        	
        } 
        if ("SRtest".equals(e.getActionCommand())) {
        	aModule.SRTest(_degree.getText(), _distance.getText(), _type.getText());
        }
        if ("RRtest".equals(e.getActionCommand())) {
        	aModule.AlienPulse();        	
        }
        if ("summary".equals(e.getActionCommand())) {
        	aModule.AlienPulse();        	
        }
    }
}
