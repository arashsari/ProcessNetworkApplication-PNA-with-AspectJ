package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Factory;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.Builder;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import au.edu.adelaide.kahn.pn.Network;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.Set;
import java.util.HashSet;
import java.util.Collections;

/**
 * A builder for the process network data structure.
 * @author Darren Webb
 * @version $Id: PagisBuilder.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public class PNABuilder implements Builder
{
	private Factory factory;
	private Network network;
//	private Set processes = new HashSet();
	private LinkedList<Process> processes = new LinkedList<Process>();
	private Set channels = new HashSet();
	private boolean triggered = false;

	public PNABuilder(Network network)
	{
		this.factory = network.getFactory();
		this.network = network;
	}

	public Factory getFactory()
	{
		return factory;
	}

	public Network getNetwork()
	{
		return network;
	}

	public void add(Process process)
	{
		checkTriggered();
		processes.add(process);
	}

	public void remove(Process process)
	{
		checkTriggered();
		processes.remove(process);
	}

	public boolean contains(Process process)
	{
		return processes.contains(process);
	}

	public LinkedList getProcesses()
	{
//		return Collections.unmodifiableSet(processes);
		return processes;
	}

	/**
	 * Returns null if no connection made.
	 */
	public Channel connect(OutputPort output,InputPort input)
	{
		checkTriggered();
		if (output.canConnectTo(input) && input.canConnectTo(output))
		{
			Channel channel = factory.newChannel(output,input);
			output.connect(channel);
			input.connect(channel);
			channels.add(channel);
			return channel;
		}
		else
			return null;
	}

	public void disconnect(Channel channel)
	{
		checkTriggered();
		if (channels.contains(channel))
		{
			channels.remove(channel);
			channel.getInputPort().connect(null);
			channel.getOutputPort().connect(null);
		}
	}

	public boolean contains(Channel channel)
	{
		return channels.contains(channel);
	}

	public Set getChannels()
	{
		return Collections.unmodifiableSet(channels);
	}

	protected void checkTriggered()
	{
		if (triggered)
			throw new IllegalStateException();
	}

	public void trigger()
	{
		checkTriggered();
		triggered = true;
		network.add(this);
	}

	// my method
	/**
	 * Returns null if no connection made.
	 */
	public Channel connect(Process pro1, OutputPort output,Process pro2, InputPort input){
	
		checkTriggered();
		if (output.canConnectTo(input) && input.canConnectTo(output))
		{
			Channel channel = factory.newChannel(output,input);
			output.connect(channel);
			input.connect(channel);
			channels.add(channel);
			pro2.setPreviousProcess(pro1);
			pro2.setPrevProcessObj(pro1);
			
			
			return channel;
		}
		else
			return null;
	}
	/**
	 * Returns null if no connection made.
	 */
	public Channel connect(Process pro1, int outputIndes,Process pro2, int inputindex){
	
		InputPort input = pro2.inputPortObject(inputindex);
		OutputPort output =pro1.outputPortObject(outputIndes);
		return connect(pro1, output, pro2, input);
	}
	
}
