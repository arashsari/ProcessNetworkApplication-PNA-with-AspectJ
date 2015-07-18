package au.edu.adelaide.pna.processes;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;

import java.util.HashMap;
import java.util.Map;

public class IntegerPrinter extends AbstractProcess
{

	public IntegerPrinter()
	{
		properties.put(Process.NAME,"IntegerPrinter");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),1,0);
	}

	public void fire(Map data)
	{

		Integer inputToken =(Integer) getInputPort(0).get();
		Integer outputToken = new Integer(inputToken);
		Map changes = getProperties();
		changes.put("InputValue",inputToken);
		changes.put("OutputValue",outputToken);
		changes.put("previousProcess",prevProcess);
		updateData(changes);
		
		System.out.println(outputToken);
	}
}
