package au.edu.adelaide.aspectj;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Vector;

import javax.xml.bind.JAXBException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.openprovenance.model.Account;
import org.openprovenance.model.Agent;
import org.openprovenance.model.Annotation;
import org.openprovenance.model.AnnotationRef;
import org.openprovenance.model.Annotations;
import org.openprovenance.model.Artifact;
import org.openprovenance.model.EmbeddedAnnotation;
import org.openprovenance.model.HasAccounts;
import org.openprovenance.model.OPMFactory;
import org.openprovenance.model.OPMGraph;
import org.openprovenance.model.OPMSerialiser;
import org.openprovenance.model.Overlaps;
import org.openprovenance.model.Process;
import org.openprovenance.model.Profile;
import org.openprovenance.model.Used;
import org.openprovenance.model.Value;
import org.openprovenance.model.WasControlledBy;
import org.openprovenance.model.WasDerivedFrom;
import org.openprovenance.model.WasGeneratedBy;
import org.openprovenance.model.WasTriggeredBy;
import org.openprovenance.profile.collections.ObjectFactory;
//import org.openprovenance.model;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

import au.edu.adelaide.pna.data.IntToken;
import au.edu.adelaide.pna.data.Token;
import au.edu.adelaide.pna.system.InformationServiceQuantizer;
import au.edu.adelaide.kahn.pn.AbstractProcess;
import au.edu.adelaide.pna.system.ProcessThreadImpl;

import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;
import com.sun.xml.bind.v2.schemagen.xmlschema.List;

/**
 * The implementation of needed aspect and pointcuts referred in
 * "AbstractProvenanceModel". The result would be presented in a console and in
 * a form of a log.
 * 
 * @author mehdi sarikhani
 * 
 */
public aspect OPMMultipleGranularityPC {// extends AbstractProvenanceModel {


	HashMap processesMap = new HashMap();
	HashMap artifactMap = new HashMap();
	HashMap agentMap = new HashMap();

	int processCounter = 0;
	int artifactCounter = 0;
	int usedCounter = 0;
	int wasDerivedFromCounter = 0;
	int wasgeneratedByCounter = 0;
	int wasTriggeredByCounter = 0;
	int wasControlledByCounter = 0;
	int agentCounter = 0;

	int artifactAnnotateId = 0;
	int wgbAnnotateId = 0;
	int usedAnnoateId = 0;
	int wdfAnnotateId = 0;
	int wtbAnnotateId = 0;

	// added for opm
	OPMFactory oFactory;
	Account account;
	Collection<Account> accountCollection;

	Account account2;
	Collection<Account> accountCollection2;

	Account account3;
	Collection<Account> accountCollection3;

	Vector<Process> processes = new Vector<Process>();
	Vector<Agent> agents = new Vector<Agent>();
	Vector<Artifact> artifactes = new Vector<Artifact>();
	Vector<Object> objects = new Vector<Object>();
	Vector<Annotation> annotat = new Vector<Annotation>();
	
	Annotation annnn = new Annotation();
	EmbeddedAnnotation ann = new EmbeddedAnnotation();

	OPMMultipleGranularityPC() {
		oFactory = new OPMFactory();

		account = new Account();
		account.setId("account1");
		accountCollection = new ArrayList<Account>();
		accountCollection.add(account);

		account2 = new Account();
		account2.setId("account2");
		accountCollection2 = new ArrayList<Account>();
		accountCollection2.add(account2);

		account3 = new Account();
		account3.setId("account3");
		accountCollection3 = new ArrayList<Account>();
		accountCollection3.add(account3);

	}

	InformationServiceQuantizer isq = InformationServiceQuantizer.getInstance();

	// /////////////////////////////////////////////////////////////////
	// Specification
	// Deleted from this file - finf it in OPMProvenanceModelXMl
	// /////////////////////////////////////////////////////////////////
	// Execution of workflow

	/** Record the stopping of workflow execution. */
	pointcut executionStop(): execution (*
				au.edu.adelaide.pna.test.PNAAOPTest.exceutionStop());

	after(): executionStop() {
		System.out.println("+++++++++++++++++++++ in execution Stop method");
	
		createOPMGraph();
	}

	public void createOPMGraph() {

		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}

//		Annotation anot = oFactory.newAnnotation("an1", new Annotation(), "aalaki", "arg3", accountCollection);//new Annotations();
//		annotat.add(anot);		
		
		OPMGraph graph = oFactory.newOPMGraph(accountColtemp,
				new Overlaps[] {},
				this.processes.toArray(new Process[this.processes.size()]),
				this.artifactes.toArray(new Artifact[this.artifactes.size()]),
				this.agents.toArray(new Agent[this.agents.size()]),
				this.objects.toArray(), 
				new Annotation[] {});
//				this.annotat.toArray(new Annotation [this.annotat.size()]));
		
		//////////////////////////
//		Profile p = new Profile();
//		p.
//		org.openprovenance.model.ObjectFactory of = new org.openprovenance.model.ObjectFactory();
//		Profile p = of.createProfile();
//		p.setId("12345");
//		p.setValue("profile 1");
//		
//		ann = oFactory.newEmbeddedAnnotation("an15",
//				"http://property.org/hasQuality", "average", accountCollection);
//		Annotation anot = oFactory.newAnnotation("an1", new Annotation(), "aalaki", "arg3", accountCollection);//new Annotations();
//	Annotations anots = 	of.createAnnotations();
//		AnnotationRef ar =oFactory.newAnnotationRef(anot);
//		
//		oFactory.getProfile(p);
//		graph.setAnnotations(this.annotat.toArray(new Annotation()[this.annotat.size()]));
//		oFactory.newProfile("profillle");
	/////////////////////////////////////////////////////	

		// OPMGraph graph=new MyGraph().getGraph(oFactory);
		OPMSerialiser serial2 = OPMSerialiser.getThreadOPMSerialiser();
		try {

			if (isq.getGranularityLevel() == 0) {
				serial2.serialiseOPMGraph(new File(
						"OPM-FineGrainedMoP-AspectJ.xml"), graph, true);
			} else if (isq.getGranularityLevel() == 1) {
				serial2.serialiseOPMGraph(new File(
						"OPM-MediumGrainedMoP-AspectJ.xml"), graph, true);
			} else if (isq.getGranularityLevel() == 2) {
				serial2.serialiseOPMGraph(new File(
						"OPM-CoarseGrainedMoP-AspectJ.xml"), graph, true);
			} else if (isq.getGranularityLevel() == 9) {
				serial2.serialiseOPMGraph(new File("NoProvenance.xml"), graph,
						true);
			}
			System.out.println("xml is created");
		} catch (JAXBException e) {
			System.out.println("**** error in xml writing opm serialiser ");
			e.printStackTrace();
		}
	}

	// =============


	// //////////////////////////////////////////////////////////////////////
	// // relationship methods ////

	/**
	 * Record WasGeneratedBy relationship.
	 * 
	 * It can be useful in OPM model not here.
	 * */

	// not collect artifact value but shows the dependency
	pointcut WasGeneratedBy(): execution (*
			 au.edu.adelaide.kahn.pn.AbstractProcess.getOutputPort(..));
			
	
	Object around(): WasGeneratedBy() {
		

		
		if (!(isq.granularityLevel == 9)) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
					"yyyy/dd/MM hh:mm:ss.SSS");
			String output = "***" + simpleDateFormat.format(new Date());
			output = output + " relation == WasGeneratedBy ; ";
			Object[] args = thisJoinPoint.getArgs();
			Object callee = thisJoinPoint.getTarget();
			Object caller = thisJoinPoint.getThis();
			Object ret = proceed();
			AbstractProcess ab = (AbstractProcess) callee;
			Map res = ab.getData();
			Set<String> WDFkeySet = res.keySet();

			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
				String WGFkey = (String) iterator.next();

				if (WGFkey.equalsIgnoreCase("OutputValue")) {
					output = output + "  Channel.id = " + +ret.hashCode()
							+ "  Channel.name = " + ret;
					output = output + "  Process.id = " + +callee.hashCode()
							+ "  Process.name = " + callee;
					Object outval = res.get(WGFkey);
				
					// opm was generated by

					createWGB(callee, outval, ret, 00);

				}

				if (WGFkey.equalsIgnoreCase("OutputValue1")) {
					output = output + "  Channel.id = " + +ret.hashCode()
							+ "  Channel.name = " + ret;
					output = output + "  Process.id = " + +callee.hashCode()
							+ "  Process.name = " + callee;
					Object outval1 = res.get(WGFkey);

					// opm was generated by
					createWGB(callee, outval1, ret, 10);

				}
				if (WGFkey.equalsIgnoreCase("OutputValue2")) {
					output = output + "  Channel.id = " + +ret.hashCode()
							+ "  Channel.name = " + ret;
					output = output + "  Process.id = " + +callee.hashCode()
							+ "  Process.name = " + callee;
					Object outval2 = res.get(WGFkey);
					// /////////////////////////////////////////////////////////
					// opm was generated by
					createWGB(callee, outval2, ret, 01);

				}
			}
			// ////////////////
			return ret;
		} else {
			Object ret = proceed();
			return ret;
		}
	}

	private void createWGB(Object callee, Object token, Object channel,
			int portIndex) {
		
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		

		if ((isq.getGranularityLevel() == 2)) {
		// find process
		Process findedProcess = findProcessOPMXML(callee);

		// find artifact
		Artifact findedArtifact = findArtifactOPMXML((Token) token);
		this.wasgeneratedByCounter++;
		String wasgeneratedById = "WGB_" + this.wasgeneratedByCounter;
		WasGeneratedBy wg1 = oFactory.newWasGeneratedBy(wasgeneratedById,
				findedArtifact, oFactory.newRole("out"), findedProcess,
				accountColtemp);
		this.objects.add(wg1);
		// annotation
		}else if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
			
			// find process
			Process findedProcess = findProcessOPMXML(callee);

			// find artifact
			Artifact findedArtifact = findArtifactOPMXML((Token) token);
			this.wasgeneratedByCounter++;
			String wasgeneratedById = "WGB_" + this.wasgeneratedByCounter;
			WasGeneratedBy wg1 = oFactory.newWasGeneratedBy(wasgeneratedById,
					findedArtifact, oFactory.newRole("out"), findedProcess,
					accountColtemp);
			
			Value portAnnotate = new Value();
			portAnnotate.setId("port index");
			portAnnotate.setContent(portIndex);
			String pindex = null;
			switch (portIndex) {
			case 00:
				pindex = "0 => the only input port";
				break;
			case 10:
				pindex = "1 => there is two input ports";
				break;
			case 01:
				pindex = "2 => there is two input ports";
				break;
			}
			portAnnotate.setEncoding(pindex);
			Value channelAnnotate = new Value();
			channelAnnotate.setId("channel");
			channelAnnotate.setContent(channel.getClass().getSimpleName());
			channelAnnotate.setEncoding(channel.toString());
			EmbeddedAnnotation embAnno = new EmbeddedAnnotation();
			// embAnno.setId("WGB - Port and Channel");

			oFactory.addAnnotation(embAnno, channelAnnotate);
			oFactory.addAnnotation(embAnno, portAnnotate);

			this.wgbAnnotateId++;
			String wgbAnn = "wgbAnnotation_" + this.wgbAnnotateId;
			oFactory.addAnnotation(wg1, oFactory.newEmbeddedAnnotation(wgbAnn,
					"WGB - Port and Channel", embAnno, accountColtemp));

			
			this.objects.add(wg1);
		}

	
	}

	// ----------------------------------------------------preFire

	pointcut Used():execution (* 
//			au.edu.adelaide.kahn.pn.Process.fire(..))
//		&& target(au.edu.adelaide.kahn.pn.AbstractProcess);
	 au.edu.adelaide.kahn.pn.AbstractProcess.getInputPort(..));

	Object around(): Used() {
		if (!(isq.granularityLevel == 9)) {
			Object ret = proceed();
			String output = " ";
			Object caller = null;
			Object callee = null;
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
					"yyyy/dd/MM hh:mm:ss.SSS");
			output = "***" + simpleDateFormat.format(new Date());
			output = output + " relation == Used ;";
			// Object[] args = thisJoinPoint.getArgs();
			caller = thisJoinPoint.getThis();
			callee = thisJoinPoint.getTarget();
			// Object ret = proceed();
			output = output + "  Channel.id = " + "  Channel.name = " + ret;

			output = output + " Process.name = "
					+ callee.getClass().getSimpleName();
			// System.out.println(" USED" +output);
			AbstractProcess ab = (AbstractProcess) callee;
			Map res = ab.getData();
			Set<String> WDFkeySet = res.keySet();



			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
				String WGFkey = (String) iterator.next();
				if (WGFkey.equalsIgnoreCase("InputValue")) {

					Object inval = res.get(WGFkey);

					/*
					 * // * this code add for pom xml , used //
					 */
					createUSED(callee, inval, ret, 00);

				}

				if (WGFkey.equalsIgnoreCase("InputValue1")) {
					Object inval1 = res.get(WGFkey);


					/*
					 * // * this code add for pom xml , used //
					 */

					createUSED(callee, inval1, ret, 10);

				}
				if (WGFkey.equalsIgnoreCase("InputValue2")) {
					Object inval2 = res.get(WGFkey);
						// ///////////////////////////////////////////////////////////////////////////////
					/*
					 * // * this code add for pom xml , used //
					 */
					createUSED(callee, inval2, ret, 01);

				}

			}
			// Object ret = proceed();

			return ret;
		} else {
			Object ret = proceed();
			return ret;
		}
	}

	private void createUSED(Object callee, Object inval1, Object channel,
			int portIndex) {
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		

		if ((isq.getGranularityLevel() == 2)) {
			
		
		Process findedProcess = findProcessOPMXML(callee);

		// find artifact
		Artifact findedArtifact = findArtifactOPMXML((Token) inval1);
		this.usedCounter++;
		String usedId = "U_" + this.usedCounter;
		Used u1 = oFactory.newUsed(usedId, findedProcess,
				oFactory.newRole("in1"), findedArtifact, accountColtemp);
		this.objects.add(u1);
		// annotation
		}else if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
			Process findedProcess = findProcessOPMXML(callee);

			// find artifact
			Artifact findedArtifact = findArtifactOPMXML((Token) inval1);
			this.usedCounter++;
			String usedId = "USED_" + this.usedCounter;
			Used u1 = oFactory.newUsed(usedId, findedProcess,
					oFactory.newRole("in1"), findedArtifact, accountColtemp);
			
			Value portAnnotate = new Value();
			portAnnotate.setId("port index");
			// portAnnotate.setContent(portIndex);
			String pindex = null;
			switch (portIndex) {
			case 00:
				pindex = "0 => the only input port";
				break;
			case 10:
				pindex = "1 => there is two input ports";
				break;
			case 01:
				pindex = "2 => there is two input ports";
				break;
			}
			portAnnotate.setEncoding(pindex);
			Value channelAnnotate = new Value();
			channelAnnotate.setId("channel");
			EmbeddedAnnotation embAnno = new EmbeddedAnnotation();
			// embAnno.setId("USED - Port and Channel");

			oFactory.addAnnotation(embAnno, channelAnnotate);
			oFactory.addAnnotation(embAnno, portAnnotate);
			this.usedAnnoateId++;
			String usedAnn = "usedAnnotation_" + this.usedAnnoateId;
			oFactory.addAnnotation(u1, oFactory.newEmbeddedAnnotation(usedAnn,
					"USED - Port and Channel", embAnno, accountColtemp));
			this.objects.add(u1);
		}

		
	}


	pointcut wasDeriviedFrom():execution (*
		 au.edu.adelaide.kahn.pn.Process.fire(..))
		 && target(au.edu.adelaide.kahn.pn.AbstractProcess);

	Object around(): wasDeriviedFrom() {

		if (!(isq.granularityLevel == 9)) {

			String filedName = thisJoinPoint.getSignature().getName();
			Object[] args = thisJoinPoint.getArgs();
			Object caller = thisJoinPoint.getThis();
			Object callee = thisJoinPoint.getTarget();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
					"yyyy/dd/MM hh:mm:ss.SSS");
			String output = " ***" + simpleDateFormat.format(new Date());
			output = output + " wasDeriviedFrom : in Process name " + callee
					+ " ";
			// output = output + " with arguments " + args[0];

			// /////////////////////////////////////////////////////////////////////////////
			String processN = "zzz";
			String proName;
			Object procObj = null;
			int inportNo = 0, outPortNo = 0;

			String inputPort1 = null, outPort1 = null, outPort = null, inputPort = null;
			String inputPort2 = null, outPort2 = null;

			Token inputToken = null, inputToken1 = null, inputToken2 = null;
			Token outToken = null, outToken1 = null, outToken2 = null;

			// int OutToken1 = -100, InToken1 = -100;
			// int OutToken2 = -100, InToken2 = -100;
			Object inchanel = null;
			Object outchanel = null;
			AbstractProcess ap = null;
			boolean yek = false, dovom = false;
			String temp1 = " ";
			String temp2 = " ";
			String temp3 = " ";

			Map res = (Map) args[0];
			Set<String> WDFkeySet = res.keySet();
			// AbstractProcess ap = (AbstractProcess) cp.get("process");

			for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
				String WGFkey = (String) iterator.next();

				if (WGFkey.startsWith("Output")) {
					if (WGFkey.equalsIgnoreCase("OutputValue")) {
						outToken = (Token) res.get(WGFkey);
						outPort = WGFkey;
					} else if (WGFkey.equalsIgnoreCase("OutputValue1")) {
						outToken1 = (Token) res.get(WGFkey);
						outPort1 = WGFkey;
					} else if (WGFkey.equalsIgnoreCase("OutputValue2")) {
						outToken2 = (Token) res.get(WGFkey);
						outPort2 = WGFkey;
					}
				}
				if (WGFkey.startsWith("Input")) {
					if (WGFkey.equalsIgnoreCase("InputValue")) {
						inputToken = (Token) res.get(WGFkey);
						inputPort = WGFkey;
					} else if (WGFkey.equalsIgnoreCase("InputValue1")) {
						inputToken1 = (Token) res.get(WGFkey);
						inputPort1 = WGFkey;
					} else if (WGFkey.equalsIgnoreCase("InputValue2")) {
						inputToken2 = (Token) res.get(WGFkey);
						inputPort2 = WGFkey;
					}
				}
			}
			AbstractProcess proces = (AbstractProcess) callee;

			if (!(callee.equals(null))) {
				Process findedProcess = findProcessOPMXML(callee);
				if (!(outToken == null) || !(outToken1 == null)
						|| !(outToken2 == null)) {
					if (!(inputToken == null) || !(inputToken1 == null)
							|| !(inputToken2 == null)) {
						// // outToken
						if (!(outToken == null)) {
							if (!(inputToken == null)) {

								createWDF(inputToken, outToken, callee);

							}
							if (!(inputToken1 == null)) {

								createWDF(inputToken1, outToken, callee);
							}
							if (!(inputToken2 == null)) {

								createWDF(inputToken2, outToken, callee);
							}

						}
						// outToken1
						if (!(outToken1 == null)) {
							if (!(inputToken == null)) {

								createWDF(inputToken, outToken1, callee);

							}
							if (!(inputToken1 == null)) {
								createWDF(inputToken1, outToken1, callee);
							}
							if (!(inputToken2 == null)) {
								createWDF(inputToken2, outToken1, callee);
							}

						}
						// outToken2
						if (!(outToken2 == null)) {
							if (!(inputToken == null)) {
								createWDF(inputToken, outToken2, callee);
							}
							if (!(inputToken1 == null)) {
								createWDF(inputToken1, outToken2, callee);
							}
							if (!(inputToken2 == null)) {
								createWDF(inputToken2, outToken2, callee);
							}

						}
					}
				}
			}

			// }//

			Object ret = proceed();
			return ret;
		} else {
			Object ret = proceed();
			return ret;
		}
	}

	public void createWDF(Token inputToken, Token outToken, Object process) {
		// opm xml
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		

		if ((isq.getGranularityLevel() == 2)) {
		
		// find artifact
		Artifact findedArtifact1 = findArtifactOPMXML(outToken);
		Artifact findedArtifact2 = findArtifactOPMXML(inputToken);

		this.wasDerivedFromCounter++;
		String wasDerivedFromid = "WDF_" + this.wasDerivedFromCounter;

		// show just WDFId
		WasDerivedFrom WDF = this.oFactory.newWasDerivedFrom(wasDerivedFromid,
				findedArtifact1, findedArtifact2, accountColtemp);
		this.objects.add(WDF);
		// annotation
		}else if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
			
			// find artifact
			Artifact findedArtifact1 = findArtifactOPMXML(outToken);
			Artifact findedArtifact2 = findArtifactOPMXML(inputToken);

			this.wasDerivedFromCounter++;
			String wasDerivedFromid = "WDF_" + this.wasDerivedFromCounter;

			// show just WDFId
			WasDerivedFrom WDF = this.oFactory.newWasDerivedFrom(wasDerivedFromid,
					findedArtifact1, findedArtifact2, accountColtemp);
			this.objects.add(WDF);
			
			this.wdfAnnotateId++;
			String wdfAnn = "wdfAnnotation_" + this.wdfAnnotateId;
			oFactory.addAnnotation(WDF, oFactory.newEmbeddedAnnotation(wdfAnn,
					"WDB - process", process.toString(), accountColtemp));
			this.objects.add(WDF);
		}
	}

	// /////////////////////////////////////////////////////

	/*
	 * OPM wasTriggerBy relationship
	 */

	pointcut wasTriggerBy():execution (* au.edu.adelaide.kahn.pn.Process.fire(..))
	&& target(au.edu.adelaide.kahn.pn.AbstractProcess);


	Object around(): wasTriggerBy() {
		
		if (!(isq.granularityLevel == 9)) {
			
			Object ret = null;
			Collection<Account> accountColtemp = null;
			if (isq.getGranularityLevel() == 0) {
				accountColtemp = accountCollection3;
			} else if (isq.getGranularityLevel() == 1) {
				accountColtemp = accountCollection2;
			} else if (isq.getGranularityLevel() == 2) {
				accountColtemp = accountCollection;
			}

			Object[] args = thisJoinPoint.getArgs();
			Object callee = thisJoinPoint.getTarget();
			 ret = proceed();
			AbstractProcess ab = (AbstractProcess) callee;
			if (!(ab.getPreviousProcess() == null)) {
	

				// //////////////////////////////////////////////////////////
				// opm xml
				// find process1
				Process findedProcess1 = findProcessOPMXML(callee);
				Process findedProcess2 = (Process) this.processesMap.get(ab
						.getPrevProcessObj());
				
			if ((isq.granularityLevel == 2)) {

				this.wasTriggeredByCounter++;
				String wasTriggeredById = "WTB_" + this.wasTriggeredByCounter;

				WasTriggeredBy wtb = this.oFactory.newWasTriggeredBy(
						wasTriggeredById, findedProcess1, findedProcess2,
						accountColtemp);
				this.objects.add(wtb);
			
						
			} else
				if ((isq.getGranularityLevel() == 0)
					|| (isq.granularityLevel == 1)) {


				this.wasTriggeredByCounter++;
				String wasTriggeredById = "WTB_" + this.wasTriggeredByCounter;

				WasTriggeredBy wtb = this.oFactory.newWasTriggeredBy(
						wasTriggeredById, findedProcess1, findedProcess2,
						accountColtemp);

				// token ra payda kon
				int inportNo = 0, outPortNo = 0;
				String inputPort1 = null, outPort1 = null, outPort = null, inputPort = null;
				String inputPort2 = null, outPort2 = null;
				Token inputToken = null, inputToken1 = null, inputToken2 = null;
				Token outToken = null, outToken1 = null, outToken2 = null;
				String output = "";

				wtbAnnotateId = 0;

				String wtbAnn = "wtbAnnotation_" + this.wtbAnnotateId;
				Map res = (Map) (ab).getData();
				Set<String> WDFkeySet = res.keySet();
				// AbstractProcess ap = (AbstractProcess) cp.get("process");

				for (Iterator iterator = WDFkeySet.iterator(); iterator.hasNext();) {
					String WGFkey = (String) iterator.next();

					if (WGFkey.startsWith("Input")) {
						if (WGFkey.equalsIgnoreCase("InputValue")) {
							inputToken = (Token) res.get(WGFkey);
							inputPort = WGFkey;

							this.wtbAnnotateId++;
							oFactory.addAnnotation(wtb, oFactory
									.newEmbeddedAnnotation(wtbAnn,
											"WTB - token coming into input port ",
											inputToken.toString(), accountColtemp));

						} else if (WGFkey.equalsIgnoreCase("InputValue1")) {
							inputToken1 = (Token) res.get(WGFkey);
							inputPort1 = WGFkey;

							this.wtbAnnotateId++;
							oFactory.addAnnotation(
									wtb,
									oFactory.newEmbeddedAnnotation(
											wtbAnn,
											"WTB - token coming into input port No. 1",
											inputToken1.toString(), accountColtemp));

						} else if (WGFkey.equalsIgnoreCase("InputValue2")) {
							inputToken2 = (Token) res.get(WGFkey);
							inputPort2 = WGFkey;

							this.wtbAnnotateId++;
							oFactory.addAnnotation(
									wtb,
									oFactory.newEmbeddedAnnotation(
											wtbAnn,
											"WTB - token coming into input port No. 2 ",
											inputToken2.toString(), accountColtemp));
						}
					}
				this.objects.add(wtb);
				}
				}
			}
		
			// Object ret = proceed();
			return ret;
		} else {
			Object ret = proceed();
			return ret;
		}
	}

	
	//======================================================
	/*
	 * // * OPM wasControlledBy relationship // *
	 */

	pointcut wasControlledBy():
				execution (au.edu.adelaide.pna.system.ProcessThreadImpl.new(..))  ;

	Object around(): wasControlledBy(){
		if (!(isq.granularityLevel == 9)) {
			
			Collection<Account> accountColtemp = null;
			if (isq.getGranularityLevel() == 0) {
				accountColtemp = accountCollection3;
			} else if (isq.getGranularityLevel() == 1) {
				accountColtemp = accountCollection2;
			} else if (isq.getGranularityLevel() == 2) {
				accountColtemp = accountCollection;
			}
			
			Object[] args = thisJoinPoint.getArgs();
			Object callee = thisJoinPoint.getTarget();
			ProcessThreadImpl pti = (ProcessThreadImpl) callee;
			Object ret = proceed();
			// ///////////////////////////////////////////////////
			Process findedProcess1 = findProcessOPMXML((Object) (pti
					.getProcess()));

			this.wasControlledByCounter++;
			String wasControlledById = "WCB_" + this.wasControlledByCounter;
			// Agent agent = oFactory.newAgent(callee.toString(),
			// this.accountCollection);
			// // this.objects.add(agent);
			Agent agent = findAgentOPMXML(callee);
			WasControlledBy wcb = this.oFactory.newWasControlledBy(
					wasControlledById,
					findedProcess1,
					oFactory.newRole(String.valueOf(pti.getStrategy())
							+ "- Scheduler"), agent, accountColtemp);

			
//			Annotation anot = this.oFactory.newAnnotation("an1", new Annotation(), "aalaki", "arg3", accountCollection);//new Annotations();
//			Annotation anot = new Annotation();
//			anot.setId("123456");
//			annotat.add(anot);
//			this.objects.add(annotat);
			
			this.objects.add(wcb);

			return ret;
		} else {
			Object ret = proceed();
			return ret;
		}
	}

		

		
	//======================================
	
	public Process findProcessOPMXML(Object proccc) {
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		Process findedProcess = null;
		Set<String> prockeySet = this.processesMap.keySet();
		for (Iterator iter = prockeySet.iterator(); iter.hasNext();) {
			au.edu.adelaide.kahn.pn.Process app = (au.edu.adelaide.kahn.pn.Process) iter
					.next();
			if ((proccc.hashCode()) == (app.hashCode())) {
				findedProcess = (Process) this.processesMap.get(app);
			}
		}
		if (findedProcess == null) {
			this.processCounter++;
			String processId = "P_" + this.processCounter;
			findedProcess = oFactory.newProcess(processId, accountColtemp,
					String.valueOf(proccc));
			this.processes.add(findedProcess);
			processesMap.put(proccc, findedProcess);
		}
		return findedProcess;
	}

	public Agent findAgentOPMXML(Object agent) {
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		Agent findedAgent = null;
		Set<String> agkeySet = this.agentMap.keySet();
		for (Iterator iter = agkeySet.iterator(); iter.hasNext();) {
			ProcessThreadImpl app = (ProcessThreadImpl) iter.next();
			if ((agent.hashCode()) == (app.hashCode())) {
				findedAgent = (Agent) this.processesMap.get(app);
			}
		}
		if (findedAgent == null) {
			this.agentCounter++;
			String agentId = "Agent_" + this.agentCounter;
			findedAgent = oFactory.newAgent(agentId, accountColtemp,
					String.valueOf(agent));
			this.agents.add(findedAgent);
			agentMap.put(agent, findedAgent);
		}
		return findedAgent;
	}

	public Artifact findArtifactOPMXML(au.edu.adelaide.pna.data.Token token) {
		
		Collection<Account> accountColtemp = null;
		if (isq.getGranularityLevel() == 0) {
			accountColtemp = accountCollection3;
		} else if (isq.getGranularityLevel() == 1) {
			accountColtemp = accountCollection2;
		} else if (isq.getGranularityLevel() == 2) {
			accountColtemp = accountCollection;
		}
		
		Artifact findedArtifact = (Artifact) this.artifactMap.get(token);
		if (findedArtifact == null) {
			this.artifactCounter++;
			String artifactId = "a_" + this.artifactCounter;
			findedArtifact = oFactory.newArtifact(artifactId,
					accountColtemp, String.valueOf(token.hashCode()));

			if ((isq.getGranularityLevel() == 0) || (isq.granularityLevel == 1)) {
				this.artifactAnnotateId++;
				String artAnn = "artifactAnnotation_" + this.artifactAnnotateId;
				oFactory.addAnnotation(findedArtifact, oFactory
						.newEmbeddedAnnotation(artAnn, "tokenValue",
								((IntToken) token).intValue(),
								accountColtemp));
			}

			this.artifactes.add(findedArtifact); // add artifact at the end of
													// artifacts array
			this.artifactMap.put(token, findedArtifact);
		}
		return findedArtifact;
	}
}
