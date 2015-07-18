//package au.edu.adelaide.pna.system.factory;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import au.edu.adelaide.enigma.dynamic.DynamicMetaFactory;
//import au.edu.adelaide.enigma.dynamic.StartPointMetaObject;
//import au.edu.adelaide.enigma.mop.MetaFactory;
//import au.edu.adelaide.enigma.mop.MetaHandlerClass;
//import au.edu.adelaide.enigma.mop.MetaLevelInterface;
//import au.edu.adelaide.enigma.mop.MetaObject;
//import au.edu.adelaide.enigma.mop.MethodReifier;
//import au.edu.adelaide.enigma.remote.RemoteTransmissionHandlerClass;
//import au.edu.adelaide.kahn.pn.Builder;
//import au.edu.adelaide.kahn.pn.Channel;
//import au.edu.adelaide.kahn.pn.Factory;
//import au.edu.adelaide.kahn.pn.Framework;
//import au.edu.adelaide.kahn.pn.InputPort;
//import au.edu.adelaide.kahn.pn.Network;
//import au.edu.adelaide.kahn.pn.OutputPort;
//import au.edu.adelaide.kahn.pn.Process;
//import au.edu.adelaide.pagis.computation.ChannelTargetAction;
//import au.edu.adelaide.pagis.computation.Computation;
//import au.edu.adelaide.pagis.computation.ComputationMetaFactory;
//import au.edu.adelaide.pagis.computation.ComputationReifier;
//import au.edu.adelaide.pagis.computation.InputPortTargetAction;
//import au.edu.adelaide.pagis.computation.OutputPortTargetAction;
//import au.edu.adelaide.pagis.computation.ProcessTargetAction;
//import au.edu.adelaide.pagis.computation.SchedulerTargetAction;
//import au.edu.adelaide.pagis.computation.TargetAction;
//import au.edu.adelaide.pagis.computation.Test1Reconfiguration;
//import au.edu.adelaide.pagis.computation.Test2Reconfiguration;
//import au.edu.adelaide.pna.system.DataFlowStrategy;
//import au.edu.adelaide.pna.system.DemandDrivenStrategy;
//import au.edu.adelaide.pna.system.PNABuilder;
//import au.edu.adelaide.pna.system.PNAFramework;
//import au.edu.adelaide.pna.system.PNANetwork;
//import au.edu.adelaide.pna.system.ProcessThread;
//import au.edu.adelaide.pna.system.ProcessThreadImpl;
//import au.edu.adelaide.pna.halfchannel.ChannelControllerImpl;
//import au.edu.adelaide.pna.halfchannel.HalfChannelInputPort;
//import au.edu.adelaide.pna.halfchannel.HalfChannelInputPortImpl;
//import au.edu.adelaide.pna.halfchannel.HalfChannelOutputPort;
//import au.edu.adelaide.pna.halfchannel.HalfChannelOutputPortImpl;
//
//public class PNACompFactory extends PNAMOPFactory{
//	private MetaFactory objectMetaFactory;
//	private MetaFactory computationMetaFactory;
//	
//	public static Factory newInstance()
//	{
//		MetaFactory objectMetaFactory = new DynamicMetaFactory("object");
//		MetaFactory computationMetaFactory = new ComputationMetaFactory("computation");
//		MetaHandlerClass remoteClass = new RemoteTransmissionHandlerClass();
//		objectMetaFactory.addMetaLevelCustomization(Factory.class,remoteClass);
//		objectMetaFactory.addMetaLevelCustomization(Network.class,remoteClass);
//		objectMetaFactory.addMetaLevelCustomization(Builder.class,remoteClass);
//		
//		
//		
//		Factory factory = new PNACompFactory(objectMetaFactory,computationMetaFactory);
//		factory = (Factory)objectMetaFactory.newMetaLevelFor(factory);
//		
//		return factory;
//	}
//
//	public PNACompFactory(MetaFactory objectMetaFactory,MetaFactory computationMetaFactory)
//	{
//		this.objectMetaFactory = objectMetaFactory;
//		this.computationMetaFactory = computationMetaFactory;
//	}
//	public PNACompFactory(MetaFactory objectMetaFactory)
//	{
//		this.objectMetaFactory = objectMetaFactory;
//	}
//
//	public Network newNetwork(Factory factory)
//	{
//		Network network = new PNANetwork(factory);
//		network = (Network)objectMetaFactory.newMetaLevelFor(network);
//		return network;
//	}
//
//	public Builder newBuilder(Network network)
//	{
//		return new PNABuilder(network);
//	}
//
//	public Framework newFramework(Network network,Process replacement)
//	{
//		return new PNAFramework(network,replacement);
//	}
//
//	public Process newProcess(Network network,String processClassName)
//	{
//		try
//		{
//			Class processClass = Class.forName(processClassName);
//			return newProcess(network,processClass);
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//			return null;
//		}
//	}
//
//	public Process newProcess(Network network,Class processClass)
//	{
//		try
//		{
//			Process process = (Process)processClass.newInstance();
//			return newProcess(network,process);
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//			return null;
//		}
//	}
//
//	public Process newProcess(Network network,Process process)
//	{
//		Process origProcess = process;
//		process = (Process)computationMetaFactory.newMetaLevelFor(process);
//		Computation computation = (Computation)process;
//
//		{
//			TargetAction ta = ProcessTargetAction.instance;
//			StartPointMetaObject topReifier = (StartPointMetaObject)((MetaLevelInterface)process).getThisMethodReifier();
//			MethodReifier reifier = new ComputationReifier(ta,topReifier);
//			computation.setBaseObject(ta.getTargetName(),origProcess);
//			process = (Process)computationMetaFactory.newMetaLevelFor(origProcess,reifier);
//		}
//
//		DataFlowStrategy strategy = new DataFlowStrategy();
//		ProcessThread thread = new ProcessThreadImpl(process,strategy);
//
//		{
//			TargetAction ta = SchedulerTargetAction.instance;
//			StartPointMetaObject topReifier = (StartPointMetaObject)((MetaLevelInterface)process).getThisMethodReifier();
//			MethodReifier reifier = new ComputationReifier(ta,topReifier);
//			computation.setBaseObject(ta.getTargetName(),thread);
//			thread = (ProcessThread)computationMetaFactory.newMetaLevelFor(thread,reifier);
//    }
//
//    MetaLevelInterface mli = (MetaLevelInterface)thread;
//    MetaObject mo = mli.getTargetMetaObject();
//    Map processMap = new HashMap();
//    processMap.put("pagis.computation.thread",thread);
//    processMap.put("scheduler.description",strategy.getDescription());
//    processMap.put("scheduler.type",strategy.getName());
//    processMap.put("scheduler.class",strategy.getClass());
//    processMap.put("scheduler.alternatives",new Object[] {DataFlowStrategy.class,DemandDrivenStrategy.class});
//    processMap.put("reconfiguration.alternatives",new Object[] {Test1Reconfiguration.class,Test2Reconfiguration.class});
//    mo.updateMetaInformation(processMap);
//
//		process.init(process,network);
//		
//		
//		return process;
//	}
//
//	public InputPort newInputPort(Process process,int index)
//	{
//		Computation computation = (Computation)process;
//
//		InputPort port = new HalfChannelInputPortImpl();
//		TargetAction ta = new InputPortTargetAction(index);
//		StartPointMetaObject topReifier = (StartPointMetaObject)((MetaLevelInterface)process).getThisMethodReifier();
//		MethodReifier reifier = new ComputationReifier(ta,topReifier);
//		computation.setBaseObject(ta.getTargetName(),port);
//		port = (InputPort)computationMetaFactory.newMetaLevelFor(port,reifier);
//		return port;
//	}
//
//	public OutputPort newOutputPort(Process process,int index)
//	{
//		Computation computation = (Computation)process;
//
//		OutputPort port = new HalfChannelOutputPortImpl();
//		TargetAction ta = new OutputPortTargetAction(index);
//		StartPointMetaObject topReifier = (StartPointMetaObject)((MetaLevelInterface)process).getThisMethodReifier();
//		MethodReifier reifier = new ComputationReifier(ta,topReifier);
//		computation.setBaseObject(ta.getTargetName(),port);
//		port = (OutputPort)computationMetaFactory.newMetaLevelFor(port,reifier);
//
//		return port;
//	}
//
//	static int channels = 0;
//	public Channel newChannel(OutputPort output,InputPort input)
//	{
//		Channel channel = new ChannelControllerImpl((HalfChannelOutputPort)output,
//				(HalfChannelInputPort)input);
//
//Computation computation = (Computation)input;
//int index = channels++;
//TargetAction ta = new ChannelTargetAction("channel"+index);
//StartPointMetaObject topReifier = (StartPointMetaObject)((MetaLevelInterface)input).getThisMethodReifier();
//MethodReifier reifier = new ComputationReifier(ta,topReifier);
//computation.setBaseObject(ta.getTargetName(),channel);
//channel = (Channel)computationMetaFactory.newMetaLevelFor(channel,reifier);
//
//		return channel;
//	}
//}