package au.edu.adelaide.pna.processes;

import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.pna.data.*;
import au.edu.adelaide.pna.data.util.IllegalActionException;

public class ArithmaticProcessWithToken extends AbstractProcess {

	public static final String OPERATOR = "operator";
	public static final String value1 = "InputValue1";
	public static final String value2 = "InputValue2";
	public static final String value3 = "OutputValue";
	public static final String previousProcess = "previousProcess";
	String operator;
	
	public ArithmaticProcessWithToken(){
		properties.put(Process.NAME, "ArithmaticProcessWithToken");
		properties.put("operator", "+");
		operator = (String) properties.get("operator");
	}


	@Override
	public void init(Process process, Network network) {
		// TODO Auto-generated method stub
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
		IntToken tokenoutputToken = new IntToken();
		IntToken tokeninputToken = new IntToken();
		IntToken tokeninputToken1 = new IntToken();
		
		tokeninputToken =  (IntToken) getInputPort(0).get();
		tokeninputToken1 =  (IntToken) getInputPort(1).get();
		tokenoutputToken = fireOperationMethod(tokenoutputToken,
				tokeninputToken, tokeninputToken1);
		getOutputPort(0).put(tokenoutputToken);
		
//		Map changes = new HashMap();
		Map changes = getProperties();
		changes.put(value1,tokeninputToken);
		changes.put(value2,tokeninputToken1);
		changes.put("previousProcess",prevProcess);
		if(!(tokenoutputToken.isNil())){
			changes.put(value3,tokenoutputToken);
		}
		updateData(changes);
		
	}


	private IntToken fireOperationMethod(IntToken tokenoutputToken,
			IntToken tokeninputToken, IntToken tokeninputToken1) {
		if ((operator.equals("+"))) {
			try {
				tokenoutputToken =  (IntToken) tokeninputToken.add(tokeninputToken1);
			} catch (IllegalActionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (operator.equals("*")) {
			try {
				tokenoutputToken = (IntToken) tokeninputToken.multiply(tokeninputToken1);
			} catch (IllegalActionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (operator.equals("-")) {
			try {
				tokenoutputToken = (IntToken) tokeninputToken.subtract(tokeninputToken1);
			} catch (IllegalActionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return tokenoutputToken;
	}

}
////		int inputToken = (int) getInputPort(0).get();
////		int inputToken1 = (int) getInputPort(1).get();
//		
////		IntToken tokenoutputToken = new IntToken();
////		IntToken tokeninputToken = new IntToken(inputToken);
////		IntToken tokeninputToken1 = new IntToken(inputToken1);
//		
////		tokeninputToken = (IntToken) getInputPort(0).get();
////		tokeninputToken1 = (IntToken) getInputPort(1).get();
////		
//		
//
//		if ((operator.equals("+"))) {
//			try {
//				tokenoutputToken =  (IntToken) tokeninputToken.add(tokeninputToken1);
//			} catch (IllegalActionException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		} else if (operator.equals("*")) {
//			try {
//				tokenoutputToken = (IntToken) tokeninputToken.multiply(tokeninputToken1);
//			} catch (IllegalActionException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		} else if (operator.equals("-")) {
//			try {
//				tokenoutputToken = (IntToken) tokeninputToken.subtract(tokeninputToken1);
//			} catch (IllegalActionException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		getOutputPort(0).put(tokenoutputToken);
//		
////		Map changes = new HashMap();
//		Map changes = getProperties();
//		changes.put(value1,tokeninputToken);
//		changes.put(value2,tokeninputToken1);
//		changes.put("previousProcess",prevProcess);
//		if(!(tokenoutputToken.isNil())){
//			changes.put(value3,tokenoutputToken);
//		}
//		updateData(changes);
//		
//	}
//
//}
