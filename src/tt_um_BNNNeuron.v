module tt_um_BNNNeuron(
  input clock,
  input reset,
  input [31:0] input_data,
  input [31:0] weight,
  output reg o_neuron
);

// Internal signals
reg [31:0] xnor_result;
reg [31:0] accumulated_result;

// XNOR operation
always @(input_data or weight) begin
  xnor_result = ~(input_data ^ weight);
end

// Accumulator
always @(posedge clock or posedge reset) begin
  if (reset) begin
    accumulated_result <= 32'b0;
  end else begin
    accumulated_result <= accumulated_result + xnor_result;
  end
end

// Sign activation function
always @(posedge clock or posedge reset) begin
  if (reset) begin
    o_neuron <= 1'b0;
  end else begin
    if (accumulated_result >= 0) begin
      o_neuron <= 1'b1;
    end else begin
      o_neuron <= 1'b0;
    end
  end
end

endmodule
