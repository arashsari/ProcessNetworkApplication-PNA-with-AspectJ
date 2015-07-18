package au.edu.adelaide.kahn.pn;

/**
 * Communication startpoint in a process network.
 * The process writes data to the output port.  The
 * output port directs the data to its channel.
 *
 * @author Darren Webb
 * @version $Id: OutputPort.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface OutputPort
{
	public void put(Object token);
	public void connect(Channel channel);
	public Channel getConnection();
	public boolean canConnectTo(InputPort input);
	public String getID();
	public void close();
}
