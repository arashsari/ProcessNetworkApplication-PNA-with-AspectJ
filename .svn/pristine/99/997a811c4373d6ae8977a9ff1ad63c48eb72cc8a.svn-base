package au.edu.adelaide.kahn.pn;

import java.util.Set;

/**
 * The framework class is a special builder
 * used for reconfiguration.  All the builder
 * operations stand, with the introduction of
 * methods to handle "dangling" ports, or ports
 * of the process performing the reconfiguration.
 *
 * @author Darren Webb
 * @version $Id: Framework.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface Framework extends Builder
{
	public Process getExistingProcess();
	public Set getRemovedChannels();
	public void add(Process process);
	public void remove(Process process);
	public InputPort getFrameworkOutputPort(int index);
	public OutputPort getFrameworkInputPort(int index);
	public Channel connect(OutputPort output,InputPort input);
	public void disconnect(Channel channel);
	public void trigger();
}
