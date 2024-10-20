`include "uvm_macros.svh"
import uvm_pkg::*;

class environment extends uvm_env;
	`uvm_component_utils(environment)

	function new (string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		// Print a message just to demonstrate that the env works
		
		`uvm_info("DEBUG", "The build_phase of the environment was called", UVM_NONE)
	endfunction
endclass : environment