module sigdelay (
    input logic en,
    input logic clk,
    input logic [8:0] offset,
    input logic [7:0] microphone,
    output logic [7:0] speaker,
    output logic [8:0] rcount
);

// don't forget width after var name is array len
logic [8:0] wcount; // hard-code as we don't pass down parameter for width
//logic [8:0] rcount;

counter counter (
    .en(en),
    .clk(clk),
    .rst(0),
    .count(wcount)
);

dpram ram (
    .clk(clk),
    .ren(1),
    .wen(1),
    .raddr(rcount),
    .waddr(wcount),
    .win(microphone),
    .rout(speaker)
);

assign rcount = (wcount + offset) % (2**9-1);

endmodule: sigdelay
