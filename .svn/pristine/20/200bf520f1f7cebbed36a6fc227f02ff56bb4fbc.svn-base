package au.edu.adelaide.kahn.pn;

/**
 * Representation of a communication endpoint.  The
 * input port is connected to a channel.  The 
 * input port delegates reading from the channel.
 *
 * @author Darren Webb
 * @version $Id: InputPort.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface InputPort
{
	public Object get();
	public void connect(Channel channel);
	public Channel getConnection();
	public boolean canConnectTo(OutputPort output);
	public String getID();
	public void close();
}
