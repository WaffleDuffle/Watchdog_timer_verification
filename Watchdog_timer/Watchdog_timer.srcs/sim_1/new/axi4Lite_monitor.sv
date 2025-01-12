`include "uvm_macros.svh"
import uvm_pkg::*;

class axi4Lite_monitor extends uvm_monitor;
    
    `uvm_component_utils(axi4Lite_monitor)
    
    uvm_analysis_port #(axi4Lite_transaction) analysisPort;
    
    function new(string name="", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysisPort = new("axi4LiteAnalysisPort", this);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        virtual axi4Lite_intf axi4Lite_interface;
        
        uvm_config_db#(virtual axi4Lite_intf)::get(null, "", "axi4Lite_interface", axi4Lite_interface);
        fork
			forever begin // WRITE
				axi4Lite_transaction axi4Lite_item;
				axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item_write");

                axi4Lite_item.writeEnable = 1;
                
				wait(axi4Lite_interface.s_axi_awready == 1 && axi4Lite_interface.s_axi_wready == 1);
				@(posedge axi4Lite_interface.s_axi_aclk);

				axi4Lite_item.addr      = axi4Lite_interface.s_axi_awaddr;
				axi4Lite_item.writeData = axi4Lite_interface.s_axi_wdata;

				wait(axi4Lite_interface.s_axi_bvalid == 1);
				@(posedge axi4Lite_interface.s_axi_aclk);

				`uvm_info("axi4Lite_monitor", $psprintf("Detected a new write response: %s", axi4Lite_item.convert2string()), UVM_NONE)
				analysisPort.write(axi4Lite_item);
			end
			forever begin // READ
				axi4Lite_transaction axi4Lite_item;
				axi4Lite_item = axi4Lite_transaction::type_id::create("axi4Lite_item_read");

				wait(axi4Lite_interface.s_axi_arvalid == 1);
				@(posedge axi4Lite_interface.s_axi_aclk);

				axi4Lite_item.addr = axi4Lite_interface.s_axi_araddr;

				wait(axi4Lite_interface.s_axi_rvalid == 1);
				@(posedge axi4Lite_interface.s_axi_aclk);

				axi4Lite_item.readData = axi4Lite_interface.s_axi_rdata;

				`uvm_info("axi4Lite_monitor", $psprintf("Detected a new read response: %s", axi4Lite_item.convert2string()), UVM_NONE)
				analysisPort.write(axi4Lite_item);
			end
		join

    endtask
endclass
