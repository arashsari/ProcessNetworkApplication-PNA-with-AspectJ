//package au.edu.adelaide.aspectj;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.Map;
//import java.util.Map.Entry;
//import java.util.Set;
//import java.util.Vector;
//
//import javax.xml.bind.JAXBException;
//import javax.xml.parsers.DocumentBuilder;
//import javax.xml.parsers.DocumentBuilderFactory;
//import javax.xml.parsers.ParserConfigurationException;
//
//import org.openprovenance.model.Account;
//import org.openprovenance.model.Agent;
//import org.openprovenance.model.Annotation;
//import org.openprovenance.model.Artifact;
//import org.openprovenance.model.EmbeddedAnnotation;
//import org.openprovenance.model.HasAccounts;
//import org.openprovenance.model.OPMFactory;
//import org.openprovenance.model.OPMGraph;
//import org.openprovenance.model.OPMSerialiser;
//import org.openprovenance.model.Overlaps;
//import org.openprovenance.model.Process;
//import org.openprovenance.model.Profile;
//import org.openprovenance.model.Used;
//import org.openprovenance.model.Value;
//import org.openprovenance.model.WasControlledBy;
//import org.openprovenance.model.WasDerivedFrom;
//import org.openprovenance.model.WasGeneratedBy;
//import org.openprovenance.model.WasTriggeredBy;
////import org.openprovenance.model;
//import org.w3c.dom.Document;
//import org.w3c.dom.Element;
//import org.w3c.dom.Text;
//
//import au.edu.adelaide.pna.data.IntToken;
//import au.edu.adelaide.pna.data.Token;
//import au.edu.adelaide.pna.system.InformationServiceQuantizer;
//import au.edu.adelaide.kahn.pn.AbstractProcess;
//import au.edu.adelaide.pna.system.ProcessThreadImpl;
//
//import com.sun.org.apache.xml.internal.serialize.OutputFormat;
//import com.sun.org.apache.xml.internal.serialize.XMLSerializer;
//import com.sun.xml.bind.v2.schemagen.xmlschema.List;
//
///**
// * The implementation of needed aspect and pointcuts referred in
// * "AbstractProvenanceModel". The result would be presented in a console and in
// * a form of a log.
// * 
// * @author mehdi sarikhani
// * 
// */
//public aspect OPMProvenanceModelXML {//extends AbstractProvenanceModel {
//	Document document;
//	Element provenanceElement;
//	Element speficationElement;
//	Element excecutionElement;
//	Element reg_actorElement;
//
//	HashMap processesMap = new HashMap();
//	HashMap artifactMap = new HashMap();
//	HashMap agentMap = new HashMap();
//
//	int processCounter = 0;
//	int artifactCounter = 0;
//	int usedCounter = 0;
//	int wasDerivedFromCounter = 0;
//	int wasgeneratedByCounter = 0;
//	int wasTriggeredByCounter = 0;
//	int wasControlledByCounter = 0;
//	int agentCounter= 0;
//	
//	int artifactAnnotateId = 0;
//	int wgbAnnotateId = 0;
//	int usedAnnoateId = 0;
//	int wdfAnnotateId = 0;
//	
//	
//	
//	// added for opm
//	OPMFactory oFactory;
//	Account account;
//	Collection<Account> accountCollection;
//	
//	Account account2;
//	Collection<Account> accountCollection2;
//	
//	Account account3;
//	Collection<Account> accountCollection3;
//
//	Vector<Process> processes = new Vector<Process>();
//	Vector<Agent> agents = new Vector<Agent>();
//	Vector<Artifact> artifactes = new Vector<Artifact>();
//	Vector<Object> objects = new Vector<Object>();
//	EmbeddedAnnotation ann = new EmbeddedAnnotation();
//	
//	
//
//	OPMProvenanceModelXML() {
//		try {
////			System.out.println("in aspect constructor");
//			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory
//					.newInstance();
//			DocumentBuilder documentBuilder;
//
//			documentBuilder = documentBuilderFactory.newDocumentBuilder();
//			document = documentBuilder.newDocument();
//			provenanceElement = document.createElement("provenance");
//			document.appendChild(provenanceElement);
//
//			speficationElement = document.createElement("specification");
//			provenanceElement.appendChild(speficationElement);
//
//			excecutionElement = document.createElement("excecution");
//			provenanceElement.appendChild(excecutionElement);
//
//////////////////////////////////////////
//			/**
//			 * this code for opm
//			 */
//
//			oFactory = new OPMFactory();
//
//			account = new Account();
//			account.setId("account1");
//			accountCollection = new ArrayList<Account>();
//			accountCollection.add(account);
//
//			account2 = new Account();
//			account2.setId("account2");
//			accountCollection2 = new ArrayList<Account>();
//			accountCollection2.add(account2);
//			
//			account3 = new Account();
//			account3.setId("account3");
//			accountCollection3 = new ArrayList<Account>();
//			accountCollection3.add(account3);
//			
//			
//			// createOPMGraph();
//			// Create at the end of execution, in ExecutionStop aspect
//
//		} catch (ParserConfigurationException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//	}
//
//	InformationServiceQuantizer isq = InformationServiceQuantizer.getInstance();
//
//	// /////////////////////////////////////////////////////////////////
//	// Specification
//
//	/** Called before registering workflow contents. */
//	pointcut specificationStart():  execution (*
//			au.edu.adelaide.extendPagis.test.PNTestWithToken.main(..));
//
//	before(): specificationStart() {
//		if (!(isq.granularityLevel == 9)) {
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***    ////////////    "
//					+ simpleDateFormat.format(new Date());
//			output = output + "   specificationStart started    /////////"
//					+ " ";
//			// System.out.println( output);
//
//			/**
//			 * this code added for xml
//			 * 
//			 */
//			Element specStartElement = document
//					.createElement("spect_start_time");
//			Text OTLNOText = document.createTextNode("");
//			specStartElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(simpleDateFormat.format(new Date()));
//			speficationElement.appendChild(specStartElement);
//
//		}
//	}
//
//	/** Called when finished registering workflow contents. */
//	pointcut specificationStop():execution (* au.edu.adelaide.pna.system.PNABuilder.trigger());
//
//	before(): specificationStop() {
//		if (!(isq.granularityLevel == 9)) {
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***     ///////////////// "
//					+ simpleDateFormat.format(new Date());
//			output = output + "   specification stopped   ////// " + "";
//			// System.out.println( output);
//
//			/**
//			 * this code added for XML
//			 */
//
//			Element specEndElement = document.createElement("spect_end_time");
//			Text OTLNOText = document.createTextNode("");
//			specEndElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(simpleDateFormat.format(new Date()));
//			speficationElement.appendChild(specEndElement);
//
//			/**/
//			OutputFormat format = new OutputFormat(document);
//			XMLSerializer serial;
//			try {
//				serial = new XMLSerializer(new FileOutputStream(new File(
//						"specification.xml")), format);
//				serial.serialize(document);
//			} catch (IOException e) {
//
//				e.printStackTrace();
//			}
//
//		}
//	}
//
//	// /** Register an actor. */
//	pointcut regActor(): 
//		execution (* au.edu.adelaide.kahn.pn.Factory.newProcess(..)) && target(au.edu.adelaide.pna.system.factry.PNAKahnFactory) ;
//
//	Object around(): regActor() {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			Object ret = proceed();
//			output = output + " regActor Aspect register the process name : "
//					+ ret + " process id :" + ret.hashCode();
//			output = output + "    -> This process is created by :" + callee
//					+ " and it has " + args.length + " argument/s ";
//
//			// System.out.println("in regActor()");
//			/**
//			 * this code add for test opm
//			 */
//			// TODO --- add new process to template database
//
//			Process findedProcess = findProcessOPMXML(ret);
//			// System.out.println("1- regActor - findedProcess" + findedProcess
//			// + " ret "+ret);
//			// if (findedProcess == null) {
//			// //// findedProcess = (Process) this.processesMap.get(ret);
//			// // this.processCounter++;
//			// // String processId = "p" + this.processCounter;
//			// // findedProcess = oFactory.newProcess(processId,
//			// // accountCollection, String.valueOf(ret));
//			// // this.processes.add(findedProcess); // add process at the end
//			// of
//			// // // processes array
//			// // processesMap.put(ret, findedProcess);
//			// System.out.println("regActor - findedProcess" + findedProcess +
//			// " ret "+ret);
//			//
//			// }
//
//			/**
//			 * this code added for xml
//			 */
//
//			reg_actorElement = document.createElement("reg_actorElement");
//			// speficationElement.appendChild(reg_actorElement);
//
//			Element processIdElement = document.createElement("processId");
//			Text OTLNOText = document.createTextNode("");
//			processIdElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(ret.hashCode()));
//			reg_actorElement.appendChild(processIdElement);
//
//			Element parameterElement;
//
//			for (int i = 0; i < args.length; i++) {
//				output = output + "Argument: " + i + " : " + args[i] + " ";
//
//				/**
//				 * this code idadded for xml
//				 */
//				parameterElement = document.createElement("parameter");
//				Text OTLNOText2 = document.createTextNode("");
//				parameterElement.appendChild(OTLNOText2);
//				OTLNOText2.setNodeValue(String.valueOf(args[i]));
//				reg_actorElement.appendChild(parameterElement);
//
//			}
//			// System.out.println( output);
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//
//	}
//
//	/** Register a Inputport or portparameter. */
//	pointcut regInputPort(): execution (*
//			au.edu.adelaide.kahn.pn.Factory.newInputPort(..)) && target(au.edu.adelaide.pna.system.factry.PNAKahnFactory) ;
//
//	Object around(): regInputPort() {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object ret = proceed();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " regPort Aspect register the Inport No.: "
//					+ args[1] + "  of the Process " + args[0]
//					+ " and it is connected to the channel name : " + ret;
//			// System.out.println( output);
//
//			Element reg_actor_inputportElement = document
//					.createElement("reg_actor_inputport");
//			speficationElement.appendChild(reg_actor_inputportElement);
//
//			Element channelElement = document.createElement("channel");
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(ret));
//			reg_actor_inputportElement.appendChild(channelElement);
//
//			Element portElement = document.createElement("portnumber");
//			Text OTLNOText2 = document.createTextNode("");
//			portElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(args[1]));
//			reg_actor_inputportElement.appendChild(portElement);
//
//			Element processElement = document.createElement("process");
//			Text OTLNOText3 = document.createTextNode("");
//			processElement.appendChild(OTLNOText3);
//			OTLNOText3.setNodeValue(String.valueOf(args[0]));
//			reg_actor_inputportElement.appendChild(processElement);
//
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	/** Register a Outputport or portparameter. */
//	pointcut regOutputPort(): execution (*
//			au.edu.adelaide.kahn.pn.Factory.newOutputPort(..)) && target(au.edu.adelaide.pna.system.factry.PNAKahnFactory) ;
//
//	Object around(): regOutputPort() {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object ret = proceed();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " regPort Aspect register the Outputport No.: "
//					+ args[1] + "  of the Process " + args[0]
//					+ " and it is connected to the channel name : " + ret;
//			// System.out.println( output);
//
//			Element reg_actor_outputportElement = document
//					.createElement("reg_actor_outputport");
//			speficationElement.appendChild(reg_actor_outputportElement);
//
//			Element channelElement = document.createElement("channel");
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(ret));
//			reg_actor_outputportElement.appendChild(channelElement);
//
//			Element portElement = document.createElement("portnumber");
//			Text OTLNOText2 = document.createTextNode("");
//			portElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(args[1]));
//			reg_actor_outputportElement.appendChild(portElement);
//
//			Element processElement = document.createElement("process");
//			Text OTLNOText3 = document.createTextNode("");
//			processElement.appendChild(OTLNOText3);
//			OTLNOText3.setNodeValue(String.valueOf(args[0]));
//			reg_actor_outputportElement.appendChild(processElement);
//
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	// Register a parameter. A parameter can be anything
//
//	pointcut regParameter(Map m): execution (*
//			au.edu.adelaide.kahn.pn.AbstractProcess.updateProperties(..)) && args(m)&&target(au.edu.adelaide.kahn.pn.AbstractProcess);// &&
//	// withincode(au.edu.adelaide.extendPagis.test.Test1.main(..));
//
//	Object around(Map m): regParameter(m) {
//		if (!(isq.granularityLevel == 9)) {
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object ret = proceed(m);
//			// name value
//
//			output = output + " regParameter Aspect register the Parameter : "
//					+ m + " in the Process name  " + callee;
//			// System.out.println( output);
//
//			Element reg_actor_parametersElement = document
//					.createElement("reg_actor_parameters");
//			speficationElement.appendChild(reg_actor_parametersElement);
//
//			Element processElement = document.createElement("process");
//			Text OTLNOText = document.createTextNode("");
//			processElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(callee));
//			reg_actor_parametersElement.appendChild(processElement);
//
//			Iterator entries = m.entrySet().iterator();
//			while (entries.hasNext()) {
//				Entry thisEntry = (Entry) entries.next();
//				Object key = thisEntry.getKey();
//				Object value = thisEntry.getValue();
//				// System.out.println("************* key= " +key+"  value = "+
//				// value);
//
//				Element parameterElement = document.createElement("parameter");
//				reg_actor_parametersElement.appendChild(parameterElement);
//
//				Element parameterName = document.createElement("name");
//				Text OTLNOText3 = document.createTextNode("");
//				parameterName.appendChild(OTLNOText3);
//				OTLNOText3.setNodeValue(String.valueOf(key));
//				parameterElement.appendChild(parameterName);
//
//				Element parameterValue = document.createElement("value");
//				Text OTLNOText4 = document.createTextNode("");
//				parameterValue.appendChild(OTLNOText4);
//				OTLNOText4.setNodeValue(String.valueOf(value));
//				parameterElement.appendChild(parameterValue);
//
//			}
//
//			return ret;
//		} else {
//			Object ret = proceed(m);
//			return ret;
//		}
//	}
//
//	/**
//	 * Register a link between two port It is also called channel.
//	 */
//	pointcut regLink(): execution (*
//			 au.edu.adelaide.pna.system.PNABuilder.connect(..)) 
//			 && target(au.edu.adelaide.pna.system.PNABuilder) ;
//
//	Object around(): regLink() {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object ret = proceed();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " regLink Aspect register the channel name : "
//					+ ret + " between outputport name " + args[0]
//					+ " and inputport name" + args[1];
//			// System.out.println( output);
//
//			Element reg_linkElement = document.createElement("reg_link");
//			speficationElement.appendChild(reg_linkElement);
//
//			Element linkInputportElement = document.createElement("inputport");
//			Text OTLNOText = document.createTextNode("");
//			linkInputportElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(args[1]));
//			reg_linkElement.appendChild(linkInputportElement);
//
//			Element linkOutputportElement = document
//					.createElement("outputport");
//			Text OTLNOText2 = document.createTextNode("");
//			linkOutputportElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(args[0]));
//			reg_linkElement.appendChild(linkOutputportElement);
//
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	/**
//	 * Register a relation.
//	 * 
//	 * It is captured in runtime ot just capture" WastriggeredBy" relationShip.
//	 */
//	pointcut regRelation(): execution (*
//			 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
//
//	// /////////////////////////////////////////////////////////////////
//	// Execution of workflow
//
//	/** Record the starting of workflow execution. */
//	pointcut executionStart(): execution (* au.edu.adelaide.pna.system.PNABuilder.trigger());
//
//	before(): executionStart() {
//		if (!(isq.granularityLevel == 9)) {
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***  ////////////"
//					+ simpleDateFormat.format(new Date());
//			// System.out.println(output +
//			// "   execution Started   ////////////");
//
//			Element exe_start_timeElement = document
//					.createElement("exe_start_time");
//			excecutionElement.appendChild(exe_start_timeElement);
//			Text OTLNOText = document.createTextNode("");
//			excecutionElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(simpleDateFormat.format(new Date()));
//		}
//	}
//
//	/** Record the stopping of workflow execution. */
//	pointcut executionStop(): execution (*
//			au.edu.adelaide.pna.test.PNAAOPTest.exceutionStop());
//
//	after(): executionStop() {
//		System.out.println("+++++++++++++++++++++ in execution Stop method");
//
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//				"yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***  ////////////"
//				+ simpleDateFormat.format(new Date());
//		Element exe_stop_timeElement = document.createElement("exe_stop_time");
//		excecutionElement.appendChild(exe_stop_timeElement);
//		Text OTLNOText = document.createTextNode("");
//		excecutionElement.appendChild(OTLNOText);
//		OTLNOText.setNodeValue(simpleDateFormat.format(new Date()));
//
//		OutputFormat format = new OutputFormat(document);
//		XMLSerializer serial;
//		try {
//			serial = new XMLSerializer(new FileOutputStream(new File(
//					"provenance.xml")), format);
//			serial.serialize(document);
//			
//		} catch (IOException e) {
//
//			e.printStackTrace();
//		}
//		try {
//			Thread.sleep(1000);
//		} catch (InterruptedException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		// Create OPM Graph
//
//		createOPMGraph();
//
//	}
//
//	public void createOPMGraph() {
//		OPMGraph graph = oFactory.newOPMGraph(accountCollection,
//				new Overlaps[] {},
//				this.processes.toArray(new Process[this.processes.size()]),
//				this.artifactes.toArray(new Artifact[this.artifactes.size()]),
//				this.agents.toArray(new Agent[this.agents.size()]),
//				this.objects.toArray(), 
//				new Annotation[] {});
//
//		 ann = oFactory.newEmbeddedAnnotation("an15",
//				"http://property.org/hasQuality", "average", accountCollection);
//		
//
//
//		// OPMGraph graph=new MyGraph().getGraph(oFactory);
//		OPMSerialiser serial2 = OPMSerialiser.getThreadOPMSerialiser();
//		try {
//			serial2.serialiseOPMGraph(new File("OPM-PNA-AspectJ.xml"), graph, true);
//			System.out.println("xml is created");
//		} catch (JAXBException e) {
//			System.out.println("**** error in xml writing opm serialiser ");
//			e.printStackTrace();
//		}
//	}
//
//	/**
//	 * Record an actor firing. it is not collected for medium and coarse-grained
//	 * level of provenance.
//	 * */
//	pointcut actorFire():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	Object around(): actorFire() {
//
//		if (!(isq.getGranularityLevel() == 0) && (!(isq.granularityLevel == 9))) {
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " Method fire() of Process name " + callee + " ";
//			// System.out.println(output);
//
//		}
//		Object ret = proceed();
//		return ret;
//	}
//
//	/**
//	 * Record an actor firing. it is not collected for fine-grained level of
//	 * provenance.
//	 * */
//	pointcut actorFireWithInfo():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	Object around(): actorFire() {
//
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//			String filedName = thisJoinPoint.getSignature().getName();
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " Method fire() of Process name " + callee + " ";
//
//			output = output + " with arguments " + args[0]; // this is a map
//															// (input , out)
//			// System.out.println(output);
//
//			/**
//			 * this code for XML
//			 */
//			Element actor_fireElement = document.createElement("actor_fire");
//			this.excecutionElement.appendChild(actor_fireElement);
//
//			Element processElement = document.createElement("process");
//			Text OTLNOText = document.createTextNode("");
//			processElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(callee));
//			actor_fireElement.appendChild(processElement);
//
//			Iterator entries = ((Map) args[0]).entrySet().iterator();
//			while (entries.hasNext()) {
//				Entry thisEntry = (Entry) entries.next();
//				Object key = thisEntry.getKey();
//				Object value = thisEntry.getValue();
//				// System.out.println("************* key= " +key+"  value = "+
//				// value);
//
//				Element parameterElement = document.createElement("argument");
//				actor_fireElement.appendChild(parameterElement);
//
//				Element parameterName = document.createElement("name");
//				Text OTLNOText3 = document.createTextNode("");
//				parameterName.appendChild(OTLNOText3);
//				OTLNOText3.setNodeValue(String.valueOf(key));
//				parameterElement.appendChild(parameterName);
//
//				Element parameterValue = document.createElement("value");
//				Text OTLNOText4 = document.createTextNode("");
//				parameterValue.appendChild(OTLNOText4);
//				OTLNOText4.setNodeValue(String.valueOf(value));
//				parameterElement.appendChild(parameterValue);
//
//			}
//
//		}
//		Object ret = proceed();
//		return ret;
//	}
//   /// ------------------------------------------------------------
//	pointcut actorPreFire():execution (* au.edu.adelaide.kahn.pn.Process.preFire(..))
//    && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//	Object around(): actorPreFire() {
//
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//			String filedName = thisJoinPoint.getSignature().getName();
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " Method preFire() of Process name " + callee + " ";
//
////			output = output + " with arguments " + args[0]; // this is a map
//															// (input , out)
//			// System.out.println(output);
//
//			/**
//			 * this code for XML
//			 */
//			Element actor_fireElement = document.createElement("actor_preFire");
//			this.excecutionElement.appendChild(actor_fireElement);
//
//			Element processElement = document.createElement("process");
//			Text OTLNOText = document.createTextNode("");
//			processElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(callee));
//			actor_fireElement.appendChild(processElement);
//
////			Iterator entries = ((Map) args[0]).entrySet().iterator();
////			while (entries.hasNext()) {
////				Entry thisEntry = (Entry) entries.next();
////				Object key = thisEntry.getKey();
////				Object value = thisEntry.getValue();
////				// System.out.println("************* key= " +key+"  value = "+
////				// value);
////
////				Element parameterElement = document.createElement("argument");
////				actor_fireElement.appendChild(parameterElement);
////
////				Element parameterName = document.createElement("name");
////				Text OTLNOText3 = document.createTextNode("");
////				parameterName.appendChild(OTLNOText3);
////				OTLNOText3.setNodeValue(String.valueOf(key));
////				parameterElement.appendChild(parameterName);
////
////				Element parameterValue = document.createElement("value");
////				Text OTLNOText4 = document.createTextNode("");
////				parameterValue.appendChild(OTLNOText4);
////				OTLNOText4.setNodeValue(String.valueOf(value));
////				parameterElement.appendChild(parameterValue);
////
////			}
//
//		}
//		Object ret = proceed();
//		return ret;
//	}
//	
//	///----------------------------------------------------------
//	/** Record a Outpuport event. */
//	pointcut OutputPortEvent(Object token): execution (* au.edu.adelaide.kahn.pn.OutputPort.put(Object)) && args(token) && target(au.edu.adelaide.pna.halfchannel.HalfChannelOutputPortImpl);
//
//	Object around(Object token): OutputPortEvent(token) {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			Object ret = proceed(token);
//			output = output + " OutputPort intercation with Channel : "
//					+ callee + " Token value =   " + token + " tokey.class: "
//					+ ((Token) token).getClass().getName();
//			// System.out.println(output);
//
//			/**
//			 * this code added for XML
//			 */
//
//			Element outputPortEventElement = document
//					.createElement("output_port_event");
//			excecutionElement.appendChild(outputPortEventElement);
//
//			Element channelElement = document.createElement("channel");
//			outputPortEventElement.appendChild(channelElement);
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(callee));
//
//			Element tokenElement = document.createElement("token");
//			outputPortEventElement.appendChild(tokenElement);
//			Text OTLNOText2 = document.createTextNode("");
//			tokenElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(token));
//
//			/**
//			 * this code add for opm xml
//			 * 
//			 */
//
//			Artifact findedArtifact = findArtifactOPMXML((Token)token);
//
//			return ret;
//		} else {
//			Object ret = proceed(token);
//			return ret;
//		}
//	}
//
//	/** Record a InputPort event. */
//	pointcut InputPortEvent(): execution (* au.edu.adelaide.kahn.pn.InputPort.get(..)) && target(au.edu.adelaide.pna.halfchannel.HalfChannelInputPortImpl);
//
//	Object around(): InputPortEvent() 
//       {
//		if (!(isq.granularityLevel == 9)) {
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			Object ret = proceed();
//			output = output + " InputPort intercation with Channel : " + callee
//					+ " Token value =  " + ret + " ";
//			// System.out.println(output);
//
//			/**
//			 * this code added for XML
//			 **/
//
//			Element inputPortEventElement = document
//					.createElement("input_port_event");
//			excecutionElement.appendChild(inputPortEventElement);
//
//			Element channelElement = document.createElement("channel");
//			inputPortEventElement.appendChild(channelElement);
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(callee));
//
//			Element tokenElement = document.createElement("token");
//			inputPortEventElement.appendChild(tokenElement);
//			Text OTLNOText2 = document.createTextNode("");
//			tokenElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(ret));
//
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	// //////////////////////////////////////////////////////////////////////
//	// // relationship methods ////
//
//	/**
//	 * Record WasGeneratedBy relationship.
//	 * 
//	 * It can be useful in OPM model not here.
//	 * */
//
//	// not collect artifact value but shows the dependency
//	pointcut WasGeneratedBy(): execution (*
//		 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
//
//	Object around(): WasGeneratedBy() {
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = "***" + simpleDateFormat.format(new Date());
//			output = output + " relation == WasGeneratedBy ; ";
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object caller = thisJoinPoint.getThis();
//			Object ret = proceed();
//			AbstractProcess ab = (AbstractProcess) callee;
//			Map res = ab.getData();
//			Set<String> WDFkeySet = res.keySet();
//
//			/**
//			 * this code added for XML
//			 **/
//
//			Element wasGeneratedByElement = document
//					.createElement("was_generated_by");
//			excecutionElement.appendChild(wasGeneratedByElement);
//
//			Element channelElement = document.createElement("channel");
//			wasGeneratedByElement.appendChild(channelElement);
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(ret));
//
//			Element processElement = document.createElement("process");
//			wasGeneratedByElement.appendChild(processElement);
//			Text OTLNOText2 = document.createTextNode("");
//			processElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(callee));
//
//			Element artifactsElement = document.createElement("artifacts");
//			wasGeneratedByElement.appendChild(artifactsElement);
//
//			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
//				String WGFkey = (String) iterator.next();
//
//				if (WGFkey.equalsIgnoreCase("OutputValue")) {
//					output = output + "  Channel.id = " + +ret.hashCode()
//							+ "  Channel.name = " + ret;
//					output = output + "  Process.id = " + +callee.hashCode()
//							+ "  Process.name = " + callee;
//					Object outval = res.get(WGFkey);
//					// System.out.println("outputVal1: artifact value: "+(int)
//					// outval + output);
//					// System.out.println("outputVal1: artifact value: "+
//					// ((Token) outval).toString() + output); %
//
//					Element artifactElement = document
//							.createElement("OutputValue");
//					artifactsElement.appendChild(artifactElement);
//					Text OTLNOText4 = document.createTextNode("");
//					artifactElement.appendChild(OTLNOText4);
//					OTLNOText4.setNodeValue(String.valueOf(outval));
//
//					// opm was generated by
//
//					createWGB(callee, outval, ret, 00);
//
//				}
//
//				if (WGFkey.equalsIgnoreCase("OutputValue1")) {
//					output = output + "  Channel.id = " + +ret.hashCode()
//							+ "  Channel.name = " + ret;
//					output = output + "  Process.id = " + +callee.hashCode()
//							+ "  Process.name = " + callee;
//					Object outval1 = res.get(WGFkey);
//					//
//
//					Element artifactElement = document
//							.createElement("OutputValue1");
//					artifactsElement.appendChild(artifactElement);
//					Text OTLNOText4 = document.createTextNode("");
//					artifactElement.appendChild(OTLNOText4);
//					OTLNOText4.setNodeValue(String.valueOf(outval1));
//
//					// opm was generated by
//					createWGB(callee, outval1, ret, 10);
//
//				}
//				if (WGFkey.equalsIgnoreCase("OutputValue2")) {
//					output = output + "  Channel.id = " + +ret.hashCode()
//							+ "  Channel.name = " + ret;
//					output = output + "  Process.id = " + +callee.hashCode()
//							+ "  Process.name = " + callee;
//					Object outval2 = res.get(WGFkey);
//					Element artifactElement = document
//							.createElement("OutputValue2");
//					artifactsElement.appendChild(artifactElement);
//					Text OTLNOText4 = document.createTextNode("");
//					artifactElement.appendChild(OTLNOText4);
//					OTLNOText4.setNodeValue(String.valueOf(outval2));
//
//					// /////////////////////////////////////////////////////////
//					// opm was generated by
//					createWGB(callee, outval2, ret, 01);
//
//				}
//			}
//			// ////////////////
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	private void createWGB(Object callee, Object token,Object channel, int portIndex ) {
//		// find process
//		Process findedProcess = findProcessOPMXML(callee);
//
//		// find artifact
//		Artifact findedArtifact = findArtifactOPMXML((Token)token);
//		this.wasgeneratedByCounter++;
//		String wasgeneratedById = "WGB_"
//				+ this.wasgeneratedByCounter;
//		WasGeneratedBy wg1 = oFactory.newWasGeneratedBy(wasgeneratedById,
//				findedArtifact, oFactory.newRole("out"),
//				findedProcess, this.accountCollection);
//		
//
//
//		// annotation 
//		if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
//			Value portAnnotate= new Value();
//			portAnnotate.setId("port index");
//			portAnnotate.setContent(portIndex);
//			String pindex = null;
//			switch (portIndex){
//			case 00: pindex="0 => the only input port";break;
//			case 10: pindex="1 => there is two input ports";break;
//			case 01: pindex="2 => there is two input ports";break;
//			}
//			portAnnotate.setEncoding(pindex);
//			Value channelAnnotate= new Value();
//			channelAnnotate.setId("channel");
//			channelAnnotate.setContent(channel.getClass().getSimpleName());
//			channelAnnotate.setEncoding(channel.toString());
//			EmbeddedAnnotation embAnno = new EmbeddedAnnotation();
////			embAnno.setId("WGB - Port and Channel");
//			
//			oFactory.addAnnotation(embAnno, channelAnnotate);
//			oFactory.addAnnotation(embAnno, portAnnotate);	
//			
//			this.wgbAnnotateId++;	
//		String wgbAnn = "wgbAnnotation_"+this.wgbAnnotateId;	
//		oFactory.addAnnotation(wg1, oFactory.newEmbeddedAnnotation(wgbAnn, "WGB - Port and Channel", embAnno, accountCollection2));
//		}
//
//		
//		this.objects.add(wg1);
//	}
//
//	//----------------------------------------------------
//	
//	pointcut Used():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//	&& target(au.edu.adelaide.kahn.pn.AbstractProcess);
//	Object around(): Used() {
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//			Object ret = proceed();
//			String output = " ";
//			Object caller = null;
//			Object callee = null;
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			output = "***" + simpleDateFormat.format(new Date());
//			output = output + " relation == Used ;";
////			Object[] args = thisJoinPoint.getArgs();
//			caller = thisJoinPoint.getThis();
//			callee = thisJoinPoint.getTarget();
//			// Object ret = proceed();
//			output = output + "  Channel.id = " 
//					+ "  Channel.name = " + ret;
//		
//			output = output +  " Process.name = " + callee.getClass().getSimpleName();
////			 System.out.println(" USED" +output);
//			AbstractProcess ab = (AbstractProcess) callee;
//			Map res = ab.getData();
//			Set<String> WDFkeySet = res.keySet();
//
//			/**
//			 * this code added for XML
//			 **/
//
//			Element usedRelationElement = document
//					.createElement("used_relation");
//			excecutionElement.appendChild(usedRelationElement);
//
//
//
//			Element processElement = document.createElement("process");
//			usedRelationElement.appendChild(processElement);
//			Text OTLNOText2 = document.createTextNode("");
//			processElement.appendChild(OTLNOText2);
//			OTLNOText2.setNodeValue(String.valueOf(callee));
//
//			Element tokensElement = document.createElement("tokens");
//			usedRelationElement.appendChild(tokensElement);
//
//			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
//				String WGFkey = (String) iterator.next();
//				if (WGFkey.equalsIgnoreCase("InputValue")) {
//
//					Object inval = res.get(WGFkey);
//					Element tElement = document.createElement("InputValue");
//					tokensElement.appendChild(tElement);
//
//					Text OTLNOText3 = document.createTextNode("");
//					tElement.appendChild(OTLNOText3);
//					OTLNOText3.setNodeValue(((Token) inval).toString());
//
//					/*
//					 * // * this code add for pom xml , used //
//					 */
//					createUSED(callee, inval,ret,00);
//
//
//				}
//
//				if (WGFkey.equalsIgnoreCase("InputValue1")) {
//					Object inval1 = res.get(WGFkey);
//					// System.out.println("InputValue1: artifact value: "+(int)
//					// inval + output);
//					// System.out.println("InputValue1: artifact value: "+
//					// ((Token) inval).toString() + output);
//
//					Element tElement = document.createElement("InputValue1");
//					tokensElement.appendChild(tElement);
//
//					Text OTLNOText3 = document.createTextNode("");
//					tElement.appendChild(OTLNOText3);
//					OTLNOText3.setNodeValue(((Token) inval1).toString());
//
//					/*
//					 * // * this code add for pom xml , used //
//					 */
//
//					createUSED(callee, inval1,ret,10);
//
//				}
//				if (WGFkey.equalsIgnoreCase("InputValue2")) {
//					Object inval2 = res.get(WGFkey);
//					Element tokenElement = document
//							.createElement("InputValue2");
//					tokensElement.appendChild(tokenElement);
//					Text OTLNOText3 = document.createTextNode("");
//					tokenElement.appendChild(OTLNOText3);
//					OTLNOText3.setNodeValue(((Token) inval2).toString());
//
//					// ///////////////////////////////////////////////////////////////////////////////
//					/*
//					 * // * this code add for pom xml , used //
//					 */
//					createUSED(callee, inval2,ret,01);
//
//
//				}
//
//			}
////			Object ret = proceed();
//			Element channelElement = document.createElement("channel");
//			usedRelationElement.appendChild(channelElement);
//			Text OTLNOText = document.createTextNode("");
//			channelElement.appendChild(OTLNOText);
//			OTLNOText.setNodeValue(String.valueOf(ret));
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	private void createUSED(Object callee, Object inval1,Object channel, int portIndex ) {
//		Process findedProcess = findProcessOPMXML(callee);
//
//		// find artifact
//		Artifact findedArtifact = findArtifactOPMXML((Token)inval1);
//		this.usedCounter++;
//		String usedId = "U_" + this.usedCounter;
//		Used u1 = oFactory.newUsed(usedId,findedProcess,
//				oFactory.newRole("in1"), findedArtifact,
//				accountCollection);
//
//	
//		
//		// annotation 
//				if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
//					Value portAnnotate= new Value();
//					portAnnotate.setId("port index");
////					portAnnotate.setContent(portIndex);
//					String pindex = null;
//					switch (portIndex){
//					case 00: pindex="0 => the only input port";break;
//					case 10: pindex="1 => there is two input ports";break;
//					case 01: pindex="2 => there is two input ports";break;
//					}
//					portAnnotate.setEncoding(pindex);
//					Value channelAnnotate= new Value();
//					channelAnnotate.setId("channel");
//					EmbeddedAnnotation embAnno = new EmbeddedAnnotation();
////					embAnno.setId("USED - Port and Channel");
//					
//					oFactory.addAnnotation(embAnno, channelAnnotate);
//					oFactory.addAnnotation(embAnno, portAnnotate);	
//					this.usedAnnoateId++;	
//				String usedAnn = "usedAnnotation_"+this.usedAnnoateId;	
//				oFactory.addAnnotation(u1, oFactory.newEmbeddedAnnotation(usedAnn, "USED - Port and Channel", embAnno, accountCollection2));
//				}
//				
//				this.objects.add(u1);
//	}
//	
//	
//	
//	//-----------------------------------------------------------------------------
//
//	
//	//--------------------------------------------------------------------------------
////	
////	/** Record Used relationship. */
////	// ///////////////////////
////	// it can't capture the artifact while it shows the dependency.
////	// // // Track all the input value and process operator in all Processes.
////	pointcut Used(int index):execution (* au.edu.adelaide.kahn.pn.AbstractProcess.getInputPort(int)) && args(index);
////	Object around(int index): Used(index) {
////		if (!(isq.granularityLevel == 9)) {
////			Object ret = proceed(index);
////			String output = " ";
////			Object caller = null;
////			Object callee = null;
////			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
////					"yyyy/dd/MM hh:mm:ss.SSS");
////			output = "***" + simpleDateFormat.format(new Date());
////			output = output + " relation == Used ;";
////			Object[] args = thisJoinPoint.getArgs();
////			caller = thisJoinPoint.getThis();
////			callee = thisJoinPoint.getTarget();
//////			 Object ret = proceed(index);
//////			output = output + "  Channel.id = " + +ret.hashCode()
//////					+ "  Channel.name = " + ret;
////			// output = output + " arithmaticProcess = "+callee.hashCode();
////			output = output + " Process.id = " + +callee.hashCode()
////					+ " Process.name = " + callee.getClass().getSimpleName();
////			// System.out.println(" USED" +output);
////			AbstractProcess ab = (AbstractProcess) callee;
////			Map res = ab.getData();
////			Set<String> WDFkeySet = res.keySet();
////
////			/**
////			 * this code added for XML
////			 **/
////
////			Element usedRelationElement = document
////					.createElement("used_relation");
////			excecutionElement.appendChild(usedRelationElement);
////
////			Element channelElement = document.createElement("channel");
////			usedRelationElement.appendChild(channelElement);
////			Text OTLNOText = document.createTextNode("");
////			channelElement.appendChild(OTLNOText);
//////			OTLNOText.setNodeValue(String.valueOf(ret));
////
////			Element processElement = document.createElement("process");
////			usedRelationElement.appendChild(processElement);
////			Text OTLNOText2 = document.createTextNode("");
////			processElement.appendChild(OTLNOText2);
////			OTLNOText2.setNodeValue(String.valueOf(callee));
////
////			Element tokensElement = document.createElement("tokens");
////			usedRelationElement.appendChild(tokensElement);
////
////			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
////				String WGFkey = (String) iterator.next();
////
////				if (index == 0){
////				if (WGFkey.equalsIgnoreCase("InputValue")) {
////
////					Object inval = res.get(WGFkey);
////					Element tElement = document.createElement("InputValue");
////					tokensElement.appendChild(tElement);
////
////					Text OTLNOText3 = document.createTextNode("");
////					tElement.appendChild(OTLNOText3);
////					OTLNOText3.setNodeValue(((Token) inval).toString());
////
////					createUSED(callee, inval,ret,00);
////
////				}else if (WGFkey.equalsIgnoreCase("InputValue1")) {
//////				if (WGFkey.equalsIgnoreCase("InputValue1") && (index == 0)) {
////					Object inval1 = res.get(WGFkey);
////					// System.out.println("InputValue1: artifact value: "+(int)
////					// inval + output);
////					// System.out.println("InputValue1: artifact value: "+
////					// ((Token) inval).toString() + output);
////
////					Element tElement = document.createElement("InputValue1");
////					tokensElement.appendChild(tElement);
////
////					Text OTLNOText3 = document.createTextNode("");
////					tElement.appendChild(OTLNOText3);
////					OTLNOText3.setNodeValue(((Token) inval1).toString());
////
////					/*
////					 * // * this code add for pom xml , used //
////					 */
////
////					createUSED(callee, inval1,ret,10);
////
////				}
////				}else if (index == 1){
////				// if (WGFkey.contains("InputValue2")) {
////				 if (WGFkey.equalsIgnoreCase("InputValue2")  ) {
////					Object inval2 = res.get(WGFkey);
////					Element tokenElement = document
////							.createElement("InputValue2");
////					tokensElement.appendChild(tokenElement);
////					Text OTLNOText3 = document.createTextNode("");
////					tokenElement.appendChild(OTLNOText3);
////					OTLNOText3.setNodeValue(((Token) inval2).toString());
////
////					// ///////////////////////////////////////////////////////////////////////////////
////					/*
////					 * // * this code add for pom xml , used //
////					 */
////					// find process
////					
////					createUSED(callee, inval2,ret,01);
////				 }
////				}
////
////			}
//////			Object ret = proceed(index);
////			return ret;
////		} else {
////			Object ret = proceed(index);
////			return ret;
////		}
////	}
//
//	//-----------------------------------------------------------------------------
//
//	
//	//--------------------------------------------------------------------------------
//	
//	
//	/*
//	 * OPM wasDeriviedFrom relationship
//	 * 
//	 * Note, It prints out a number of same relationship
//	 */
//
//	
////	pointcut wasDeriviedFrom(): execution (*
////			 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
////	
////	Object around(): wasDeriviedFrom() {
////
////		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
////			String filedName = thisJoinPoint.getSignature().getName();
////			Object[] args = thisJoinPoint.getArgs();
////			Object caller = thisJoinPoint.getThis();
////			Object callee = thisJoinPoint.getTarget();
////			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
////					"yyyy/dd/MM hh:mm:ss.SSS");
////			String output = " ***" + simpleDateFormat.format(new Date());
////			output = output + " wasDeriviedFrom : in Process name " + callee
////					+ " ";
////			// output = output + " with arguments " + args[0];
////
////			// /////////////////////////////////////////////////////////////////////////////
////			// bashe
////			String processN = "zzz";
////			String proName;
////			Object procObj = null;
////			int inportNo = 0, outPortNo = 0;
////
////			String inputPort1 = null, outPort1 = null, outPort = null, inputPort = null;
////			String inputPort2 = null, outPort2 = null;
////
////			Token inputToken = null, inputToken1 = null, inputToken2 = null;
////			Token outToken = null, outToken1 = null, outToken2 = null;
////
////			// int OutToken1 = -100, InToken1 = -100;
////			// int OutToken2 = -100, InToken2 = -100;
////			Object inchanel = null;
////			Object outchanel = null;
////			AbstractProcess ap = null;
////			boolean yek = false, dovom = false;
////			String temp1 = " ";
////			String temp2 = " ";
////			String temp3 = " ";
////
//////			Map res = (Map) args[0];
////			AbstractProcess ab = (AbstractProcess) callee;
////			Map res = ab.getData();
////
////			Set<String> WDFkeySet = res.keySet();
////			// AbstractProcess ap = (AbstractProcess) cp.get("process");
////
////			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
////				String WGFkey = (String) iterator.next();
////
////				if (WGFkey.startsWith("Output")) {
////					if (WGFkey.equalsIgnoreCase("OutputValue")) {
////						outToken = (Token) res.get(WGFkey);
////						outPort = WGFkey;
////					} else if (WGFkey.equalsIgnoreCase("OutputValue1")) {
////						outToken1 = (Token) res.get(WGFkey);
////						outPort1 = WGFkey;
////					} else if (WGFkey.equalsIgnoreCase("OutputValue2")) {
////						outToken2 = (Token) res.get(WGFkey);
////						outPort2 = WGFkey;
////					}
////				}
////				if (WGFkey.startsWith("Input")) {
////					if (WGFkey.equalsIgnoreCase("InputValue")) {
////						inputToken = (Token) res.get(WGFkey);
////						inputPort = WGFkey;
////					} else if (WGFkey.equalsIgnoreCase("InputValue1")) {
////						inputToken1 = (Token) res.get(WGFkey);
////						inputPort1 = WGFkey;
////					} else if (WGFkey.equalsIgnoreCase("InputValue2")) {
////						inputToken2 = (Token) res.get(WGFkey);
////						inputPort2 = WGFkey;
////					}
////				}
////			}
////				AbstractProcess proces = (AbstractProcess) callee;
////
////				if (!(callee.equals(null))) {
////					Process findedProcess = findProcessOPMXML(callee);
////					if (!(outToken == null) || !(outToken1 == null)
////							|| !(outToken2 == null)) {
////						if (!(inputToken == null) || !(inputToken1 == null)
////								|| !(inputToken2 == null)) {
////							// // outToken
////							if (!(outToken == null)) {
////								if (!(inputToken == null)) {
////
////									createWDF(inputToken, outToken);
////
////								}
////								if (!(inputToken1 == null)) {
////
////									createWDF(inputToken1, outToken);
////								}
////								if (!(inputToken2 == null)) {
////
////									createWDF(inputToken2, outToken);
////								}
////
////							}
////							// outToken1
////							if (!(outToken1 == null)) {
////								if (!(inputToken == null)) {
////
////									createWDF(inputToken, outToken1);
////
////								}
////								if (!(inputToken1 == null)) {
////									createWDF(inputToken1, outToken1);
////								}
////								if (!(inputToken2 == null)) {
////									createWDF(inputToken2, outToken1);
////								}
////
////							}
////							// outToken2
////							if (!(outToken2 == null)) {
////								if (!(inputToken == null)) {
////									createWDF(inputToken, outToken2);
////								}
////								if (!(inputToken1 == null)) {
////									createWDF(inputToken1, outToken2);
////								}
////								if (!(inputToken2 == null)) {
////									createWDF(inputToken2, outToken2);
////								}
////
////							}
////						}
////					}
////				}
////
////			//}//
////		}
////		Object ret = proceed();
////		return ret;
////	}
////	
////	
//	
//	
//	
//	pointcut wasDeriviedFrom():execution (*
//	 au.edu.adelaide.kahn.pn.Process.fire(..))
//	 && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//	Object around(): wasDeriviedFrom() {
//
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//			
//			String filedName = thisJoinPoint.getSignature().getName();
//			Object[] args = thisJoinPoint.getArgs();
//			Object caller = thisJoinPoint.getThis();
//			Object callee = thisJoinPoint.getTarget();
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//					"yyyy/dd/MM hh:mm:ss.SSS");
//			String output = " ***" + simpleDateFormat.format(new Date());
//			output = output + " wasDeriviedFrom : in Process name " + callee
//					+ " ";
//			// output = output + " with arguments " + args[0];
//
//			// /////////////////////////////////////////////////////////////////////////////
//			// bashe
//			String processN = "zzz";
//			String proName;
//			Object procObj = null;
//			int inportNo = 0, outPortNo = 0;
//
//			String inputPort1 = null, outPort1 = null, outPort = null, inputPort = null;
//			String inputPort2 = null, outPort2 = null;
//
//			Token inputToken = null, inputToken1 = null, inputToken2 = null;
//			Token outToken = null, outToken1 = null, outToken2 = null;
//
//			// int OutToken1 = -100, InToken1 = -100;
//			// int OutToken2 = -100, InToken2 = -100;
//			Object inchanel = null;
//			Object outchanel = null;
//			AbstractProcess ap = null;
//			boolean yek = false, dovom = false;
//			String temp1 = " ";
//			String temp2 = " ";
//			String temp3 = " ";
//
//			Map res = (Map) args[0];
//			Set<String> WDFkeySet = res.keySet();
//			// AbstractProcess ap = (AbstractProcess) cp.get("process");
//
//			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
//				String WGFkey = (String) iterator.next();
//
//				if (WGFkey.startsWith("Output")) {
//					if (WGFkey.equalsIgnoreCase("OutputValue")) {
//						outToken = (Token) res.get(WGFkey);
//						outPort = WGFkey;
//					} else if (WGFkey.equalsIgnoreCase("OutputValue1")) {
//						outToken1 = (Token) res.get(WGFkey);
//						outPort1 = WGFkey;
//					} else if (WGFkey.equalsIgnoreCase("OutputValue2")) {
//						outToken2 = (Token) res.get(WGFkey);
//						outPort2 = WGFkey;
//					}
//				}
//				if (WGFkey.startsWith("Input")) {
//					if (WGFkey.equalsIgnoreCase("InputValue")) {
//						inputToken = (Token) res.get(WGFkey);
//						inputPort = WGFkey;
//					} else if (WGFkey.equalsIgnoreCase("InputValue1")) {
//						inputToken1 = (Token) res.get(WGFkey);
//						inputPort1 = WGFkey;
//					} else if (WGFkey.equalsIgnoreCase("InputValue2")) {
//						inputToken2 = (Token) res.get(WGFkey);
//						inputPort2 = WGFkey;
//					}
//				}
//			}
//				AbstractProcess proces = (AbstractProcess) callee;
//
//				if (!(callee.equals(null))) {
//					Process findedProcess = findProcessOPMXML(callee);
//					if (!(outToken == null) || !(outToken1 == null)
//							|| !(outToken2 == null)) {
//						if (!(inputToken == null) || !(inputToken1 == null)
//								|| !(inputToken2 == null)) {
//							// // outToken
//							if (!(outToken == null)) {
//								if (!(inputToken == null)) {
//
//									createWDF(inputToken, outToken, callee);
//
//								}
//								if (!(inputToken1 == null)) {
//
//									createWDF(inputToken1, outToken, callee);
//								}
//								if (!(inputToken2 == null)) {
//
//									createWDF(inputToken2, outToken, callee);
//								}
//
//							}
//							// outToken1
//							if (!(outToken1 == null)) {
//								if (!(inputToken == null)) {
//
//									createWDF(inputToken, outToken1, callee);
//
//								}
//								if (!(inputToken1 == null)) {
//									createWDF(inputToken1, outToken1, callee);
//								}
//								if (!(inputToken2 == null)) {
//									createWDF(inputToken2, outToken1, callee);
//								}
//
//							}
//							// outToken2
//							if (!(outToken2 == null)) {
//								if (!(inputToken == null)) {
//									createWDF(inputToken, outToken2, callee);
//								}
//								if (!(inputToken1 == null)) {
//									createWDF(inputToken1, outToken2, callee);
//								}
//								if (!(inputToken2 == null)) {
//									createWDF(inputToken2, outToken2, callee);
//								}
//
//							}
//						}
//					}
//				}
//
//			//}//
//		
//		Object ret = proceed();
//		return ret;
//	} else {
//		Object ret = proceed();
//		return ret;
//	}
//}
//
//	public void createWDF(Token inputToken, Token outToken, Object process) {
//		// opm xml
//		// find artifact
//		Artifact findedArtifact1 = findArtifactOPMXML(outToken);
//		Artifact findedArtifact2 = findArtifactOPMXML(inputToken);
//
//		this.wasDerivedFromCounter++;
//		String wasDerivedFromid = "WDF_" + this.wasDerivedFromCounter;
//
//		// show just WDFId
//		WasDerivedFrom WDF = this.oFactory.newWasDerivedFrom(wasDerivedFromid,
//				findedArtifact1, findedArtifact2, accountCollection);
//
//		// annotation 
//		if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
//			this.wdfAnnotateId++;	
//		String wdfAnn = "wdfAnnotation_"+this.wdfAnnotateId;	
//		oFactory.addAnnotation(WDF, oFactory.newEmbeddedAnnotation(wdfAnn, "WDB - process", process.toString(), accountCollection2));
//		}
//		
//		this.objects.add(WDF);
//
//		// /////////////////// Provenance.xml//////////////////////////////
//		Element wasGeneratedByElement = document
//				.createElement("wasDeriviedFrom");
//		excecutionElement.appendChild(wasGeneratedByElement);
//		Element channelElement = document.createElement("Artifact-output");
//		wasGeneratedByElement.appendChild(channelElement);
//		Text OTLNOText = document.createTextNode("");
//		channelElement.appendChild(OTLNOText);
//		OTLNOText.setNodeValue(String.valueOf(outToken));//
//		Element processElement = document.createElement("Artifact-input");
//		wasGeneratedByElement.appendChild(processElement);
//		Text OTLNOText2 = document.createTextNode("");
//		processElement.appendChild(OTLNOText2);
//		OTLNOText2.setNodeValue(String.valueOf(inputToken));//
//		// //////////////////////////////////////////////////
//	}
//
//
//	// /////////////////////////////////////////////////////
//
//	/*
//	 * OPM wasTriggerBy relationship
//	 */
//
//	pointcut wasTriggerBy():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
//&& target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	// pointcut wasTriggerBy():execution (*
//	// au.edu.adelaide.kahn.pn.Process.isFireable(..))
//	// && target(au.edu.adelaide.kahn.pn.AbstractProcess);
//
//	Object around(): wasTriggerBy() {
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//
//			// Object ret = proceed();
//
//			Object[] args = thisJoinPoint.getArgs();
//			Object callee = thisJoinPoint.getTarget();
//			Object ret = proceed();
//			AbstractProcess ab = (AbstractProcess) callee;
//			if (!(ab.getPreviousProcess() == null)) {
//				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//						"yyyy/dd/MM hh:mm:ss.SSS");
//				String output = " ***" + simpleDateFormat.format(new Date());
//				output = output + " relation == wasTriggerBy ; ";
//				output = output + " Process: " + callee
//						+ " - wasTriggerBy - process: "
//						+ ab.getPreviousProcess();
//
//				Element wasTriggerByElement = document
//						.createElement("was_Trigger_By_Relation");
//				excecutionElement.appendChild(wasTriggerByElement);
//
//				Element processElement = document
//						.createElement("triggered_process");
//				wasTriggerByElement.appendChild(processElement);
//				Text OTLNOText = document.createTextNode("");
//				processElement.appendChild(OTLNOText);
//				OTLNOText.setNodeValue(String.valueOf(callee));
//				Element processElement1 = document
//						.createElement("trigger_process");
//				wasTriggerByElement.appendChild(processElement1);
//				Text OTLNOText2 = document.createTextNode("");
//				processElement1.appendChild(OTLNOText2);
//				OTLNOText2
//						.setNodeValue(String.valueOf(ab.getPreviousProcess()));
//
//				// //////////////////////////////////////////////////////////
//				// opm xml
//				// find process1
//				Process findedProcess1 = findProcessOPMXML(callee);
//				Process findedProcess2 = (Process) this.processesMap.get(ab
//						.getPrevProcessObj());
//
//				this.wasTriggeredByCounter++;
//				String wasTriggeredById = "WTB_" + this.wasTriggeredByCounter;
//
//				WasTriggeredBy wtb = this.oFactory.newWasTriggeredBy(
//						wasTriggeredById, findedProcess1, findedProcess2,
//						this.accountCollection);
//				
//				
//				
//				this.objects.add(wtb);
//			}
//			// Object ret = proceed();
//			return ret;
//		} else {
//			Object ret = proceed();
//			return ret;
//		}
//	}
//
//	/*
//	 * // * OPM wasControlledBy relationship // *
//	 * 
//	 */
//
//	pointcut wasControlledBy():
//			execution (au.edu.adelaide.pna.system.ProcessThreadImpl.new(..))  ;
//
//	Object around(): wasControlledBy(){
//		if ((isq.getGranularityLevel() == 0) && !(isq.granularityLevel == 9)) {
//		Object[] args = thisJoinPoint.getArgs();
//		Object callee = thisJoinPoint.getTarget();
//		ProcessThreadImpl pti = (ProcessThreadImpl) callee;
//		Object ret = proceed();
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
//				"yyyy/dd/MM hh:mm:ss.SSS");
//		String output = " ***" + simpleDateFormat.format(new Date());
//		output = output + " relation == wasControlledBy ; ";
//		output = output + " Process: " + pti.getProcess()
//				+ " - wasControlledBy - Agent: " + callee + "   - Strategy: "
//				+ pti.getStrategy();
//		
//	
//		Element wasControlledByElement = document
//				.createElement("was_Controlled_By_Relation");
//		excecutionElement.appendChild(wasControlledByElement);
//
//		Element processElement = document.createElement("process");
//		wasControlledByElement.appendChild(processElement);
//		Text OTLNOText = document.createTextNode("");
//		processElement.appendChild(OTLNOText);
//		OTLNOText.setNodeValue(String.valueOf(pti.getProcess()));
//		Element processElement1 = document.createElement("agent");
//		wasControlledByElement.appendChild(processElement1);
//		Text OTLNOText2 = document.createTextNode("");
//		processElement1.appendChild(OTLNOText2);
//		OTLNOText2.setNodeValue(String.valueOf(callee));
//		Element processElement2 = document.createElement("strategy");
//		wasControlledByElement.appendChild(processElement2);
//		Text OTLNOText3 = document.createTextNode("");
//		processElement2.appendChild(OTLNOText3);
//		OTLNOText3.setNodeValue(String.valueOf(pti.getStrategy()));
//
//		// ///////////////////////////////////////////////////
//		Process findedProcess1 = findProcessOPMXML((Object) (pti.getProcess()));
//
//		this.wasControlledByCounter++;
//		String wasControlledById = "WCB_" + this.wasControlledByCounter;
////		Agent agent = oFactory.newAgent(callee.toString(), this.accountCollection);
//////		this.objects.add(agent);
//		Agent agent = findAgentOPMXML(callee);
//		WasControlledBy wcb = this.oFactory.newWasControlledBy(
//				wasControlledById, findedProcess1,
//				oFactory.newRole(String.valueOf(pti.getStrategy())+"- Scheduler"),
//				agent,
//				this.accountCollection);
//		
//		this.objects.add(wcb);
//
//		return ret;
//	} else {
//		Object ret = proceed();
//		return ret;
//	}
//}
//
//	public Process findProcessOPMXML(Object proccc) {
//		Process findedProcess = null;
//		Set<String> prockeySet = this.processesMap.keySet();
//		for (Iterator iter = prockeySet.iterator(); iter.hasNext();) {
//			au.edu.adelaide.kahn.pn.Process app = (au.edu.adelaide.kahn.pn.Process) iter
//					.next();
//			if ((proccc.hashCode()) == (app.hashCode())) {
//				findedProcess = (Process) this.processesMap.get(app);
//			}
//		}
//		if (findedProcess == null) {
//			this.processCounter++;
//			String processId = "P_" + this.processCounter;
//			findedProcess = oFactory.newProcess(processId, accountCollection,
//					String.valueOf(proccc));
//			this.processes.add(findedProcess);
//			processesMap.put(proccc, findedProcess);
//		}
//		return findedProcess;
//	}
//	
//	public Agent findAgentOPMXML(Object agent) {
//		Agent findedAgent = null;
//		Set<String> agkeySet = this.agentMap.keySet();
//		for (Iterator iter = agkeySet.iterator(); iter.hasNext();) {
//			ProcessThreadImpl app = (ProcessThreadImpl) iter
//					.next();
//			if ((agent.hashCode()) == (app.hashCode())) {
//				findedAgent = (Agent) this.processesMap.get(app);
//			}
//		}
//		if (findedAgent == null) {
//			this.agentCounter++;
//			String agentId = "Agent_" + this.agentCounter;
//			findedAgent = oFactory.newAgent(agentId, accountCollection, String.valueOf(agent));
//			this.agents.add(findedAgent);
//			agentMap.put(agent, findedAgent);
//		}
//		return findedAgent;
//	}
//
//
//	public Artifact findArtifactOPMXML(au.edu.adelaide.pna.data.Token token) {
//		Artifact findedArtifact = (Artifact) this.artifactMap.get(token);
//		if (findedArtifact == null) {
//			this.artifactCounter++;
//			String artifactId = "a_" + this.artifactCounter;
//			findedArtifact = oFactory.newArtifact(artifactId,
//					accountCollection, String.valueOf(token.hashCode()));
//			
//			if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
//				this.artifactAnnotateId++;	
//			String artAnn = "artifactAnnotation_"+this.artifactAnnotateId;	
//			oFactory.addAnnotation(findedArtifact, oFactory.newEmbeddedAnnotation(artAnn, "tokenValue", ((IntToken)token).intValue(), accountCollection2));
//			}
//
//			this.artifactes.add(findedArtifact); // add artifact at the end of
//													// artifacts array
//			this.artifactMap.put(token, findedArtifact);
//		}
//		return findedArtifact;
//	}
//}
