
package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Process;

/**
 * Code for a thread of control for executing a process of
 * a process network.  Delegates to a process execution strategy.
 *
 * @author Darren Webb
 * @version $Id: ProcessThread.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public interface ProcessThread
{
  public boolean isPaused();
  public boolean isStopped();
  public boolean isFiring();

	/**
	 * Set the scheduling strategy.  This stops the thread,
   * sets the strategy and restarts the thread.
	 */
  public void setStrategy(ProcessThreadStrategy newStrategy);

	/**
	 * The trigger event causes a transition from the initial state to
	 * the firing state.  Only called once (with the exception if the
	 * strategy is replaced).
	 */
	public void trigger();

	/**
	 * Pause execution event, causing a transition from the
	 * firing state to the paused state.  This stops the firing 
	 * thread, but performs no cleanup of process resources 
	 * (e.g. data) so firing may continue at a later time.
	 */
	public void pause();

	/**
	 * Resume execution, causing a transition from the paused
	 * state to the firing state.  This recommences firing
	 * of the process from the last pause point.
	 */
	public void resume();

	/**
	 * Stop execution, causing a transition from the firing
	 * or paused state to the stopped state.  This ends any
	 * future firing of this process (an end state).
	 */
	public void stop();
}
