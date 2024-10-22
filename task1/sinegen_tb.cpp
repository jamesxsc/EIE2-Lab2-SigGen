#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
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
    for (i = 0; i < 5000; i++) {
        for (clk = 0; clk < 2; clk++) {
            trace.dump(2 * i * clk); // TODO check this index - seems non monotonic
            dut.clk = !clk;
            dut.eval();
        }
        // inputs if required (or outputs)

        if (Verilated::gotFinish()) break; // better than exiting to ensure trace is closed
    }

    trace.close();
    exit(0);
}

