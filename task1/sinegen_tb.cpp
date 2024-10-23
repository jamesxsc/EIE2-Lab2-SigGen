#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

#ifdef VBUDDY
#include "vbuddy.cpp"
#endif

int main(int argc, char **argv, char **env) {
    #ifdef VBUDDY
    std::cout << "Using VBuddy!" << endl;
    vbdOpen();
    #endif

    Verilated::commandArgs(argc, argv);
    int i, clk;
    Vsinegen dut;

    Verilated::traceEverOn(true);
    VerilatedVcdC trace;
    dut.trace(&trace, 99);
    trace.open("sinegen.vcd");

    // init inputs to dut
    dut.clk = 1;
    dut.en = 1;
    dut.rst = 0;

    // loop
    for (i = 0; i < 1000000; i++) {
        for (clk = 0; clk < 2; clk++) {
            trace.dump(2 * i + clk);
            dut.clk = !clk;
            dut.eval();
        }
        // inputs if required (or outputs)
        // todo set frequency

        #ifdef VBUDDY
        dut.freq = vbdValue();
        vbdPlot(dut.data, 0, 255);
        if (vbdGetkey() == 'q') break;
        #endif

        if (Verilated::gotFinish()) break; // better than exiting to ensure trace is closed
    }

    trace.close();
    #ifdef VBUDDY
    vbdClose();
    #endif
    exit(0);
}

