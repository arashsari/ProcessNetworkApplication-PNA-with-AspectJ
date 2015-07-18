package au.edu.adelaide.pna.halfchannel;

import au.edu.adelaide.kahn.pn.ChannelEndException;

import java.util.List;
import java.util.LinkedList;
import java.io.Serializable;

/**
 * An implementation of a blocking queue.
 * The get() method blocks when the queue is
 * empty until a token becomes available.
 * The put() method blocks when the queue is
 * full until a token is taken.
 * The getAll() and putAll() methods are not
 * blocking, enabling bulk transfer of tokens.
 * @author Darren Webb
 * @version $Id: Queue.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public class Queue implements Serializable
{
	private List buffer = new LinkedList();
	private int capacity;
	private boolean closed = false;

	public Queue(int capacity)
	{
		this.capacity = capacity;
	}

	public synchronized void setCapacity(int newCapacity)
	{
		capacity = newCapacity;
		notifyAll();
	}

	public synchronized int getCapacity()
	{
		return capacity;
	}

	public synchronized Object get()
	{
		// wait until tokens are available
		while (buffer.isEmpty() && !closed)
			try {wait();} catch (Exception e) {}
		
		if (buffer.isEmpty() && closed)
		{
			notifyAll();
			throw new ChannelEndException();
		}
		else
		{
			// notify any waiting puts
			notifyAll();

			// remove from the start of the list
			return buffer.remove(0);
		}
	}

	public synchronized List getAll()
	{
		if (buffer.isEmpty() && closed)
		{
			notifyAll();
			throw new ChannelEndException();
		}
		else
		{
			// create a new buffer to hold future tokens
			List tokens = buffer;
			buffer = new LinkedList();

			// notify any waiting puts
			notifyAll();

			// return the old buffer
			return tokens;
		}
	}

	public synchronized void put(Object token)
	{
		// wait until there is space on the buffer
		while (buffer.size() > capacity)
			try {wait();} catch (Exception e) {}

		if (buffer.isEmpty() && closed)
		{
			notifyAll();
			throw new ChannelEndException();
		}
		else
		{
			// add to the end
			buffer.add(token);

			// notify any waiting gets
			notifyAll();
		}
	}

	public synchronized void pushBack(List tokens)
	{
		if (buffer.isEmpty() && closed)
		{
			notifyAll();
			throw new ChannelEndException();
		}
		else
		{
			// add the tokens to the start of the buffer
			buffer.addAll(0,tokens);

			// notify any waiting gets
			notifyAll();
		}
	}

	public synchronized void putAll(List tokens)
	{
		if (buffer.isEmpty() && closed)
		{
			notifyAll();
			throw new ChannelEndException();
		}
		else
		{
			// add the tokens to the end of the buffer
			buffer.addAll(tokens);

			// notify any waiting gets
			notifyAll();
		}
	}

	public synchronized void close()
	{
		closed = true;
		notifyAll();
	}
}
