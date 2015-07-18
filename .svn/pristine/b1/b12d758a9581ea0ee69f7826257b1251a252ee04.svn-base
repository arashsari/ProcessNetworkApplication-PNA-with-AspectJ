package au.edu.adelaide.pna.halfchannel;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import java.util.List;

public class HalfChannelInputPortImpl implements HalfChannelInputPort
{
	private ChannelController channel;
	private Queue localQueue = new Queue(20);

	public HalfChannelInputPortImpl()
	{
	}

	public Object get()
	{
		return localQueue.get();
	}

	public void connect(Channel channel)
	{
	    this.channel = (ChannelController)channel;
	}

	public Channel getConnection()
	{
		return channel;
	}

	public boolean canConnectTo(OutputPort output)
	{
		return (output instanceof HalfChannelOutputPort
				&& channel == null);
	}

	public void close()
	{
		localQueue.close();
	}

	public List getAll()
	{
		return localQueue.getAll();
	}

	public String getID()
	{
		return "HalfChannelInputPortImpl."+hashCode();
	}

	public void putAll(List tokens)
	{
		localQueue.putAll(tokens);
	}
}
