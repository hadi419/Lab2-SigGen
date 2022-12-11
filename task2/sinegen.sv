module sinegen #(
    parameter   A_WIDTH = 8,        // address address width 
                D_WIDTH = 8         // data width
)(
    // interface signals 
    input logic                         clk,    // internal clock
    input logic                         rst,    // reset button
    input logic                         en,     // enable signal
    input logic [A_WIDTH-1:0]           incr,   // increment for addr counter
    input logic [A_WIDTH-1:0]           phase,  // this is the phase shift of the two sine waves
    output logic [D_WIDTH-1:0]          dout1,    // data output
    output logic [D_WIDTH-1:0]          dout2
);

    logic [A_WIDTH-1:0]                 address;        // this is the interconnect wire between the counter and the rom that acts as a node

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address)
);

rom sineRom (
    .clk (clk),
    .addr1 (address),
    .addr2 (address + phase),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule 
