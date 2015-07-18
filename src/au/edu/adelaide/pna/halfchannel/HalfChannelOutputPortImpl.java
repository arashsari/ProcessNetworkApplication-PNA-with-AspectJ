package au.edu.adelaide.pna.halfchannel;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import java.util.List;

public class HalfChannelOutputPortImpl implements HalfChannelOutputPort
{
	private ChannelController channel;
	private Queue localQueue = new Queue(20);

	public HalfChannelOutputPortImpl()
	{
	}

	public void put(Object token)
	{
		localQueue.put(token);
	}

	public void connect(Channel channel)
	{
	    this.channel = (ChannelController)channel;
	}

	public Channel getConnection()
	{
		return channel;
	}

	public boolean canConnectTo(InputPort input)
	{
		return (input instanceof HalfChannelInputPort
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
		return "HalfChannelOutputPortImpl."+hashCode();
	}

	public void putAll(List tokens)
	{
		localQueue.pushBack(tokens);
	}
}
