package au.edu.adelaide.pna.processes;

import java.util.HashMap;
import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.pna.data.IntToken;

public class IntegerProducerWithToken extends AbstractProcess
{
	public static final String NEXT = "next integer";
	public static final String UPPER = "upper bound";
	public static final String value3 = "OutputValue";
	public IntegerProducerWithToken()
	{
		properties.put(Process.NAME,"IntegerProducerWithToken");
		properties.put("Initial Value","0");
		properties.put("Upper Bound","0");
	}

	public void init(Process process,Network network)
	{
		setNetwork(network);
		init(process,network.getFactory(),0,1);
	}

	public void preFire()
	{
		Map changes = new HashMap();
		String initValueString = (String)properties.get("Initial Value");
		String upperValueString = (String)properties.get("Upper Bound");
		Integer initValue = new Integer(0);
		Integer upperValue = new Integer(0);
		try
		{
			initValue = new Integer(initValueString);
			upperValue = new Integer(upperValueString);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("exception parsing init and bound strings");
			System.out.println("init="+initValueString);
			System.out.println("bound="+upperValueString);
		}
		changes.put(NEXT,initValue);
		changes.put(UPPER,upperValue);
		updateData(changes);
	}

	public boolean isFireable(Map data)
	{
		Integer nextInt = (Integer)data.get(NEXT);
		Integer upperBound = (Integer)data.get(UPPER);
		return (nextInt.intValue() <= upperBound.intValue());
	}

	public void fire(Map data) {
		Integer nextInt = (Integer) data.get(NEXT);

		IntToken outputToken = new IntToken(nextInt.intValue());
//		Integer outputToken = new Integer(nextInt);
		getOutputPort(0).put(outputToken);
		
		Map changes = getProperties();
		changes.put(NEXT, new Integer(nextInt.intValue() + 1));
		changes.put(value3, outputToken);
		changes.put("previousProcess",prevProcess);
		updateData(changes);
	}
}
