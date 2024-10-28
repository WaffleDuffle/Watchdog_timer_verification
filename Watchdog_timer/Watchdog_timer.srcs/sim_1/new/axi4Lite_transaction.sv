`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4Lite_transaction extends uvm_sequence_item;

    `uvm_object_utils(axi4Lite_transaction)   // `uvm_component_utils(axi4_Lite_transaction)
    
 /*   logic writeEnable;
    logic [3:0] s_axi_araddr;
    logic [31:0] s_axi_wdata;
    logic [31:0] s_axi_rdata;
    */
    // or
    
    rand logic writeEnable;
    rand logic [3:0] s_axi_araddr;
    rand logic [31:0] s_axi_wdata;
    logic [31:0] s_axi_rdata;
    
    function new(string name="");
        super.new(name);
        writeEnable = 0;
        s_axi_araddr = 0;
        s_axi_wdata = 0;
        s_axi_rdata = 0;
    endfunction
    
    function string convert2string();
        string outputString = "";
        outputString = $psprintf("%s\n\t * writeEnable=%0b", outputString, writeEnable);
        outputString = $psprintf("%s\n\t * addr=%0h", outputString, s_axi_araddr);
        outputString = $psprintf("%s\n\t * s_axi_wdata=%0h", outputString, s_axi_wdata);
        outputString = $psprintf("%s\n\t * x_axi_rdata=%0h", outputString, s_axi_rdata);
        return outputString;
    endfunction

endclass