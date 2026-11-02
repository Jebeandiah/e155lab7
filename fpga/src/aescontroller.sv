module aescontroller #(
	parameter NUM_ITERATIONS = 10
	) (input logic clk, load,
	output logic isintermediate, isfinal, done,  
	output logic [3:0] itercount);
	
	counter #(NUM_ITERATIONS+2, 4) itercounter(clk, !load, !done, itercount);

	assign isintermediate = (itercount!=0 && !isfinal && !done);
	assign isfinal = itercount==NUM_ITERATIONS;
	assign done = itercount == NUM_ITERATIONS+1;
	
	
		
endmodule