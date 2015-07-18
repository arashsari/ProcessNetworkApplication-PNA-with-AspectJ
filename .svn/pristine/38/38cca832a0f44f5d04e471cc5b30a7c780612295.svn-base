package au.edu.adelaide.pna.processes;

import java.util.HashMap;
import java.util.Map;

import au.edu.adelaide.kahn.pn.Process;


public class ArithmaticProcessWithConstant extends ArithmaticProcess {

	public static final String DEFAULTVALUE = "defaultValue";
	public static final String value1 = "InputValue1";
	public static final String value2 = "InputValue2";
	public static final String STATICPORT = "staticPort";
	public static final String value3 = "OutputValue";
	String defaultValue;
	String staticPort;
	
	Integer i = new Integer(0);
//	maximum value of 2,147,483,647
	int maxIntValue = 214748364;

	public ArithmaticProcessWithConstant() {
//		properties.put(Process.NAME, "ArtmaticProcess");
		properties.put(Process.NAME, "ArithmaticProcessWithConstant");
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

		Integer result = null;
		Integer outputToken = new Integer(maxIntValue);
		
		Integer	inputToken = new Integer(0);
		Integer inputToken1 = new Integer(0);
 		
		if (staticPort.equals("0")) {
				inputToken = new Integer(defaultValue);
			 inputToken1 = (Integer)getInputPort(1).get();
		} else if (staticPort.equals("1")) {
			 inputToken = (Integer)getInputPort(0).get();
			 inputToken1 = new Integer(defaultValue);
		}

//		if ((inputToken.equals(maxIntValue)) || (inputToken1.equals(maxIntValue))){
//
//
//		}else{
		if ((operator.equals("+"))) {
			result = (Integer) inputToken + (Integer) inputToken1;
		} else if (operator.equals("*")) {
			result = ((Integer) inputToken) * ((Integer) inputToken1);
		} else if (operator.equals("-")) {
			result = ((Integer) inputToken) - ((Integer) inputToken1);
		}
		
		outputToken=result;
		getOutputPort(0).put((Object) outputToken);
//	}
		
		
		Map changes = getProperties();
		changes.put("previousProcess",prevProcess);
		
		if (staticPort.equals("0")) {
			changes.put(DEFAULTVALUE,defaultValue);
			changes.put(value2,inputToken1);
	
			
		} else if (staticPort.equals("1")) {
			changes.put(value1,inputToken);
			changes.put(DEFAULTVALUE,defaultValue);
		}
		
		if(!outputToken.equals(maxIntValue)){
			changes.put(value3,outputToken);
		}
		
		updateData(changes);
	}
}



