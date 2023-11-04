`default_nettype none

module tt_um_BNNNeuron (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input current
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 digit output
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


    assign uo_out [6:0] = 7'd0;

BNNNeuron neuron_inst (
  .clk(clk),            
  .rst_n(rst_n),        
  .input_data(ui_in), // Connect the input_data signal
  .weight(uio_in),        // Connect the weight signal
  .o_neuron(uo_out[7])     // Connect the output signal o_neuron
);

endmodule
