

package au.edu.adelaide.aspectj;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import au.edu.adelaide.pna.system.InformationServiceQuantizer;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import java.text.SimpleDateFormat;
import java.util.Date;

import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.pna.system.ProcessThreadImpl;

/**
 * The implementation of needed aspect and pointcuts referred in "AbstractProvenanceModel".
 * The result would be presented in a console and in a form of a log.
 * 
 * @author mehdi sarikhani
 *
 */
public aspect ProvenanceModelTXT extends AbstractProvenanceModel{

}
//	
//	InformationServiceQuantizer isq = new InformationServiceQuantizer();
//	
//	///////////////////////////////////////////////////////////////////
//    //                    Specification
//    
//    /** Called before registering workflow contents. */
//	pointcut specificationStart():  execution (*
//			au.edu.adelaide.extendPagis.test.Test1.main(..));
//	
//	 before(): specificationStart() {
//		 if(!(isq.granularityLevel == 9)){
//	 SimpleDateFormat simpleDateFormat =
//	 new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//	 String output = " ***    ////////////    "+simpleDateFormat.format(new Date());
//	 output = output +"   specificationStart started    /////////"+ " ";
//	 System.out.println( output);
//		 }
//	 }
//
//    /** Called when finished registering workflow contents. */
//	pointcut specificationStop():execution (* au.edu.adelaide.pagis.system.PagisBuilder.trigger());
//	before(): specificationStop() {
//		if(!(isq.granularityLevel == 9)){
//		 SimpleDateFormat simpleDateFormat =
//   	 new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		 String output = " ***     ///////////////// "+simpleDateFormat.format(new Date());
//		 output = output +"   specification stopped   ////// "+ "";
//		 System.out.println( output);
//		}
//	}
//
//    
////	/** Register an actor. */
//	pointcut regActor(): 
//		execution (* au.edu.adelaide.kahn.pn.Factory.newProcess(..)) && target(au.edu.adelaide.extendPagis.system.MyPagisKahnFactory) ;
//
//	Object around(): regActor() {
//		if(!(isq.granularityLevel == 9)){
//		Object[] args = thisJoinPoint.getArgs();
//		Object callee = thisJoinPoint.getTarget();
//		SimpleDateFormat simpleDateFormat =
//		new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***"+simpleDateFormat.format(new Date());
//		Object ret = proceed();
//		output = output +" regActor Aspect register the process name : " + ret
//				+ " process id :" + ret.hashCode();
//		output = output +"    -> This process is created by :" + callee
//				+ " and it has " + args.length + " argument/s ";
//		for (int i = 0; i < args.length; i++) {
//			output = output +"Argument: " + i + " : " + args[i] + " ";
//		}
//		System.out.println( output);
//		return ret;
//		}else {
//			Object ret = proceed();
//			return ret;
//		}
//		
//	}
//
//
//	/** Register a Inputport or portparameter. */
//	pointcut regInputPort(): execution (*
//			au.edu.adelaide.kahn.pn.Factory.newInputPort(..)) && target(au.edu.adelaide.extendPagis.system.MyPagisKahnFactory) ;
//	Object around(): regInputPort() {
//		if(!(isq.granularityLevel == 9)){
//		Object[] args = thisJoinPoint.getArgs();
//		Object callee = thisJoinPoint.getTarget();
//		Object ret = proceed();
//		SimpleDateFormat simpleDateFormat =
//		new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***"+simpleDateFormat.format(new Date());
//		output = output +" regPort Aspect register the Inport No.: " + args[1]
//				+ "  of the Process " + args[0]
//				+ " and it is connected to the channel name : " + ret;
//		System.out.println( output);
//		return ret;
//		}else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//		/** Register a Outputport or portparameter. */
//	pointcut regOutputPort(): execution (*
//			au.edu.adelaide.kahn.pn.Factory.newOutputPort(..)) && target(au.edu.adelaide.extendPagis.system.MyPagisKahnFactory) ;
//
//	Object around(): regOutputPort() {
//		if(!(isq.granularityLevel == 9)){
//		Object[] args = thisJoinPoint.getArgs();
//		Object callee = thisJoinPoint.getTarget();
//		Object ret = proceed();
//		SimpleDateFormat simpleDateFormat =
//		new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***"+simpleDateFormat.format(new Date());
//		output = output +" regPort Aspect register the Outputport No.: "
//				+ args[1] + "  of the Process " + args[0]
//				+ " and it is connected to the channel name : " + ret;
//		System.out.println( output);
//		return ret;
//	}else {
//		Object ret = proceed();
//		return ret;
//	}
//	}		
//		
//		
//		
//	 // Register a parameter. A parameter can be anything
//
//	pointcut regParameter(Map m): execution (*
//			au.edu.adelaide.kahn.pn.AbstractProcess.updateProperties(..)) && args(m)&&target(au.edu.adelaide.kahn.pn.AbstractProcess);//&& withincode(au.edu.adelaide.extendPagis.test.Test1.main(..));
//
//	Object around(Map m): regParameter(m) {
//		if(!(isq.granularityLevel == 9)){
//		SimpleDateFormat simpleDateFormat =
//				 new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***"+simpleDateFormat.format(new Date());
//		Object[] args = thisJoinPoint.getArgs();
//		Object callee = thisJoinPoint.getTarget();
//		Object ret = proceed(m);
//		 output = output +" regParameter Aspect register the Parameter : " +m+
//				" in the Process name  "+ callee ;
//				System.out.println( output);
//			return ret;
//		}else {
//			Object ret = proceed(m);
//			return ret;
//		}
//	}
//	
//	
//
//    /** Register a link between two port
//     * It is also called channel.
//     */
//	pointcut regLink(): execution (*
//			 au.edu.adelaide.pagis.system.PagisBuilder.connect(..)) 
//			 && target(au.edu.adelaide.pagis.system.PagisBuilder) ;
//			
//	 Object around(): regLink() {
//		 if(!(isq.granularityLevel == 9)){
//	 Object[] args = thisJoinPoint.getArgs();
//	 Object callee = thisJoinPoint.getTarget();
//	  Object ret = proceed();
//	SimpleDateFormat simpleDateFormat =
//	new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//	String output = " ***"+simpleDateFormat.format(new Date());
//	output = output +" regLink Aspect register the channel name : " +ret +
//			 " between outputport name " + args[0]+" and inputport name" + args[1];
//	 System.out.println( output);
//	 return ret;
//		}else {
//			Object ret = proceed();
//			return ret;
//		}
//	 }
//
//	
//    /** Register a relation.
//     *
//     * It is captured in runtime ot just capture" WastriggeredBy" relationShip.
//     */
//	pointcut regRelation(): execution (*
//			 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
//
//  
//	
//    ///////////////////////////////////////////////////////////////////
//    //                     Execution of workflow
//	
//	
//	/** Record the starting of workflow execution. */
//	pointcut executionStart(): execution (* au.edu.adelaide.pagis.system.PagisBuilder.trigger());
//	
//	before(): executionStart() {
//		if(!(isq.granularityLevel == 9)){
//	 SimpleDateFormat simpleDateFormat =
//	 new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//	 String output = " ***  ////////////"+simpleDateFormat.format(new Date());
//	 System.out.println(output + "   execution Started   ////////////");
//		}
//}
//
//	/** Record the stopping of workflow execution. */
//	pointcut executionStop(): execution (*
//			au.edu.adelaide.extendPagis.test.Test1.main(..));
//	// It is hard to implement yet, Need further information, Implement it later.
//
//	
//
//    /** Record an actor firing. 
//     *  it is not collected for  medium and coarse-grained level of provenance. 
//     * */
//	pointcut actorFire():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	Object around(): actorFire() {
//		
//	  if(!(isq.getGranularityLevel() == 0) && (!(isq.granularityLevel == 9))){
//		Object callee = thisJoinPoint.getTarget();
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//				"yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***" + simpleDateFormat.format(new Date());
//		output = output + " Method fire() of Process name " + callee + " ";
//		System.out.println(output);
//	  }	
//	  Object ret = proceed();
//	return ret;
//	}
//
//	 /** Record an actor firing. 
//     *  it is not collected for fine-grained level of provenance. 
//     * */
//	pointcut actorFireWithInfo():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	Object around(): actorFire() {
//		
//	  if((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)){	
//		String filedName = thisJoinPoint.getSignature().getName();
//		Object[] args = thisJoinPoint.getArgs();
//		Object caller = thisJoinPoint.getThis();
//		Object callee = thisJoinPoint.getTarget();
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//				"yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***" + simpleDateFormat.format(new Date());
//		output = output + " Method fire() of Process name " + callee + " ";
//		output = output + " with arguments " + args[0];
//		System.out.println(output);
//	  }	
//	  Object ret = proceed();
//	return ret;
//	}
//	   
//	   /** Record a Outpuport event. */
//	pointcut OutputPortEvent(Object token): execution (* au.edu.adelaide.kahn.pn.OutputPort.put(Object)) && args(token) && target(au.edu.adelaide.pagis.halfchannel.HalfChannelOutputPortImpl);
//
//Object around(Object token): OutputPortEvent(token) {
//	if(!(isq.granularityLevel == 9)){
//	Object[] args = thisJoinPoint.getArgs();
//	Object caller = thisJoinPoint.getThis();
//	Object callee = thisJoinPoint.getTarget();
//	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//			"yyyy/dd/MM hh:mm:ss.SSS");
//	String output = " ***" + simpleDateFormat.format(new Date());
//	Object ret = proceed(token);
//		output = output + " OutputPort intercation with Channel : " + callee  + " Token value =   "+ token  ;
//	System.out.println(output);
//	return ret;
//	}else {
//		Object ret = proceed(token);
//		return ret;
//	}
//}
//	
///** Record a InputPort event. */
//	pointcut InputPortEvent(): execution (* au.edu.adelaide.kahn.pn.InputPort.get(..)) && target(au.edu.adelaide.pagis.halfchannel.HalfChannelInputPortImpl);
//       Object around(): InputPortEvent() 
//       {
//    		if(!(isq.granularityLevel == 9)){
//		Object[] args = thisJoinPoint.getArgs();
//		Object caller = thisJoinPoint.getThis();
//		Object callee = thisJoinPoint.getTarget();
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//				"yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***" + simpleDateFormat.format(new Date());
//		Object ret = proceed();
//		output = output + " InputPort intercation with Channel : " + callee
//				+ " Token value =  " + ret + " ";
//		System.out.println(output);
//		return ret;
//		}else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//	    
//
//		
//	    ////////////////////////////////////////////////////////////////////////
//	    //// relationship methods                                              ////
//
//	    /** Record WasGeneratedBy relationship.
//	     * 
//	     * It can be useful in OPM model not here.
//	     *  */
//
//		
//	// not collect artifact value but shows the dependency
//		 pointcut WasGeneratedBy(): execution (*
//		 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
//
//		Object around(): WasGeneratedBy() {
//			if(!(isq.granularityLevel == 9)){
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = "***" + simpleDateFormat.format(new Date());
//			output = output + " relation == WasGeneratedBy ; ";
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object caller = thisJoinPoint.getThis();
//			Object ret = proceed();
//			output = output + "  Channel.id = " + +ret.hashCode()
//					+ "  Channel.name = " + ret;
//			output = output + "  Process.id = " + +callee.hashCode()
//					+ "  Process.name = " + callee;
//			output = output + "***";
////		 for (int i = 0; i < args.length; i++)
////		 {
////		  output = output+" outputport index = "+ args[i] +" ,";
////		 }
//				System.out.println(output);
//			return ret;
//			}else {
//				Object ret = proceed();
//				return ret;
//			}
//		}
//
//		  /** Record Used relationship. */
//		 /////////////////////////
//		 //  it can't capture the artifact while it shows the dependency. 
//		 //// // Track all the input value and process operator in all Processes.
//		pointcut Used():execution (* au.edu.adelaide.kahn.pn.AbstractProcess.getInputPort(..));
//
//		Object around(): Used() {
//			if(!(isq.granularityLevel == 9)){
//			String output = " ";
//			Object caller = null;
//			Object callee = null;
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			output = "***" + simpleDateFormat.format(new Date());
//			output = output + " relation == Used ;";
//			Object[] args = thisJoinPoint.getArgs();
//			caller = thisJoinPoint.getThis();
//			callee = thisJoinPoint.getTarget();
//			Object ret = proceed();
//			output = output + "  Channel.id = " + +ret.hashCode()
//					+ "  Channel.name = " + ret;
//			// output = output + " arithmaticProcess = "+callee.hashCode();
//			output = output + " Process.id = " + +callee.hashCode()
//					+ " Process.name = " + callee.getClass().getSimpleName();
//			output = output + "***";
//			System.out.println(output);
//			return ret;
//		}else {
//			Object ret = proceed();
//			return ret;
//		}
//		}
//		
//		 /** Record an actor firing. 
//	     *  it is not collected for fine-grained level of provenance. 
//	     * */
//		pointcut wasDeriviedFrom():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//	    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//		Object around(): wasDeriviedFrom() {
//			
//		  if((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)){	
//			String filedName = thisJoinPoint.getSignature().getName();
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " wasDeriviedFrom : in Process name " + callee + " ";
////			output = output + " with arguments " + args[0];
//			
//			///////////////////////////////////////////////////////////////////////////////
//			// bashe
//			String processN = "zzz";
//			String proName;
//			Object procObj = null;
//			int inportNo = 0, outPortNo = 0;
//
//			String inputPort1 = null, outPort1 = null;
//			String inputPort2 = null, outPort2 = null;
//			int OutToken1 = -100, InToken1 = -100;
//			int OutToken2 = -100, InToken2 = -100;
//			Object inchanel = null;
//			Object outchanel = null;
//			AbstractProcess ap = null;
//			boolean yek = false, dovom = false;
////			String output = " ";
//			String temp1 = " ";
//			String temp2 = " ";
//			String temp3 = " ";
//			
//			
//Map res = (Map)args[0];
//Set<String> WDFkeySet = res.keySet();
////AbstractProcess ap = (AbstractProcess) cp.get("process");
//
//for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
//String WGFkey = (String) iterator.next();
//			
//if (WGFkey.startsWith("Output")) {
//	if (WGFkey.endsWith("2")) {
//		OutToken2 = (int) res.get(WGFkey);
//		outPort2 = WGFkey;
//	} else {
//		OutToken1 = (int) res.get(WGFkey);
//		outPort1 = WGFkey;
//	}
//}
//if (WGFkey.startsWith("Input")) {
//
//	if (WGFkey.endsWith("2")) {
//		InToken2 = (int) res.get(WGFkey);
//		inputPort2 = WGFkey;
//	} else {
//		InToken1 = (int) res.get(WGFkey);
//		inputPort1 = WGFkey;
//	}
//}
//
//if (WGFkey.startsWith("Process")) {
//	procObj = res.get(WGFkey);
//	processN = (String) res.get(WGFkey);
//	proName = WGFkey;
//}
////
////SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
////		"yyyy/dd/MM hh:mm:ss.SSS");
////output = "***" + simpleDateFormat.format(new Date());
////boolean yek = false, dovom = false;
//
//if ((!(InToken1 == -100) && !(OutToken1 == -100) && !(processN
//		.startsWith("zzz")))) {
//
//	yek = true;
//	temp1 = " " + outPort1 + ": " + OutToken1
//			+ "  ; wasDeriviedFrom ; " + inputPort1 + ": "
//			+ InToken1;
//
//	if ((!(InToken2 == -100) && !(OutToken2 == -100))) {
//		temp1 = temp1 + "and also " + inputPort2 + ": "
//				+ InToken2;
//
//		temp2 = " " + outPort2 + ": " + OutToken2
//				+ "  ; wasDeriviedFrom ; " + inputPort1 + ": "
//				+ InToken1 + " and also " + inputPort2 + ": "
//				+ InToken2;
//		dovom = true;
//	} else if ((!(InToken2 == -100) || !(OutToken2 == -100))) {
//
//		if ((!(InToken2 == -100))) {
//			temp1 = temp1 + " and also " + inputPort2 + ": "
//					+ InToken2;
//		}
//		if (!(OutToken2 == -100)) {
//			temp2 = " || " + outPort2 + ": " + OutToken2
//					+ "  ; wasDeriviedFrom ; " + inputPort1
//					+ ": " + InToken1;
//			dovom = true;
//		}
//	}
//	if (yek = true) {
//		output = output + temp1;
//		if (dovom = true) {
//			output = output + temp2;
//		}
//
//		output = output + " In process:" + processN	;//+ "  app:  " + ap;
//		System.out.println(output);
//	}
//}
////
//}
//			////////////////////////////////////////////////////////////////////////////
//			
//			System.out.println(output);
//		  }	
//		  Object ret = proceed();
//		return ret;
//		}
//		


//		///////////////////////////////////////////////////////
//		
//		/*
//		 * OPM wasTriggerBy relationship
//		 * 
//		 */
//		
////	pointcut wasTriggerBy():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
////		&& target(au.edu.adelaide.kahn.pn.AbstractProcess);
//		pointcut wasTriggerBy():execution (* au.edu.adelaide.kahn.pn.Process.isFireable(..))
//		&& target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//		Object around(): wasTriggerBy() {
//			if((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)){	
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//		
//			AbstractProcess ab = (AbstractProcess) callee;
//			
////			if(! (callee.equals(null)) ){
//			if(! (ab.getPreviousProcess() == null) ){
//			SimpleDateFormat simpleDateFormat =
//				new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***"+simpleDateFormat.format(new Date());
//			output = output + " relation == wasTriggerBy ; "; 
//			output = output + " Process: "+ callee + " - wasTriggerBy - process: "+ ab.getPreviousProcess(); 		
//			System.out.println(output);	
//			}
//			Object ret = proceed();
//			return ret;
//			}else {
//				Object ret = proceed();
//				return ret;
//			}
//			} 

/*
// * OPM wasControlledBy  relationship
// * 
// */
//	
//pointcut wasControlledBy():
//	execution (au.edu.adelaide.pagis.system.ProcessThreadImpl.new(..)) ;
//
//Object around(): wasControlledBy(){
//	Object[] args = thisJoinPoint.getArgs();
//	Object callee = thisJoinPoint.getTarget();
//	ProcessThreadImpl pti = (ProcessThreadImpl) callee;
//	Object ret = proceed();
//	SimpleDateFormat simpleDateFormat =
//			new SimpleDateFormat("yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***"+simpleDateFormat.format(new Date());
//		output = output + " relation == wasControlledBy ; "; 
//		output = output + " Process: "+ pti.getProcess() + " - wasControlledBy - Agent: " +  callee +"   - Strategy: " + pti.getStrategy(); 		
//		System.out.println(output);	
//	return ret;
//}
//}
