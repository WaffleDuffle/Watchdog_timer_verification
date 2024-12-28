`include "uvm_macros.svh"

import uvm_pkg::*;

class axi4Lite_driver extends uvm_driver #(axi4Lite_transaction);
    
    `uvm_component_utils(axi4Lite_driver)
    
    function new(string name="", uvm_component parent = null);  // componenta persistenta, de aceea avem doua argumente
        super.new(name, parent);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        
        axi4Lite_transaction axi4Lite_item;
        virtual axi4Lite_intf axi4Lite_interface;
        uvm_config_db#(virtual axi4Lite_intf)::get(null, "", "axi4Lite_interface", axi4Lite_interface); 
       
        forever begin
            seq_item_port.get_next_item(axi4Lite_item);
            uvm_report_info("axi4Lite_driver", $psprintf("Recieved new item: %s", axi4Lite_item.convert2string()), UVM_NONE); // finish ramane blocat pana se termina asta
            @(posedge axi4Lite_interface.s_axi_aclk);
            
            if(axi4Lite_item.writeEnable == 1) begin  // Write
                `uvm_info("axi4Lite_driver", $psprintf("Entered first if statement"), UVM_NONE)
                // Drive the address and data
                axi4Lite_interface.s_axi_wdata = axi4Lite_item.writeData;
                axi4Lite_interface.s_axi_awaddr = axi4Lite_item.addr;
                //Signal address and data validation
                axi4Lite_interface.s_axi_wvalid = 1;
                axi4Lite_interface.s_axi_awvalid = 1;
                
                //Wait until the consumer acknowledges the data and the address
                `uvm_info("axi4Lite_driver", $psprintf("s_axi_awready: %0b, s_axi_wready: %0b", axi4Lite_interface.s_axi_awready, axi4Lite_interface.s_axi_wready), UVM_NONE)
                wait(axi4Lite_interface.s_axi_awready == 1 && axi4Lite_interface.s_axi_wready == 1);
                @(posedge axi4Lite_interface.s_axi_aclk);
                axi4Lite_interface.s_axi_awvalid = 0;
				axi4Lite_interface.s_axi_wvalid  = 0;

                //Wait until the consumer aknowledges the write and check the response
                `uvm_info("axi4Lite_driver", $psprintf("s_axi_bvalid: %0b", axi4Lite_interface.s_axi_bvalid), UVM_NONE)
                wait(axi4Lite_interface.s_axi_bvalid == 1);
                @(posedge axi4Lite_interface.s_axi_aclk);
                              
                if(axi4Lite_interface.s_axi_bresp == 0) 
                    `uvm_info("axi4Lite_driver", "Write access successfull", UVM_NONE)
                else
                    `uvm_warning("axi4Lite_driver", $psprintf("The previous write generated %0b response", axi4Lite_interface.s_axi_bresp))
                
                // Acknowledge the response 
                axi4Lite_interface.s_axi_bready = 1;
                @(posedge axi4Lite_interface.s_axi_aclk);
                axi4Lite_interface.s_axi_bready = 0;
            end
            else begin  // Read
                
                axi4Lite_interface.s_axi_araddr = axi4Lite_item.addr;
                axi4Lite_interface.s_axi_arvalid = 1;
                
                // Wait until the consumer acknowledges the address
                `uvm_info("axi4Lite_driver", $psprintf("s_axi_arready: %0b", axi4Lite_interface.s_axi_arready), UVM_NONE)
                wait(axi4Lite_interface.s_axi_arready == 1);
                `uvm_info("axi4Lite_driver", $psprintf("Entered second if statement"), UVM_NONE)
                @(posedge axi4Lite_interface.s_axi_aclk);
                axi4Lite_interface.s_axi_arvalid = 0;
                
                // Wait until the consumer signals that the read data is available on the bus
               `uvm_info("axi4Lite_driver", $psprintf("s_axi_rvalid: %0b", axi4Lite_interface.s_axi_rvalid), UVM_NONE)
                wait (axi4Lite_interface.s_axi_rvalid == 1);
                
                @(posedge axi4Lite_interface.s_axi_aclk);
                if(axi4Lite_interface.s_axi_rresp == 0) 
                    `uvm_info("axi4Lite_driver", "Read access successfull", UVM_NONE)
                else
                    `uvm_warning("axi4Lite_driver", $psprintf("The previous read generated %0b response", axi4Lite_interface.s_axi_rresp))
                
                // Acknowledge the response 
                axi4Lite_interface.s_axi_rready = 1;
                @(posedge axi4Lite_interface.s_axi_aclk);
                axi4Lite_interface.s_axi_rready = 0;
            end
            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : axi4Lite_driver