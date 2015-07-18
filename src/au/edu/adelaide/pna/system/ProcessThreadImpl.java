package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Process;
import java.util.Map;
import java.io.Serializable;

/**
 *
 * @author Darren Webb
 * @version $Id: ProcessThreadImpl.java,v 1.2 2005-08-02 11:54:55 cvsproject Exp $
 */
public class ProcessThreadImpl implements ProcessThread, Runnable, Serializable
{
	private Process process;
	private ProcessThreadStrategy strategy;

	public ProcessThreadImpl(Process process,ProcessThreadStrategy strategy)
	{
		this.process = process;
		this.strategy = strategy;
	}

	public Process getProcess()
	{
		return process;
	}

  /*
   * There'll probably be a race condition if someone relies on these.
   */
  public boolean isStopped()
  {
    return strategy.isStopped();
  }

  public boolean isPaused()
  {
    return strategy.isPaused();
  }

  public boolean isFiring()
  {
    return strategy.isFiring();
  }

  public ProcessThreadStrategy  getStrategy(){
	return strategy;
	  
  }
  public void setStrategy(ProcessThreadStrategy newStrategy)
  {
    if (this.strategy.isStopped()) {
      // no need to kill the thread
      this.strategy = newStrategy;

      // set the state of the new strategy to stopped
      stop();
    }
    else if (this.strategy.isPaused()) {
      // kill the thread
      stop();

      // the new strategy begins in paused state
      this.strategy = newStrategy;
    }
    else {
      // the process is currently firing so needs to be stopped
      stop();

      this.strategy = newStrategy;

      // return the process to its original state
      resume();
    }
  }

	/**
	 * The trigger event causes a transition from the initial
	 * state to the firing state.  Only called once.
	 */
	public void trigger()
	{
		// TBD: check correct process structure
		resume();
	}

	/**
	 * Pause execution event, causing a transition from the
	 * firing state to the paused state.  This stops the firing 
	 * thread, but performs no cleanup of process resources 
	 * (e.g. data) so firing may continue at a later time.
	 */
	public void pause()
	{
    System.out.println("TBD: stop the channel controller threads!!!");
		strategy.pause(process);
	}

	/**
	 * Resume execution, causing a transition from the paused
	 * state to the firing state.  This recommences firing
	 * of the process from the last pause point.
	 */
	public void resume()
	{
//    System.out.println("TBD: start the channel controller threads!!!");
		new Thread(this).start();
		strategy.resume(process);
	}

	/**
	 * Stop execution, causing a transition from the firing
	 * or paused state to the stopped state.  This ends any
	 * future firing of this process (an end state).
	 */
	public void stop()
	{
    System.out.println("TBD: stop the channel controller threads!!!");
		strategy.stop(process);
	}

	/**
	 * Code for the firing thread of this process.
	 * The algorithm is:<br>
	 * <code>
	 *		strategy.preFire(process);<br>
	 *		while(strategy.canFire(process))<br>
	 *		{<br>
	 *			strategy.fire(process,data);<br>
	 *		}<br>
	 *		strategy.postFire(process);<br>
	 *</code>
	 */
	public void run()
	{
		strategy.preFire(process);
		Map data = process.getData();
		while(strategy.canFire(process,data))
		{
			strategy.fire(process,data);
			data = process.getData();
		}
		strategy.postFire(process);
	}
}
