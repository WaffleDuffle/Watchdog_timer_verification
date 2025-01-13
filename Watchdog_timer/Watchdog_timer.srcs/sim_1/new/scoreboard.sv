`include "uvm_macros.svh"
import uvm_pkg::*;

`uvm_analysis_imp_decl(_axi4Lite_monitor)

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
     uvm_analysis_imp_axi4Lite_monitor #(axi4Lite_transaction, scoreboard) axi4Lite_imp_monitor;
     
     int registerBank[8];
     
     function new(string name="", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        axi4Lite_imp_monitor = new("axi4Lite_imp_monitor", this);
    endfunction
    
    virtual function void write_axi4Lite_monitor(axi4Lite_transaction monitorItem);
        case(monitorItem.addr) 
            6'h0C: begin
                 // read 
            end
            6'h10: begin
                 // ESR register, this one checks for bad events and decrements bits [22:00] if a bad event occured, initial value is 5
               
            end
            6'h14: begin
                if(monitorItem.writeEnable == 1) begin
                    registerBank[monitorItem.addr/4-3][31:16] = 0;    // reserved
                    registerBank[monitorItem.addr/4-3][15:0] = monitorItem.writeData[15:0];
                    
                end
                else begin
                    if(monitorItem.readData != registerBank[monitorItem.addr/4-3])
                    `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4-3], monitorItem.readData))        
                    end
            end
            6'h18: begin
                if(monitorItem.writeEnable == 1) begin                 
                    registerBank[monitorItem.addr/4-3] = monitorItem.writeData;                    
                end
                else begin
                    if(monitorItem.readData != registerBank[monitorItem.addr/4-3])
                    `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4-3], monitorItem.readData))        
                    end
            end
            6'h1C: begin
                if(monitorItem.writeEnable == 1) begin
                    registerBank[monitorItem.addr/4-3] = monitorItem.writeData;
                    
                end
                else begin
                    if(monitorItem.readData != registerBank[monitorItem.addr/4-3])
                    `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4-3], monitorItem.readData))        
                    end
            end
            6'h20: begin
                if(monitorItem.writeEnable == 1) begin
                    registerBank[monitorItem.addr/4-3] = monitorItem.writeData;
                    
                end
                else begin
                    if(monitorItem.readData != registerBank[monitorItem.addr/4-3])
                    `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4-3], monitorItem.readData))        
                    end
            end
            6'h24: begin
                if(monitorItem.writeEnable == 1) begin
                    registerBank[monitorItem.addr/4-3] = monitorItem.writeData;
                    
                end
                else begin
                    if(monitorItem.readData != registerBank[monitorItem.addr/4-3])
                    `uvm_error("DUT_ERROR", $psprintf("Read mismatch on address %0h, expected %0h, received %0h", monitorItem.addr, registerBank[monitorItem.addr/4-3], monitorItem.readData))        
                    end
            end
            6'h28: begin
                // read only register
            end
            
        
        endcase
        
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        
    endtask
endclass
