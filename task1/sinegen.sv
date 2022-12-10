module sinegen #(
    parameter   A_WIDTH = 8,        // address address width 
                D_WIDTH = 8         // data width
)(
    // interface signals 
    input logic                         clk,    // internal clock
    input logic                         rst,    // reset button
    input logic                         en,     // enable signal
    input logic [A_WIDTH-1:0]           incr,   // increment for addr counter
    output logic [D_WIDTH-1:0]          dout    // data output
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
    .addr (address),
    .dout (dout)
);

endmodule 
