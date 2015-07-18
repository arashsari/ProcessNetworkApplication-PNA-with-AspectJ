package au.edu.adelaide.kahn.pn;

import java.io.Serializable;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

/**
 * A convenience implementation of the general structure of a Process.
 * A process is a single unit of work in a process network.  The
 * Process follows the strategy pattern, allowing pluggable 
 * implementation strategies that can be determined at run-time.
 *
 * @author Darren Webb
 * @version $Id: AbstractProcess.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public abstract class AbstractProcess implements Process
{
	protected HashMap data = new HashMap();
	protected HashMap properties = new HashMap();
	protected Factory factory;
	private List inputPortList = new ArrayList();
	private List outputPortList = new ArrayList();
	private Network network;
	public String prevProcess= null;
	public Process prevProcessObj= null;
	





	public AbstractProcess()
	{
		properties.put(Process.NAME,"Process");
	}

	/* initialization */
	public Map getProperties()
	{
		return (Map)properties.clone();
	}

	public void updateProperties(Map change)
	{
		properties.putAll(change);
	}

	/**
	 * Initialization used in place of the constructor.
	 * Some operations of the Enigma metalevel require
	 * initialization after the metaobject is created.
	 */
	public abstract void init(Process process,Network network);

	/**
	 * Initialize the process using the provided list entries as
	 * input and output ports.
	 */
	public void init(Process process,List inputPorts,List outputPorts,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),inputPorts,outputPorts);
	}

	/**
	 * Initialize the process using the provided factory to
	 * create the required number of input and output ports.
	 */
	protected void init(Process process,Factory factory,int inputCount,int outputCount)
	{
		List inputPortList = new ArrayList();
		for (int i=0;i<inputCount;i++)
			inputPortList.add(factory.newInputPort(process,i));

		List outputPortList = new ArrayList();
		for (int i=0;i<outputCount;i++)
			outputPortList.add(factory.newOutputPort(process,i));
		
		
		init(process,factory,inputPortList,outputPortList);
	}

	/**
	 * Initialize the process using the provided list entries as
	 * input and output ports.
	 */
	protected void init(Process process,Factory factory,List inputPortList,List outputPortList)
	{
		this.factory = factory;
		this.inputPortList = inputPortList;
		this.outputPortList = outputPortList;
	}

	public Network getNetwork()
	{
		return network;
	}

	public void setNetwork(Network network)
	{
		this.network = network;
	}

	public String getID()
	{
		return "Process."+hashCode();
	}

	/* activity */

	public void preFire()
	{
	
	}

	public boolean isFireable(Map data)
	{
		return true;
	}

	public abstract void fire(Map data);

	public Map getData()
	{
		return (Map)data.clone();
	}

	public void updateData(Map change)
	{
		data.putAll(change);
	}

	/* communication management */

	public Factory getFactory()
	{
		return factory;
	}

	public InputPort getInputPort(int index)
	{
		if (!(index < inputPortList.size()))
			throw new IllegalArgumentException();
		return (InputPort)inputPortList.get(index);
	}

	public List getInputPortList()
	{
		return Collections.unmodifiableList(inputPortList);
	}

	public int getInputPortCount()
	{
		return inputPortList.size();
	}

	public OutputPort getOutputPort(int index)
	{
		if (!(index < outputPortList.size()))
			throw new IllegalArgumentException();
		return (OutputPort)outputPortList.get(index);
	}

	public List getOutputPortList()
	{
		return Collections.unmodifiableList(outputPortList);
	}

	public int getOutputPortCount()
	{
		return outputPortList.size();
	}
	
	
	public void setPreviousProcess(Process pro1){
			this.prevProcess = pro1.toString();
	}
	
	public String getPreviousProcess(){
		return this.prevProcess;
}
	public Process getPrevProcessObj() {
		return prevProcessObj;
	}

	public void setPrevProcessObj(Process prevProcessObj) {
		this.prevProcessObj = prevProcessObj;
	}
}
