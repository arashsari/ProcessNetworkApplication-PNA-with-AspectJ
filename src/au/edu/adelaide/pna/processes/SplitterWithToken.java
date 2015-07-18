package au.edu.adelaide.pna.processes;

import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.pna.data.IntToken;

public class SplitterWithToken extends AbstractProcess
{
	public static final String value1 = "InputValue";
	public static final String value2 = "OutputValue1";
	public static final String value3 = "OutputValue2";
	public SplitterWithToken()
	{
		properties.put(Process.NAME,"SplitterWithToken");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),1,2);
	}

	public void fire(Map data)
	{
		Map changes = getProperties();
	
//		IntToken tokenoutputToken = new IntToken();
//		IntToken tokenoutputToken1 = new IntToken();
		IntToken tokeninputToken = new IntToken();
		tokeninputToken =  (IntToken) getInputPort(0).get();
		
		getOutputPort(0).put(tokeninputToken);
		getOutputPort(1).put(tokeninputToken);
		
		
//		Object token = getInputPort(0).get();
//		getOutputPort(0).put(token);
//		getOutputPort(1).put(token);
//		
		changes.put(value1,tokeninputToken);
		changes.put(value2,tokeninputToken);

		changes.put(value3,tokeninputToken);
		changes.put("previousProcess",prevProcess);
		
		updateData(changes);
	}
}
