`include "uvm_macros.svh"
import uvm_pkg::*;

`uvm_analysis_imp_decl(_axi4Lite_monitor)

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
     uvm_analysis_imp_axi4Lite_monitor #(axi4Lite_transaction, scoreboard) axi4Lite_imp_monitor;
     
     int registerBank[10];
     
     function new(string name="", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        axi4Lite_imp_monitor = new("axi4Lite_imp_monitor", this);
    endfunction
    
    virtual function void write_axi4Lite_monitor(axi4Lite_transaction monitorItem);
        if(monitorItem.addrwValid == 1 && monitorItem.wValid == 1)
            registerBank[monitorItem.addr/4] = monitorItem.writeData;
        else begin
            if(monitorItem.readData != registerBank[monitorItem.addr/4])
                `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4], monitorItem.readData))        
        end
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        
    endtask
endclass

