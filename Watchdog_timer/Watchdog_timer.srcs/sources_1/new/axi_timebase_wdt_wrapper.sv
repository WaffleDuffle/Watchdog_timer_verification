module axi_timebase_wdt_wrapper (
    input logic [3:0] s_axi_araddr,
    output logic s_axi_arready,
    input logic s_axi_arvalid,
    input logic [3:0] s_axi_awaddr,
    output logic s_axi_awready,
    input logic s_axi_awvalid,
    input logic s_axi_bready,
    output logic [1:0] s_axi_bresp,
    output logic s_axi_bvalid,
    output logic [31:0] s_axi_rdata,
    input logic s_axi_rready,
    output logic [1:0] s_axi_rresp,
    output logic s_axi_rvalid,
    input logic [31:0] s_axi_wdata,
    output logic s_axi_wready,
    input logic [3:0] s_axi_wstrb,
    input logic s_axi_wvalid,
    input logic freeze,
    input logic s_axi_aclk,
    input logic s_axi_aresetn,
    output logic timebase_interrupt,
    output logic wdt_interrupt,
    output logic wdt_reset
);

    // VHDL Instance
    axi_timebase_wdt_0 U0 (
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .freeze(freeze),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .timebase_interrupt(timebase_interrupt),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset(wdt_reset)
    );

endmodule