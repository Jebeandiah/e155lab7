module aescontroller #(
	parameter NUM_ITERATIONS = 10
	) (input logic clk, load,
	output logic isintermediate, isfinal, done,  
	output logic [3:0] itercount);
	
	counter #(NUM_ITERATIONS+3, 4) itercounter(clk, !load&&!done, 1'b1, itercount);

	assign isintermediate = (itercount<1 && !isfinal && !done);
	assign isfinal = itercount==NUM_ITERATIONS+1;
	assign done = itercount == NUM_ITERATIONS+2;
	
	
		
endmodule