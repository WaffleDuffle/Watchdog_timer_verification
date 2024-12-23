`timescale 1ns / 1ps
`include "includes.sv"

import uvm_pkg::*;

module testbench();

// ----------- Signal declaration ----------- //
// inputs
    logic [3:0] s_axi_araddr ;   
    logic s_axi_arvalid      ;
    logic [3:0] s_axi_awaddr ;    
    logic s_axi_awvalid      ;
    logic s_axi_bready       ;   
    logic s_axi_rready       ;    
    logic [31:0] s_axi_wdata ;    
    logic [3:0] s_axi_wstrb  ;
    logic s_axi_wvalid       ;
    logic freeze             ;
    logic s_axi_aclk         ;
    logic s_axi_aresetn      ;
    
    
 //outputs   
    logic s_axi_arready      ;
    logic s_axi_awready      ;
    logic [1:0] s_axi_bresp  ;
    logic s_axi_bvalid       ;
    logic [31:0] s_axi_rdata ;
    logic [1:0] s_axi_rresp  ;
    logic s_axi_rvalid       ;
    logic s_axi_wready       ;
    logic timebase_interrupt ;
    logic wdt_interrupt      ;
    logic wdt_reset          ;
    
// ----------- DUT instantiation ----------- //   

 axi_timebase_wdt_wrapper DUT(.*);
 
// ----------- Interface instantiation ----------- //  

 axi4Lite_intf axi4Lite();
 
// ----------- Clock generation ----------- //   

initial begin
    s_axi_aclk = 0;
    forever begin
        #5 s_axi_aclk = ~s_axi_aclk;
    end
end


// ----------- Signal assignments ----------- //  

assign axi4Lite.s_axi_araddr = s_axi_araddr;
assign axi4Lite.s_axi_arvalid = s_axi_arvalid;
assign axi4Lite.s_axi_awaddr = s_axi_awaddr;
assign axi4Lite.s_axi_awvalid = s_axi_awvalid;
assign axi4Lite.s_axi_bready = s_axi_bready;
assign axi4Lite.s_axi_rready = s_axi_rready;
assign axi4Lite.s_axi_wdata = s_axi_wdata;
assign axi4Lite.s_axi_wstrb = s_axi_wstrb;
assign axi4Lite.s_axi_wvalid = s_axi_wvalid;
assign axi4Lite.freeze = freeze;
assign axi4Lite.s_axi_aclk = s_axi_aclk;
assign axi4Lite.s_axi_aresetn = s_axi_aresetn;

assign s_axi_arready = axi4Lite.s_axi_arready;
assign s_axi_awready = axi4Lite.s_axi_awready;
assign s_axi_bresp = axi4Lite.s_axi_bresp;
assign s_axi_bvalid = axi4Lite.s_axi_bvalid; 
assign s_axi_rdata = axi4Lite.s_axi_rdata;
assign s_axi_rresp = axi4Lite.s_axi_rresp;
assign s_axi_rvalid = axi4Lite.s_axi_rvalid; 
assign s_axi_wready = axi4Lite.s_axi_wready;
assign timebase_interrupt = axi4Lite.timebase_interrupt;
assign wdt_interrupt = axi4Lite.wdt_interrupt;
assign wdt_reset = axi4Lite.wdt_reset;

// ------- Run a test ------- //
initial begin
    uvm_config_db#(virtual axi4Lite_intf)::set(null, "", "axi4Lite_interface", axi4Lite);
    fork
        begin
            run_test("base_test");
        end
        begin
            int clkLimit = 1000;
            repeat(clkLimit) @(posedge axi4Lite.s_axi_aclk);
            `uvm_fatal("SIM_END", $psprintf("Reached sim limit = %0d", clkLimit))
        end
    join_any 
end
endmodule                              
