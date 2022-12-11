module rom #(
    parameter   ADDRESS_WIDTH = 8,      // parameterised module to change the parameter as we need later on
                DATA_WIDTH = 8
)(
    input logic                         clk,        // interface signals include the clock as the circuit is synchronous
    input logic [ADDRESS_WIDTH-1:0]     addr1,       // this is the address input for the memory address, we have 256 addresses, hence the notation for the bit values
    input logic [ADDRESS_WIDTH-1:0]     addr2,
    output logic [DATA_WIDTH-1:0]       dout1,        // this is data out, this is the word that is going to be read
    output logic [DATA_WIDTH-1:0]       dout2
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];        // defining the rom array like this: I have 2**ADDRESS_WIDTH addresses and each address is DATA_WIDTH wide

initial begin       // initialise the rom 
            $display("Loading ROM.");       // informing the user what is happening
            $readmemh("sinerom.mem", rom_array);    // read from the mem file called sinerom.mem into the rom_array
end;

always_ff @ (posedge clk)
    // output is synchronous
    begin
    dout1 <= rom_array [addr1];       // synchronously output changes 
    dout2 <= rom_array [addr2];       // synchronously change output2 as well
    end
    
endmodule 
