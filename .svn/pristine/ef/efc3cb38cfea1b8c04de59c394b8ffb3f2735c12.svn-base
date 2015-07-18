package au.edu.adelaide.pna.processes;

import java.util.HashMap;
import java.util.Map;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.pna.data.IntToken;
import au.edu.adelaide.pna.data.Token;
import au.edu.adelaide.pna.data.util.IllegalActionException;

public class ArithmaticProcessWithConstantWithToken extends ArithmaticProcessWithToken{

	public static final String DEFAULTVALUE = "defaultValue";
	public static final String value1 = "InputValue1";
	public static final String value2 = "InputValue2";
	public static final String STATICPORT = "staticPort";
	public static final String value3 = "OutputValue";
	String defaultValue;
	String staticPort;
	

	public ArithmaticProcessWithConstantWithToken() {
//		properties.put(Process.NAME, "ArtmaticProcess");
		properties.put(Process.NAME, "ArithmaticProcessWithConstantWithToken");
		properties.put("operator", "+");
		properties.put("defaultValue", "0");
		properties.put("staticPort", "-1");
		operator = (String) properties.get("operator");
	}
	
	public void preFire() {
		Map changes = new HashMap();
		operator = (String) properties.get("operator");
		defaultValue = (String) properties.get("defaultValue");
		staticPort =(String) properties.get("staticPort");
			changes.put(OPERATOR, operator);
			changes.put(DEFAULTVALUE, defaultValue);
			changes.put(STATICPORT, staticPort);
			updateData(changes);
	}

	public void fire(Map data) {

		
		IntToken tokenoutputToken = new IntToken();
		IntToken tokeninputToken = new IntToken();
		IntToken tokeninputToken1 = new IntToken();

		if (staticPort.equals("0")) {
			tokeninputToken1 = (IntToken) getInputPort(1).get();
			try {
				tokeninputToken = new IntToken(defaultValue);
			} catch (IllegalActionException e) {
				e.printStackTrace();
			}

		} else if (staticPort.equals("1")) {
			tokeninputToken = (IntToken) getInputPort(0).get();
			try {
				tokeninputToken1 = new IntToken(defaultValue);
			} catch (IllegalActionException e) {
				e.printStackTrace();
			}
		}
		

//		Integer	inputToken = new Integer(0);
//		Integer inputToken1 = new Integer(0);
//		
//		IntToken tokenoutputToken = new IntToken();
//		IntToken tokeninputToken = null ;
//		IntToken tokeninputToken1 = null;
//
//
//		if (staticPort.equals("0")) {
////			inputToken = new Integer(defaultValue);
//		 inputToken1 = (Integer)getInputPort(1).get();
//		 
//		 
//		  try {
//			tokeninputToken = new IntToken(defaultValue);
//		} catch (IllegalActionException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//			 tokeninputToken1 = new IntToken(inputToken1.intValue());
//	} else if (staticPort.equals("1")) {
//		 inputToken = (Integer)getInputPort(0).get();
////		 inputToken1 = new Integer(defaultValue);	 
//		  tokeninputToken = new IntToken(inputToken.intValue());
//			 try {
//				tokeninputToken1 = new IntToken(defaultValue);
//			} catch (IllegalActionException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//	}
		

		
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
		getOutputPort(0).put(tokenoutputToken);

		
		
		Map changes = getProperties();
		changes.put("previousProcess",prevProcess);
		
		if (staticPort.equals("0")) {
			changes.put(DEFAULTVALUE,defaultValue);
			changes.put(value2,tokeninputToken1);
	
			
		} else if (staticPort.equals("1")) {
			changes.put(value1,tokeninputToken);
			changes.put(DEFAULTVALUE,defaultValue);
		}
		
		if(!(tokenoutputToken.isNil())){
			changes.put(value3,tokenoutputToken);
		}
		
		updateData(changes);
	}

}

