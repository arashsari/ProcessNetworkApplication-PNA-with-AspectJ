package au.edu.adelaide.kahn.pn;

import java.io.Serializable;

/**
 * Class for implementers to introduce new implementations
 * of various process network elements to the system.
 * The builder delegates program element instantiation to the
 * Factory.
 *
 * @author Darren Webb
 * @version $Id: Factory.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface Factory extends Serializable
{
	public Network newNetwork(Factory factory);
	public Builder newBuilder(Network network);
	public Framework newFramework(Network network,Process replacement);
	public Process newProcess(Network network,Process process);
	public Process newProcess(Network network,String processClass);
	public Process newProcess(Network network,Class processClass);
	public InputPort newInputPort(Process process,int index);
	public OutputPort newOutputPort(Process process,int index);
	public Channel newChannel(OutputPort output,InputPort input);
}
