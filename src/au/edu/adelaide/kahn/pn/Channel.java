package au.edu.adelaide.kahn.pn;

import java.io.Serializable;

/**
 * Representation for a channel linking two ports.
 * Identifies the producer and consumer of the
 * channel.  Introduced to help traversal of the
 * the process network (for error checking, etc.), 
 * but doesn't introduce unnecessary implementation
 * details.
 *
 * @author Darren Webb
 * @version $Id: Channel.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface Channel extends Serializable
{
	public InputPort getInputPort();
	public OutputPort getOutputPort();
}
