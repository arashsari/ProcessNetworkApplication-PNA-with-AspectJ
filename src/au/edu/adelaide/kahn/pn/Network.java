package au.edu.adelaide.kahn.pn;

import java.util.LinkedList;
import java.util.Set;

/**
 * A network object is a model of a process network under evaluation.
 *
 * @author Darren Webb
 * @version $Id: Network.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface Network
{
	/**
	 * Add a listener to change in this model.
	 */
	public void addNetworkChangeListener(NetworkChangeListener l);

	/**
	 * Remove a listener of change in this model.
	 */
	public void removeNetworkChangeListener(NetworkChangeListener l);

	/**
	 * Get the factory for all elements in this network.
	 */
	public Factory getFactory();

	/**
	 * Add a subnetwork to the network.
	 * Adds the components of the builder
	 * to the network to begin execution.
	 */
	public void add(Builder builder);

	/**
	 * Add a process to the network.
	 * The process will begin execution.
	 */
	public void add(Process process);

	/**
	 * Remove a redundent process from the network.
	 * The process will cease execution.
	 */
	public void remove(Process process);

	/**
	 * Check to see if the provided process
	 * is part of this execution.
	 */
	public boolean contains(Process process);

	/**
	 * Get a count representing the current total
	 * of processes in this execution.
	 */
	public int getProcessCount();

	/**
	 * Get an iterator of all processes in this
	 * execution.
	 */
//	public Set getProcesses();
	public LinkedList<Process> getProcesses();

	/**
	 * Add a channel to the network.
	 * The physical channel will be created.
	 */
	public void add(Channel channel);

	/**
	 * Remove a channel from the network.
	 * The physical channel will be destroyed.
	 */
	public void remove(Channel channel);

	/**
	 * Check to see if the provided channel
	 * is part of the current execution.
	 */
	public boolean contains(Channel channel);

	/**
	 * Get a count representing the current total
	 * of channels in this execution.
	 */
	public int getChannelCount();

	/**
	 * Get an iterator of all channels in
	 * this execution.
	 */
	public Set getChannels();
}
