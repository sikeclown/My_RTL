module sync_dualport_ram #(parameter width = 8, depth = 16, addr_size = 4)(
    input [width-1:0]data_in, 
    input clk, rst, wr_en,rd_en,
    input [addr_size-1:0]wr_addr, rd_addr,
    output reg [width-1:0] data_out
);
    
reg [width-1:0] ram [depth-1:0]; 
reg [width-1:0] temp_wr, data_out1;

reg [15:0] j;

integer i;

///// READ OPERATION:

always @(*) begin
    if(rd_en) begin
        data_out1 = ram[rd_addr];
    end
    else begin
        data_out1=data_out;
    end
end
//

always @(posedge clk) begin
    if(rst)begin
        for (i=0 ;i<depth ;i=i+1 ) begin
            ram[i]<='b0;
        end
    end
    else data_out<= data_out1;
end

///// WRITE OPERATION:

always @(*) begin
    if (wr_en) begin
        temp_wr= data_in;
    end
    else begin
        temp_wr = ram[wr_addr];
    end
end
//

always @(posedge clk) begin
    if(rst)begin
        for (i=0 ;i<depth ;i=i+1 ) begin
            ram[i]<='b0;
        end
    end
    else begin
        ram[wr_addr]<=temp_wr;
    end
end

endmodule





    