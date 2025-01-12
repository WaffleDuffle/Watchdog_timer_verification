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
    
    rand logic [5:0] addr;
    rand logic [31:0] writeData;
    rand logic writeEnable;
    logic [31:0] readData;
    
    constraint c_addr {
        (addr % 4) == 0;
        addr <= 5'h10;
    }
    
    function new(string name="axi4Lite_transaction");
        super.new(name);
        readData = 0;
        writeData = 0;
        addr = 0;
        writeEnable = 0;
    endfunction
    
    function string convert2string();
        string outputString = "";
        outputString = $psprintf("%s\n\t * readData=%0b", outputString, readData);
        outputString = $psprintf("%s\n\t * writeData=%0b", outputString, writeData);
        outputString = $psprintf("%s\n\t * addr=%0h", outputString, addr);
        outputString = $psprintf("%s\n\t * writeEnable=%0h", outputString, writeEnable);
        
        return outputString;
    endfunction

endclass 
