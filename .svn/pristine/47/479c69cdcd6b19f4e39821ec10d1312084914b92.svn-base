package au.edu.adelaide.kahn.pn;

import java.io.Serializable;
import java.util.Map;
import java.util.List;

/**
 * An interface describing the general structure of a Process.
 *
 * @author Darren Webb
 * @version $Id: Process.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface Process extends Serializable
{
	public static final String NAME = "Process Name";
	public static final String TYPE = "Process Type";
	
	public static final String previousProcess = "previousProcess";
	

	/* initialization */
	public void init(Process process,Network network);
	public void init(Process process,List inputPorts,List outputPorts,Network network);
	public Network getNetwork();
	public Map getProperties();
	public void updateProperties(Map properties);
	public String getID();
	
	

	/* activity */
	public void preFire();
	public boolean isFireable(Map data);
	public void fire(Map data);
	public Map getData();
	public void updateData(Map change);

	/* communication management */
	public InputPort getInputPort(int index);
	public int getInputPortCount();
	public List getInputPortList();
	public OutputPort getOutputPort(int index);
	public int getOutputPortCount();
	public List getOutputPortList();

	public void setPreviousProcess(Process pro1);
	public void setPrevProcessObj(Process prevProcessObj);
}
