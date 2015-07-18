package au.edu.adelaide.pna.processes;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;

import java.util.Map;

public class Identity extends AbstractProcess
{
	
	public Identity()
	{
		properties.put(Process.NAME,"Identity");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),1,1);
	}

	public void fire(Map data)
	{
		Object inputToken = getInputPort(0).get();
		Map changes = getProperties();
		changes.put("InputValue",inputToken);
		changes.put("OutputValue",inputToken);
		changes.put("previousProcess",prevProcess);
		updateData(changes);

//		getOutputPort(0).put(getInputPort(0).get());
		getOutputPort(0).put(inputToken);
	}
}
