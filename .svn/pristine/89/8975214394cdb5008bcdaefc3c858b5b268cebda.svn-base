package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;

import java.util.Map;

/**
 * ProcessExecutionStrategy defines the way in which
 * a process is fired, paused, resumed, and stopped.
 * The interface provides a way for a variety of
 * execution and quiescence strategies can be achieved.
 *
 * @author Darren Webb
 * @version $Id: ProcessThreadStrategy.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface ProcessThreadStrategy
{
  public String getName();
  public String getDescription();
	public boolean isPaused();
	public boolean isStopped();
	public boolean isFiring();
	public void preFire(Process process);
	public boolean canFire(Process process,Map data);
	public void fire(Process process,Map data);
	public void postFire(Process process);
	public void put(OutputPort port,Object token);
	public Object get(InputPort port);
	public void pause(Process process);
	public void resume(Process process);
	public void stop(Process process);
};
