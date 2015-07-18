package au.edu.adelaide.pna.processes;

import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.pna.data.IntToken;

public class IntegerPrinterWithToken extends AbstractProcess
{
	public static final String value1 = "InputValue";
	public static final String value2 = "OutputValueF";
	public IntegerPrinterWithToken()
	{
		properties.put(Process.NAME,"IntegerPrinterWithToken");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),1,0);
	}

	public void fire(Map data)
	{
		IntToken tokenoutputToken = new IntToken();
		IntToken tokeninputToken = new IntToken();
		tokeninputToken =  (IntToken) getInputPort(0).get();
		tokenoutputToken = tokeninputToken;
		
//		Integer inputToken =(Integer) getInputPort(0).get();
//		Integer outputToken = new Integer(inputToken);
		Map changes = getProperties();
		changes.put(value1,tokeninputToken);
		changes.put(value2,tokenoutputToken);
		changes.put("previousProcess",prevProcess);
		updateData(changes);
		
		System.out.println(tokenoutputToken.toString());
	}
}