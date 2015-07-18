//package au.edu.adelaide.pna.system.factory;
//
//import au.edu.adelaide.enigma.dynamic.DynamicMetaFactory;
//import au.edu.adelaide.enigma.mop.MetaFactory;
//import au.edu.adelaide.kahn.pn.Builder;
//import au.edu.adelaide.kahn.pn.Channel;
//import au.edu.adelaide.kahn.pn.Factory;
//import au.edu.adelaide.kahn.pn.Framework;
//import au.edu.adelaide.kahn.pn.InputPort;
//import au.edu.adelaide.kahn.pn.Network;
//import au.edu.adelaide.kahn.pn.OutputPort;
//import au.edu.adelaide.kahn.pn.Process;
//import au.edu.adelaide.pna.halfchannel.ChannelControllerImpl;
//import au.edu.adelaide.pna.halfchannel.HalfChannelInputPort;
//import au.edu.adelaide.pna.halfchannel.HalfChannelInputPortImpl;
//import au.edu.adelaide.pna.halfchannel.HalfChannelOutputPort;
//import au.edu.adelaide.pna.halfchannel.HalfChannelOutputPortImpl;
//import au.edu.adelaide.pna.system.DataFlowStrategy;
//import au.edu.adelaide.pna.system.PNABuilder;
//import au.edu.adelaide.pna.system.PNAFramework;
//import au.edu.adelaide.pna.system.PNANetwork;
//import au.edu.adelaide.pna.system.ProcessThread;
//import au.edu.adelaide.pna.system.ProcessThreadImpl;
//
//public class PNAMOPFactory implements Factory{
//
//		private MetaFactory objectMetaFactory;
//		public static Factory newInstance()
//		{
//			MetaFactory objectMetaFactory = new DynamicMetaFactory("object");
//			Factory factory = new PNAMOPFactory(objectMetaFactory);
//			return factory;
//		}
//
//		public PNAMOPFactory()
//		{
//
//		}
//		public PNAMOPFactory(MetaFactory objectMetaFactory)
//		{
//			this.objectMetaFactory = objectMetaFactory;
//		}
//
//		public Network newNetwork(Factory factory)
//		{
//			Network network = new PNANetwork(factory);
//			network = (Network)objectMetaFactory.newMetaLevelFor(network);
//			return network;
//		}
//
//		public Builder newBuilder(Network network)
//		{
//			return new PNABuilder(network);
//		}
//
//		public Framework newFramework(Network network,Process replacement)
//		{
//			return new PNAFramework(network,replacement);
//		}
//
//		public Process newProcess(Network network,String processClassName)
//		{
//			try
//			{
//				Class processClass = Class.forName(processClassName);
//				return newProcess(network,processClass);
//			}
//			catch (Exception e)
//			{
//				e.printStackTrace();
//				return null;
//			}
//		}
//
//		public Process newProcess(Network network,Class processClass)
//		{
//			try
//			{
//				Process process = (Process)processClass.newInstance();
//				return newProcess(network,process);
//			}
//			catch (Exception e)
//			{
//				e.printStackTrace();
//				return null;
//			}
//		}
//
//		public Process newProcess(Network network,Process process)
//		{
//			Process origProcess = process;
//			process = (Process)objectMetaFactory.newMetaLevelFor(process);
//			
//			
//			DataFlowStrategy strategy = new DataFlowStrategy();
//			ProcessThread thread = new ProcessThreadImpl(process,strategy);
//			process.init(process,network);
//			thread = (ProcessThread) objectMetaFactory.newMetaLevelFor(thread);
//			return process;
//		}
//
//		public InputPort newInputPort(Process process,int index)
//		{
//			InputPort port = new HalfChannelInputPortImpl();
//			port = (InputPort)objectMetaFactory.newMetaLevelFor(port);
//			return port;
//		}
//
//		public OutputPort newOutputPort(Process process,int index)
//		{
//			OutputPort port = new HalfChannelOutputPortImpl();
//			port = (OutputPort)objectMetaFactory.newMetaLevelFor(port);
//			return port;
//		}
//
//		static int channels = 0;
//		public Channel newChannel(OutputPort output,InputPort input)
//		{
//			
//			Channel channel = new ChannelControllerImpl((HalfChannelOutputPort)output,
//														(HalfChannelInputPort)input);
//			channel = (Channel)objectMetaFactory.newMetaLevelFor(channel);
//
//			return channel;
//		}
//	}