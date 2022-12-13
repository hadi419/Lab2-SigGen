module ram2ports #(
    parameter       ADDRESS_WIDTH = 9,
                    DATA_WIDTH = 8
)(
    input logic                         clk, // clock
    input logic                         wr_en,  // write enabling signal
    input logic                         rd_en,  // read enable signal
    input logic [ADDRESS_WIDTH-1:0]     wr_addr,    // writing address
    input logic [ADDRESS_WIDTH-1:0]     rd_addr,    // reading address
    input logic [DATA_WIDTH-1:0]        din,        // data coming in to be stored
    output logic [DATA_WIDTH-1:0]       dout 
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];        // define the ram array just like the rom array

always_ff @(posedge clk)    begin               // everything is done synchronously so use a always_ff block 
    if(wr_en == 1'b1)
        ram_array[wr_addr] <= din;
    if (rd_en == 1'b1)
        // output is synchronous too
        dout <= ram_array [rd_addr];
end

endmodule 
