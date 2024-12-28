`include "uvm_macros.svh"
import uvm_pkg::*;

class environment extends uvm_env;
	`uvm_component_utils(environment)

    axi4Lite_agent agent;
    scoreboard sb;
    
	function new (string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
        agent = axi4Lite_agent::type_id::create("agent", this);
		sb = scoreboard::type_id::create("sb", this);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
	    super.connect_phase(phase);
	    agent.monitor.analysisPort.connect(sb.axi4Lite_imp_monitor);   
	endfunction
endclass : environment