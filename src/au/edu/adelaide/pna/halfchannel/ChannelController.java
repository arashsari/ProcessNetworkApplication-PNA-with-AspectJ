package au.edu.adelaide.pna.halfchannel;

import au.edu.adelaide.kahn.pn.Channel;

public interface ChannelController extends Channel
{
	public void setInputChannel(HalfChannelOutputPort channel);
	public void setOutputChannel(HalfChannelInputPort channel);
	public void startTransfer();
	public void stopTransfer();
}
