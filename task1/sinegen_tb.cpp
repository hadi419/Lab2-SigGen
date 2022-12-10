#include "Vsinegen.h"           // header for the top module
#include "verilated.h"          // verilator header
#include "verilated_vcd_c.h"    // trace file header
#include "vbuddy.cpp"           // vbuddy header

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env){
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance 
    Vsinegen* top = new Vsinegen;       // instantiate a sinegen module
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 00);
    tfp->open ("sinegen.vcd");

    // init Vbuddy
    if (vbdOpen() != 1)  return(-1);
    vbdHeader("Lab2: Sinegen");
    // vbdSetMode(1);           // setting the one-shot behaviour of the switch

    // initialise the simulation inputs, variables created inside the top module 
    top->clk = 1;
    top->rst = 0; 
    top->en = 0;
    top->incr = 1;

    // run the simulation for defined clock cycles
    for(simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {
        // dump the variables into a VCD file and toggle the clock
        for(tick = 0; tick < 2; tick++){
            tfp->dump(2*simcyc+tick);
            top->clk = !top->clk;
            top->eval ();
        }

        // send the value to vbuddy to plot
        vbdPlot(int(top->dout), 0, 255);
        vbdCycle(simcyc + 1);       // reporting the cycle count on bottom right of the display

        // changing the initial stimuli
        top->incr = vbdValue();     // value of the incr is determined by the value shown on the display, to change with the rotary switch
        top->rst = (simcyc < 2);
        top->en = (simcyc > 3);

        // exit when either the simulation is finished or the q is pressed
        if((Verilated::gotFinish()) || (vbdGetkey() == 'q'))    exit(0);        // note: vbdGetKey function is non-blocking, it returs NULL if no key is pressed, or the ASCII code of the key pressed
    }

    vbdClose();         // house keeping
    tfp->close();
    exit(0);
}