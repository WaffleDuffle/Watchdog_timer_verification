
interface axi4Lite_intf();
    logic [3:0] s_axi_araddr ;   
    logic s_axi_arvalid      ;
    logic [3:0] s_axi_awaddr ;    
    logic s_axi_awvalid      ;
    logic s_axi_bready       ;   
    logic s_axi_rready       ;    
    logic [31:0] s_axi_wdata ;    
    logic [3:0] s_axi_wstrb  ;
    logic s_axi_wvalid       ;
    logic freeze             ;
    logic s_axi_aclk         ;
    logic s_axi_aresetn      ;
    logic s_axi_arready      ;
    logic s_axi_awready      ;
    logic [1:0] s_axi_bresp  ;
    logic s_axi_bvalid       ;
    logic [31:0] s_axi_rdata ;
    logic [1:0] s_axi_rresp  ;
    logic s_axi_rvalid       ;
    logic s_axi_wready       ;
    logic timebase_interrupt ;
    logic wdt_interrupt      ;
    logic wdt_rese           ;
endinterface
