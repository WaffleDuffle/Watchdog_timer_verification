`timescale 1ns / 1ps
`include "includes.sv"

import uvm_pkg::*;

module testbench();

// ----------- Signal declaration ----------- //
// inputs
    logic [5:0] s_axi_araddr ;   
    logic s_axi_arvalid      ;
    logic [5:0] s_axi_awaddr ;    
    logic s_axi_awvalid      ;
    logic s_axi_bready       ;   
    logic s_axi_rready       ;    
    logic [31:0] s_axi_wdata ;    
    logic [3:0] s_axi_wstrb  ;
    logic s_axi_wvalid       ;
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
    logic wdt_interrupt      ;
    logic wdt_reset          ;
    
// ----------- DUT instantiation ----------- //   

 axi_timebase_wdt_wrapper DUT(.*);
 
// ----------- Interface instantiation ----------- //  

 axi4Lite_intf axi4Lite();
 
// ----------- Clock generation ----------- //   

initial begin
    s_axi_aclk = 0;
    s_axi_wstrb = 5'hF;
    forever begin
        #5 s_axi_aclk = ~s_axi_aclk;
    end
end


// ----------- Signal assignments ----------- //  

assign s_axi_araddr = axi4Lite.s_axi_araddr;
assign s_axi_arvalid =axi4Lite.s_axi_arvalid;
assign s_axi_awaddr = axi4Lite.s_axi_awaddr;
assign s_axi_awvalid =axi4Lite.s_axi_awvalid;
assign s_axi_bready = axi4Lite.s_axi_bready;
assign s_axi_rready = axi4Lite.s_axi_rready;
assign s_axi_wdata =  axi4Lite.s_axi_wdata;
assign s_axi_wstrb =  axi4Lite.s_axi_wstrb;
assign s_axi_wvalid = axi4Lite.s_axi_wvalid;
assign s_axi_aresetn =axi4Lite.s_axi_aresetn;

assign axi4Lite.s_axi_aclk = s_axi_aclk;
assign axi4Lite.s_axi_arready = s_axi_arready;
assign axi4Lite.s_axi_awready = s_axi_awready;
assign axi4Lite.s_axi_bresp = s_axi_bresp;
assign axi4Lite.s_axi_bvalid = s_axi_bvalid; 
assign axi4Lite.s_axi_rdata = s_axi_rdata;
assign axi4Lite.s_axi_rresp = s_axi_rresp;
assign axi4Lite.s_axi_rvalid = s_axi_rvalid; 
assign axi4Lite.s_axi_wready = s_axi_wready;
       

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
