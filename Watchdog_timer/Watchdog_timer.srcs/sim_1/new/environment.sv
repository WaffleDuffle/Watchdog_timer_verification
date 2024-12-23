`include "uvm_macros.svh"
import uvm_pkg::*;

class environment extends uvm_env;
	`uvm_component_utils(environment)

    axi4Lite_agent agent;
    
    
	function new (string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		agent = axi4Lite_agent::type_id::create("agent", this);
		`uvm_info("DEBUG", "The build_phase of the environment was called", UVM_NONE)
	endfunction
	
	
endclass : environment
