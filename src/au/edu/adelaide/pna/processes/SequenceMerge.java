package au.edu.adelaide.pna.processes;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;

import java.util.Map;

public class SequenceMerge extends AbstractProcess
{
	public SequenceMerge()
	{
		properties.put(Process.NAME,"SequenceMerge");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),2,1);
	}

	public void fire(Map data)
	{
		Object token1 = getInputPort(0).get();
		getOutputPort(0).put(token1);
		Object token2 = getInputPort(1).get();
		getOutputPort(0).put(token2);
	}
}
