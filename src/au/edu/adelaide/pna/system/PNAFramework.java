package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Framework;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.Factory;
import au.edu.adelaide.pna.halfchannel.ChannelController;
import au.edu.adelaide.pna.halfchannel.HalfChannelInputPort;
import au.edu.adelaide.pna.halfchannel.HalfChannelOutputPort;

import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Collections;

//public class PagisFramework extends PagisBuilder implements Framework
public class PNAFramework extends PNABuilder implements Framework
{
	private Factory factory;
	private Network network;
	private Process existingProcess;
	private boolean triggered = false;
	private List inputPorts = new LinkedList();
	private List outputPorts = new LinkedList();
	private Set removedChannels = new HashSet();

	public PNAFramework(Process replacement)
	{
		this(replacement.getNetwork(),replacement);
	}

	public PNAFramework(Network network,Process replacement)
	{
		super(network);
		this.existingProcess = replacement;
		
		// capture the input/output ports for the framework
		ListIterator inputPortIterator = existingProcess.getInputPortList().listIterator();
		while(inputPortIterator.hasNext())
		{
			HalfChannelInputPort inputPort = (HalfChannelInputPort)inputPortIterator.next();
			Channel channel = inputPort.getConnection();
			if (channel != null)
			{
				HalfChannelOutputPort outputPort = (HalfChannelOutputPort)channel.getOutputPort();
				outputPorts.add(outputPort);
				((ChannelController)channel).stopTransfer();
				outputPort.putAll(inputPort.getAll()); // push back
				inputPort.connect(null);
				outputPort.connect(null);
				removedChannels.add(channel);
			}
		}
		ListIterator outputPortIterator = existingProcess.getOutputPortList().listIterator();
		while(outputPortIterator.hasNext())
		{
			HalfChannelOutputPort outputPort = (HalfChannelOutputPort)outputPortIterator.next();
			Channel channel = outputPort.getConnection();
			if (channel != null)
			{
				HalfChannelInputPort inputPort = (HalfChannelInputPort)channel.getInputPort();
				inputPorts.add(inputPort);
				((ChannelController)channel).stopTransfer();
				inputPort.putAll(outputPort.getAll()); // shuffle along
				inputPort.connect(null);
				outputPort.connect(null);
				removedChannels.add(channel);
			}
		}
	}

	public Process getExistingProcess()
	{
		return existingProcess;
	}

	public Set getRemovedChannels()
	{
		return Collections.unmodifiableSet(removedChannels);
	}

	public InputPort getFrameworkOutputPort(int index)
	{
		return (InputPort)inputPorts.get(index);
	}

	public OutputPort getFrameworkInputPort(int index)
	{
		return (OutputPort)outputPorts.get(index);
	}
}
