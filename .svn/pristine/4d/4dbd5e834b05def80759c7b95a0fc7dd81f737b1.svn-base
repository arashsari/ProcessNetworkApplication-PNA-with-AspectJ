package au.edu.adelaide.kahn.pn;

import java.io.Serializable;

/**
 * Event representing a change in network structure.
 * A Network object causes this event when a builder 
 * is added and its changes are processed.
 *
 * @author Darren Webb
 * @version $Id: NetworkChangeEvent.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public class NetworkChangeEvent implements Serializable
{
	private Network source;
	private Object affected;

	public NetworkChangeEvent(Network source,Object affected)
	{
		this.source = source;
		this.affected = affected;
	}

	/**
	 * Get the source of the event
	 */
	public Network getSource()
	{
		return source;
	}

	/**
	 * Get the affected network element (process or channel)
	 */
	public Object getAffectedElement()
	{
		return affected;
	}
}
