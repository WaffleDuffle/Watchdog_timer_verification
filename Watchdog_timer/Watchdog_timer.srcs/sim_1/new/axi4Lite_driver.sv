`include "uvm_macros.svh"
`include "axi4Lite_transaction"
import uvm_pkg::*;

class axi4Lite_driver extends uvm_driver #(axi4Lite_transaction);
    
    `uvm_component_utils(axi4Lite_driver)
    
    function new(string name="", uvm_component parent = null);  // componenta persistenta, de aceea avem doua argumente
        super.new(name, parent);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        axi4Lite_transaction item;
        
        forever begin
            seq_item_port.get_next_item(item);
            `uvm_info("axi4Lite_driver", $psprintf("Recieved new item: %s", item.convert2string()), UVM_NONE) // finish ramane blocat pana se termina asta
            seq_item_port.item_done();
        end
    endtask

endclass : axi4Lite_driver