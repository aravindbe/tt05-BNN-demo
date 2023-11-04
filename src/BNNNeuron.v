module bnnneuron(
  input clk,
  input rst_n,
  input [7:0] input_data,
  input [7:0] weight,
  output reg o_neuron
);

// Internal signals
reg [7:0] xnor_result;
reg [7:0] accumulated_result;

// XNOR operation
always @(input_data or weight) begin
  xnor_result = ~(input_data ^ weight);
end

// Accumulator
always @(posedge clk or posedge rst_n) begin
  if (rst_n) begin
    accumulated_result <= 8'b0;
  end else begin
    accumulated_result <= accumulated_result + xnor_result;
  end
end

// Sign activation function
always @(posedge clk or posedge rst_n) begin
  if (rst_n) begin
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