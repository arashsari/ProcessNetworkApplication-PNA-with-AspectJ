package au.edu.adelaide.pna.system;

import java.util.HashMap;

import au.edu.adelaide.kahn.pn.Builder;
import au.edu.adelaide.kahn.pn.Factory;
import au.edu.adelaide.kahn.pn.Network;
import au.edu.adelaide.pna.processes.Identity;
import au.edu.adelaide.pna.processes.IntegerPrinter;
import au.edu.adelaide.pna.processes.IntegerProducer;
import au.edu.adelaide.pna.system.factory.PNAKahnFactory;

public class Test2 {
	public static void main(String[] args) {
//		System.out.println("pagis system test 2");
//
//		System.out.println("W8 in Queue.get has problem, In a way that get method of HalfChannelInputPortImpl \n" +
//				"is called with IntegerPrinter, but nothing is there in Buffer so It will w8 for ever.\n");
//		
//		System.out.println("Therefor it wouldnot run tthrough the end, Program also sth is not run proparly \n, and IntergerPrinter will run first that cause to endless loop.\n ");
		Factory factory = PNAKahnFactory.newInstance();
		Network network = factory.newNetwork(factory);

		Builder builder = factory.newBuilder(network);

		IntegerProducer producer = (IntegerProducer) factory.newProcess(
				network, new IntegerProducer());
		HashMap producerProperties = new HashMap();
		producerProperties.put("Initial Value", "2");
		producerProperties.put("Upper Bound", "9");
		producer.updateProperties(producerProperties);
		builder.add(producer);

		Identity copy = (Identity) factory.newProcess(network, new Identity());
		builder.add(copy);

		IntegerPrinter consumer = (IntegerPrinter) factory.newProcess(network,
				new IntegerPrinter());
		builder.add(consumer);

		builder.connect(producer.getOutputPort(0), copy.getInputPort(0));
		builder.connect(copy.getOutputPort(0), consumer.getInputPort(0));

		builder.trigger();
	}
}
