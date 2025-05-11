`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/13 13:26:26
// Design Name: 
// Module Name: YUV2RGB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module YUV2RGB(
input clk,
input rstn,
input [7:0] din,
input invalid,
output reg [12:0] R,
output reg [12:0] G,
output reg [12:0] B,
output reg sys_valid
    );
    
reg [12:0] input_data;
reg [12:0] G_U;
reg [12:0] B_U;
reg [12:0] Y, R_V, G_V;
reg [2:0] sel;
reg outvalid;

always@(posedge clk) begin
    if(!rstn) begin
        input_data <= 8'b0;
        sel <= 3'b0;
        R <= 13'b0;
        G <= 13'b0;
        B <= 13'b0;
        G_U <= 13'b0;
        B_U <= 13'b0;
        Y <= 13'b0;
        R_V <= 13'b0;
        G_V <= 13'b0;
    end
    else begin
        input_data <= {{5{din[7]}}, din};
    end
end


always@(posedge clk) begin
    case(sel)
        3'b001 : begin // U1
            outvalid <= 0;
            sel <= sel + 1;
            G_U <= (~input_data+1)<<1;
            B_U <= input_data<<4;
            end

        3'b010 : begin // Y1
            //outvalid <= 0;
            sel <= sel + 1;
            Y <= {5'b0,input_data[7:0]} << 3;
        end

        3'b011 : begin // V1
            sel <= sel + 1;
           outvalid <= 1;
            R_V <= input_data*13;
            G_V <= (~input_data+1)*6;
        end

        3'b100 : begin // Y2
            //outvalid <= 1;
            sel <= 1;
            Y <= {5'b0,input_data[7:0]} << 3;
        end

        default : begin
            outvalid <= 0;
            if(invalid) begin
                sel <= sel + 1;
            end
            else begin
                sel <= 0 ;
            end
        end
    endcase
end



always@(posedge clk) begin
    if(outvalid) begin
        sys_valid <= 1;
        R <= Y + R_V;
        G <= Y + G_U + G_V;
        B <= Y + B_U;
    end
    else begin
        sys_valid <= 0;
        R <= 13'b0;
        G <= 13'b0;
        B <= 13'b0;
    end
end
            

endmodule
