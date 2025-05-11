`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/17 15:33:11
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg clk;
reg rstn;
reg in_valid;
reg [8-1 : 0] din;
wire [24-1:0] out_data;
top top(
    .clk(clk),
    .rstn(rstn),
    .din(din),
    .in_valid(in_valid),
    .out_data(out_data)
);

initial begin
    clk = 0;
    rstn = 0;
    in_valid = 0;
    #30
    rstn = 1;
    in_valid <= 1;
    din <= 8'b10001011;  //U1 :-117
    #20
    din <= 255;  //Y1
    #20
    din <= 8'b10010001;  //V1:-111
    #20
    din <= 0 ;  //Y2
    #20
    din <= 117;  //U2
    #20
    din <= 255;  //Y3
    #20
    din <= 8'b10010001;  //V2:-111
    #20
    din <= 0 ;  //Y4
    #20
    din <= 8'b10001011;  //U3:-117
    #20
    din <= 255;  //Y5
    #20
    din <= 111;  //V3
    #20
    din <= 0 ;  //Y6

end
always #10 clk=~clk;
endmodule
