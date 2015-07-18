package au.edu.adelaide.kahn.pn;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.Set;

/**
 * Class for building process networks.  The builder class
 * follows the Builder Design Pattern [GOF] to simplify the
 * construction of complex data structures.  The Builder
 * internally constructs a new Network object by adding and
 * removing processes, and connecting and disconnecting ports.
 *
 * @author Darren Webb
 * @version $Id: Builder.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $  
 */
public interface Builder extends Serializable
{
	public Network getNetwork();
	public Factory getFactory();
	public void add(Process process);
	public void remove(Process process);
	public boolean contains(Process process);
//	public Set getProcesses();
	public LinkedList getProcesses();
	public Channel connect(OutputPort output,InputPort input);
	public Channel connect(Process processOut,OutputPort output,Process processIn,InputPort input);
	public Channel connect(Process pro1, int outputIndes,Process pro2, int inputindex);
	public void disconnect(Channel channel);
	public boolean contains(Channel channel);
	public Set getChannels();
	public void trigger();
}
