package au.edu.adelaide.pna.processes;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;

import java.util.Map;

public class Splitter extends AbstractProcess
{
	public static final String value1 = "InputValue";
	public static final String value2 = "OutputValue1";
	public static final String value3 = "OutputValue2";
	public Splitter()
	{
		properties.put(Process.NAME,"Splitter");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),1,2);
	}

	public void fire(Map data)
	{

		
		Map changes = getProperties();
		Object token = getInputPort(0).get();
		getOutputPort(0).put(token);
		getOutputPort(1).put(token);
		
		changes.put(value1,token);
		changes.put(value2,token);

		changes.put(value3,token);
		changes.put("previousProcess",prevProcess);
		
		updateData(changes);
	}
}
