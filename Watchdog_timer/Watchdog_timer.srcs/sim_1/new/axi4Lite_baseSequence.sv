`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4Lite_baseSequence extends uvm_sequence #(axi4Lite_transaction);
    `uvm_object_utils(axi4Lite_baseSequence)
    
    int transactionAmount = 10;
    axi4Lite_transaction item;
    
    function new(string name="axi4Lite_baseSequence");
        super.new(name);
    endfunction : new
    
    virtual task body();
        
        item = axi4Lite_transaction::type_id::create("item"); // numele il alegem noi, merge doar daca am uvm factory, line 5
        
        `uvm_info("axi4Lite_baseSequence", $psprintf("Going to drive %d items", transactionAmount), UVM_NONE)
        repeat(transactionAmount) begin
        start_item(item);
       /* 
        item.writeEnable = 1;
        item.s_axi_araddr = 5;
        item.s_axi_wdata = 10;*/
        
        // or
        
        item.randomize();
        
        finish_item(item); //blocheaza executia pana cand am terminat cu secventele
        
        end
    endtask : body
    
endclass : axi4Lite_baseSequence