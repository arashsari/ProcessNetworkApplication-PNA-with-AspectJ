package au.edu.adelaide.pna.halfchannel;

import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.ChannelEndException;
import java.util.List;

public class ChannelControllerImpl implements ChannelController
{
	private HalfChannelOutputPort inputChannel;
	private HalfChannelInputPort outputChannel;
	private transient TransferThread transferThread;

	public ChannelControllerImpl(HalfChannelOutputPort input,
								 HalfChannelInputPort output)
	{
		setInputChannel(input);
		setOutputChannel(output);
	}

	public synchronized InputPort getInputPort()
	{
		return outputChannel;
	}

	public synchronized OutputPort getOutputPort()
	{
		return inputChannel;
	}

	public synchronized void setInputChannel(HalfChannelOutputPort channel)
	{
		if (transferThread != null)
		{
			throw new IllegalStateException("controller is transferring");
		}
		inputChannel = channel;
	}

	public synchronized void setOutputChannel(HalfChannelInputPort channel)
	{
		if (transferThread != null)
		{
			throw new IllegalStateException("controller is transferring");
		}
		outputChannel = channel;
	}

	public void startTransfer()
	{
		if (transferThread == null)
		{
			transferThread = new TransferThread();
			transferThread.startTransfer();
		}
	}

	public synchronized void stopTransfer()
	{
		if (transferThread != null)
		{
			transferThread.stopTransfer();
			try {transferThread.join();} catch (Exception e) {}
			transferThread = null;
		}
	}

	public class TransferThread extends Thread
	{
		private boolean stop = false;

		public void startTransfer()
		{
			start();
		}

		public void stopTransfer()
		{
			stop = true;
		}

		public void run()
		{
			while (!stop)
			{
				List buffer = null;
				try
				{
					buffer = inputChannel.getAll();
				}
				catch (ChannelEndException e)
				{
					outputChannel.close();
				}
				if (buffer.isEmpty())
				{
					// wait a bit
					try {Thread.sleep(1000);} catch (Exception e) {}
				}
				try
				{
					outputChannel.putAll(buffer);
				}
				catch (ChannelEndException e)
				{
					inputChannel.close();
				}
			}
		}
	}

	public boolean equals(Object o)
	{
		return o.hashCode() == (hashCode());
	}
}
