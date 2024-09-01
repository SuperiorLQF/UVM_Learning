module dut (
	input 				clk		,
	input				rst_n	,
	input 		[7:0]	rxd		, //data_in
	input				rx_dv	, //data_in_vld
	output reg 	[7:0] 	txd		, //data_o
	output reg			tx_en	  //data_o_vld
);
	always @(posedge clk) begin
		if(~rst_n) begin
			txd 	<= 8'd0;
			tx_en 	<= 1'b0;
		end
		else begin
			txd 	<= rxd;
			tx_en 	<= rx_dv;
		end
	end
endmodule