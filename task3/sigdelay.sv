module sigdelay #(
    parameter   A_WIDTH = 9,
                D_WIDTH = 8
)(
    // interface signals 
    input logic                     clk,    // clock 
    input logic                     rst,    // reset
    input logic                     en,     // enabling the sigdelay module 
    input logic                     wr,     // write signal
    input logic                     rd,     // read signal
    input logic [A_WIDTH-1:0]       offset, // reading offset relative to writing 
    // input logic [A_WIDTH-1:0]       wr_addr,    // writing address
    // input logic [A_WIDTH-1:0]       rd_addr,    // read address
    input logic [D_WIDTH-1:0]       mic_signal,        // data input 
    output logic [D_WIDTH-1:0]      delayed_signal
);

    logic [A_WIDTH-1:0]             address;    // interconnecting wire between the counter and ram for both write and read functions

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (address)
);

ram2ports sigRam (
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (address),                         // write at this address
    .rd_addr (address - offset),                // reading lags writing
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule
