`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4Lite_baseSequence extends uvm_sequence #(axi4Lite_transaction);
    `uvm_object_utils(axi4Lite_baseSequence)
    
    int transactionAmount;
    axi4Lite_transaction axi4Lite_item;
    
    function new(string name="axi4Lite_baseSequence");
        super.new(name);
    endfunction : new
    
    virtual task body();
        
        axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item"); // numele il alegem noi, merge doar daca am uvm factory, line 5
        
        `uvm_info("axi4Lite_baseSequence", $psprintf("Going to drive %d items", transactionAmount), UVM_NONE)
        
        repeat(transactionAmount) begin
            start_item(axi4Lite_item);             
            axi4Lite_item.randomize();        
            finish_item(axi4Lite_item); //blocheaza executia pana cand am terminat cu secventele       
        end
        `uvm_info("axi4Lite_baseSequence", $psprintf("Finished generating axi4Lite transactions"), UVM_NONE)
    endtask : body
    
endclass : axi4Lite_baseSequence
