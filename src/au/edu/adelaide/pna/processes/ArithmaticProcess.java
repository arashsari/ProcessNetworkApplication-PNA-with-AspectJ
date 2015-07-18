package au.edu.adelaide.pna.processes;

import java.util.HashMap;
import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;

public class ArithmaticProcess extends AbstractProcess {


	public static final String OPERATOR = "operator";
	public static final String value1 = "InputValue1";
	public static final String value2 = "InputValue2";
	public static final String value3 = "OutputValue";
	public static final String previousProcess = "previousProcess";
	
	String operator;

//	maximum value of 2,147,483,647
	int maxIntValue = 214748364;

	
	public ArithmaticProcess() {
		
		properties.put(Process.NAME, "ArtmaticProcess");
		properties.put("operator", "+");
		operator = (String) properties.get("operator");
		
		
	
	}



	public void init(Process process, Network network) {
		setNetwork(network);
		init(process, network.getFactory(), 2, 1);
		
	}
	
	public void preFire() {
//		Map changes = new HashMap();
		Map changes = getProperties();
		operator = (String) properties.get("operator");
//		prevProcess = (String) properties.get("previousProcess");
		
		try
		{
//			changes.put(previousProcess, prevProcess);
				changes.put(OPERATOR, operator);
			updateData(changes);
		}catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("exception parsing init and bound strings");
			}
//			changes.put(OPERATOR, operator);
//		updateData(changes);
	}
	
	

	public void fire(Map data) {
	
		
		Integer result = null;
		Integer outputToken = new Integer(maxIntValue);
		Integer inputToken =(Integer) getInputPort(0).get();
		Integer inputToken1 =(Integer) getInputPort(1).get();

		if ((operator.equals("+"))) {
			result = (Integer) inputToken + (Integer) inputToken1;
		} else if (operator.equals("*")) {
			result = ((Integer) inputToken) * ((Integer) inputToken1);
		} else if (operator.equals("-")) {
			result = ((Integer) inputToken) - ((Integer) inputToken1);
		}
		outputToken=result;
		getOutputPort(0).put((Object) outputToken);
		
//		Map changes = new HashMap();
		Map changes = getProperties();
		changes.put(value1,inputToken);
		changes.put(value2,inputToken1);
		changes.put("previousProcess",prevProcess);
		if(!outputToken.equals(maxIntValue)){
			changes.put(value3,outputToken);
		}
		updateData(changes);
		
	}

}


