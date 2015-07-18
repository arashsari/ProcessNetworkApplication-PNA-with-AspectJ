package au.edu.adelaide.pna.system;

import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.kahn.pn.Process;
import au.edu.adelaide.kahn.pn.InputPort;
import au.edu.adelaide.kahn.pn.OutputPort;
import au.edu.adelaide.kahn.pn.Factory;
import au.edu.adelaide.kahn.pn.Channel;
import au.edu.adelaide.kahn.pn.Builder;
import au.edu.adelaide.pna.system.factory.PNAKahnFactory;

import java.util.HashMap;

public class Test
{
	public static void main(String[] args)
	{
		System.out.println("pagis system test 1");

		// setup the metalevel and customizations
		Factory factory = PNAKahnFactory.newInstance();

		// create a network
		Network network = factory.newNetwork(factory);
		Builder builder = factory.newBuilder(network);

		// create the processes
		Process producer = factory.newProcess(network,"au.edu.adelaide.contrib.processes.IntegerProducer");
		HashMap producerProperties = new HashMap();
		producerProperties.put("Initial Value","2");
		producerProperties.put("Upper Bound","20");
		producer.updateProperties(producerProperties);
		builder.add(producer);
		Process sieve = factory.newProcess(network,"au.edu.adelaide.contrib.eratosthene.IterativeSieve");
		builder.add(sieve);
		Process consumer = factory.newProcess(network,"au.edu.adelaide.contrib.processes.IntegerPrinter");
		builder.add(consumer);

		// connect the producer and consumder - this would be done via the builder
		builder.connect(producer.getOutputPort(0),sieve.getInputPort(0));
		builder.connect(sieve.getOutputPort(0),consumer.getInputPort(0));

		// start computation
		builder.trigger();
	}
}
