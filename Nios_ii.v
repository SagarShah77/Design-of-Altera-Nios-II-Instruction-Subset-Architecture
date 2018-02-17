module NIOS_II( alu_out_WB_18, Rd_WB_18, clk_18);

	output alu_out_WB_18, Rd_WB_18;
	input clk_18;

	wire clk_18;
	reg[31:0] imem[0:14],rmem[0:31],dmem[0:31];
	reg[4:0] Pre_Rd_18,Pre_Rs_18,Pre_Rt_18;
	reg[1:0] counter=0;

	// register for fetch stage
	reg[31:0] instF_18;

	// registers for Decode stage
	reg alu_en_D_18, reg_rw_D_18,mem_rw_D_18,change_D;
	reg[1:0] alu_fn_D_18,alu_ip_sel_18,brn_en_D_18;
	reg[5:0] op_D_18,pc_18;
	reg[4:0] Rd_D_18,Rs_D_18,Rt_D_18;
	reg[10:0] opx_D_18;
	reg[15:0] imm_D_18;
	reg[25:0] Badd_D_18;
	reg[31:0] instD_18,alu_ip1_D_18,alu_ip2_0_D_18,alu_ip2_1_D_18,alu_ip2_D_18,imm_SE_D_18,Badd_SE_D_18;

	// registers for Execute stage
	reg alu_en_E_18,reg_rw_E_18,mem_rw_E_18,change_E;
	reg[1:0] alu_fn_E_18,brn_en_E_18;
	reg[5:0] op_E_18;
	reg[4:0] Rd_E_18;
	reg[31:0] alu_out_E_18,alu_ip1_E_18,alu_ip2_E_18,imm_SE_E_18,Badd_SE_E_18;
	reg[31:0] alu_ip1F_E_18,alu_ip2F_E_18;

	// registers for memory stage
	reg reg_rw_M_18,mem_rw_M_18;
	reg[4:0] Rd_M_18;
	reg[5:0] op_M_18;
	reg[31:0] alu_out_M_18;

	// registers for write back stage
	reg reg_rw_WB_18,mem_rw_WB_18;
	reg[4:0] Rd_WB_18;
	reg[5:0] op_WB_18;
	reg[31:0] alu_out_WB_18;
	initial
	begin
		instF_18=0;Pre_Rd_18=0;Pre_Rs_18=0;Pre_Rt_18=0;
		alu_en_D_18=0;reg_rw_D_18=0;mem_rw_D_18=0;alu_fn_D_18=0;alu_ip_sel_18=0;
		brn_en_D_18=0;op_D_18=0;Rd_D_18=0;Rs_D_18=0;
		Rt_D_18=0;opx_D_18=0;imm_D_18=0;Badd_D_18=0;instD_18=0;alu_ip1_D_18=0;
		alu_ip2_0_D_18=0;alu_ip2_1_D_18=0;alu_ip2_D_18=0;
		imm_SE_D_18=0;Badd_SE_D_18=0;change_D=0;
		alu_en_E_18=0;reg_rw_E_18=0;mem_rw_E_18=0;alu_fn_E_18=0;brn_en_E_18=0;op_E_18=0;
		Rd_E_18=0;reg_rw_E_18=0;mem_rw_E_18=0; alu_out_E_18=0;alu_ip1_E_18=0;alu_ip2_E_18=0;imm_SE_E_18=0;Badd_SE_E_18=0;
		change_E=0;alu_ip2F_E_18=0;alu_ip1F_E_18=0;
		reg_rw_M_18=0;mem_rw_M_18=0;reg_rw_M_18=0;mem_rw_M_18=0;Rd_M_18=0;
		alu_out_M_18=0;op_M_18=0;
		reg_rw_WB_18=0;mem_rw_WB_18=0;Rd_WB_18=0;alu_out_WB_18=0;op_WB_18=0;
		pc_18=0;

		// instruction memory //
		imem[0]=32'h10000004;
		imem[1]=32'h18000284;
		imem[2]=32'h200005c4;
		imem[3]=32'h21000017;
		imem[4]=32'h28000c7a;
		imem[5]=32'h30800017;
		imem[6]=32'h38c00017;
		imem[7]=32'h418e09fa;
		imem[8]=32'h29500c7a;
		imem[9]=32'h10800044;
		imem[10]=32'h18c00044;
		imem[11]=32'h21000045;
		imem[12]=32'h203ffdd6;
		imem[13]=32'h28000855;
		imem[14]=32'hffffffc6;

		// Register memory //
		rmem[0]=32'h00000000;
		rmem[1]=32'h00000000;
		rmem[2]=32'h00000000;
		rmem[3]=32'h00000000;
		rmem[4]=32'h00000000;
		rmem[5]=32'h00000000;
		rmem[6]=32'h00000000;
		rmem[7]=32'h00000000;
		rmem[8]=32'h00000000;
		rmem[9]=32'h00000000;
		rmem[10]=32'h00000000;
		rmem[11]=32'h00000000;
		rmem[12]=32'h00000000;
		rmem[13]=32'h00000000;
		rmem[14]=32'h00000000;
		rmem[15]=32'h00000000;
		rmem[16]=32'h00000000;
		rmem[17]=32'h00000000;
		rmem[18]=32'h00000000;
		rmem[19]=32'h00000000;
		rmem[20]=32'h00000000;
		rmem[21]=32'h00000000;
		rmem[22]=32'h00000000;
		rmem[23]=32'h00000000;
		rmem[24]=32'h00000000;
		rmem[25]=32'h00000000;
		rmem[26]=32'h00000000;
		rmem[27]=32'h00000000;
		rmem[28]=32'h00000000;
		rmem[29]=32'h00000000;
		rmem[30]=32'h00000000;
		rmem[31]=32'h00000000;

		// data memory //
		dmem[0]=32'h00000000; // 0 A vector starts here
		dmem[1]=32'h00000001; // 1
		dmem[2]=32'h00000001; // 1
		dmem[3]=32'h00000004; // 4
		dmem[4]=32'h00000002; // 2
		dmem[5]=32'h00000006; // 6
		dmem[6]=32'h00000008; // 8
		dmem[7]=32'h00000001; // 1
		dmem[8]=32'h00000008; // 8
		dmem[9]=32'h00000000;
		dmem[10]=32'h00000002; // 2 B vector starts here
		dmem[11]=32'h00000003; // 3
		dmem[12]=32'h00000003; // 3
		dmem[13]=32'h00000006; // 6
		dmem[14]=32'h00000004; // 4
		dmem[15]=32'h00000008; // 8
		dmem[16]=32'h00000000; // 0
		dmem[17]=32'h00000003; // 3
		dmem[18]=32'h00000000; // 0
		dmem[19]=32'h00000000;
		dmem[20]=32'h00000000;
		dmem[21]=32'h00000000; // final answer (Dot product)
		dmem[22]=32'h00000000;
		dmem[23]=32'h00000009; // location of N (no. of loops)
		dmem[24]=32'h00000000;
		dmem[25]=32'h00000000;
		dmem[26]=32'h00000000;
		dmem[27]=32'h00000000;
		dmem[28]=32'h00000000;
		dmem[29]=32'h00000000;
		dmem[30]=32'h00000000;
		dmem[31]=32'h00000000;
		end

		always @(posedge clk_18)
		begin
		if(brn_en_E_18==2'b11 && pc_18 == 6'h0c)
		begin
			pc_18 <= (pc_18) - imm_SE_E_18[3:0];
			counter <= 0;
		end
		else if(brn_en_E_18!=2'b11 && pc_18 == 6'h0c && counter < 2)
		begin
			pc_18 <= pc_18;
			counter <= counter +1;
		end
		else if(brn_en_E_18!=2'b11 && pc_18 == 6'h0c && counter >= 2)
		begin
			pc_18 <= pc_18+1;
		end
		else if(brn_en_E_18==2'b00 && pc_18 == 6'h0e)
			pc_18 <= pc_18;
		else
			pc_18 <= pc_18+1;

			// 1st stage to 2nd stage //
			instD_18 <= instF_18;

			// 2nd stage to 3rd stage //
			alu_en_E_18 <= alu_en_D_18;
			reg_rw_E_18 <= reg_rw_D_18;
			mem_rw_E_18 <= mem_rw_D_18;
			alu_fn_E_18 <= alu_fn_D_18;
			Rd_E_18 <= Rd_D_18;
			alu_ip1_E_18 <= alu_ip1_D_18;
			alu_ip2_E_18 <= alu_ip2_D_18;
			imm_SE_E_18 <= imm_SE_D_18;
			Badd_SE_E_18 <= Badd_SE_D_18;
			op_E_18 <= op_D_18;
			change_E <= change_D;

			// 3rd stage to 4th stage //
			reg_rw_M_18 <= reg_rw_E_18;
			mem_rw_M_18 <= mem_rw_E_18;
			Rd_M_18 <= Rd_E_18;
			alu_out_M_18 <= alu_out_E_18;
			op_M_18 <= op_E_18;

			// 4th stage to 5th stage //
			reg_rw_WB_18 <= reg_rw_M_18;
			mem_rw_WB_18 <= mem_rw_M_18;
			Rd_WB_18 <= Rd_M_18;
			alu_out_WB_18<= alu_out_M_18;
			op_WB_18 <= op_M_18;
		end

		always @(pc_18)//---------------------------------------------------------------------------------------------------// stage 1
		begin
			instF_18 = imem[pc_18];
		end

		always @(instD_18)//-----------------------------------------------------------------------------------------------// stage 2
		begin
			Pre_Rd_18 = Rd_D_18;
			Pre_Rs_18 = Rs_D_18;
			Pre_Rt_18 = Rt_D_18;
			op_D_18 = instD_18[5:0];
			Rd_D_18 = instD_18[31:27];
			Rs_D_18 = instD_18[26:22];
			case(op_D_18)

			//------------- I type inst. -------------//
			6'h04: //MOVIA,ADDI
		begin
			imm_D_18 = instD_18[21:6];
			alu_fn_D_18 = 2'b00; //00 for +
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b1; //register write back enable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b00; //0 for imm as input
		if(Pre_Rd_18 == Rs_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		end
			6'h05: //SUBI
		begin
			imm_D_18 = instD_18[21:6];
			alu_fn_D_18 = 2'b01; //01 for -
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b1; //register write back enable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b00; //0 for imm as input
		if(Pre_Rd_18 == Rs_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		end
			6'h15: //STW
		begin
			imm_D_18 = instD_18[21:6];
			alu_fn_D_18 = 2'b00; //00 for +
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b0; //register write back disable
			mem_rw_D_18 = 1'b1; //memory write enable
			alu_ip_sel_18 = 2'b00; //0 for imm as input
		if(Pre_Rd_18 == Rs_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		end
			6'h17: //LDW
		begin
			imm_D_18 = instD_18[21:6];
			alu_fn_D_18 = 2'b00; //00 for +
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b1; //register write back enable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b00; //0 for imm as input
		if(Pre_Rd_18 == Rs_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0 && mem_rw_WB_18 == 1'b0)
		begin
			alu_ip1_D_18 = dmem[rmem[Rs_D_18]];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = dmem[rmem[Rs_D_18]];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		end

			//------------- R type inst. -------------//
			6'h3a: //ADD,MUL
		begin
			Rt_D_18 = instD_18[21:17];
			opx_D_18 = instD_18[16:6];
		if(opx_D_18==11'h31)
			alu_fn_D_18 = 2'b00; //00 for +
		else if(opx_D_18==11'h27)
			alu_fn_D_18 = 2'b10; //10 for *
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b1; //register write back enable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b01; //1 for reg Rt as input
		if(Pre_Rd_18 == Rs_D_18 || Pre_Rd_18 == Rt_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = rmem[Rs_D_18];
			alu_ip2_1_D_18 = rmem[Rt_D_18];
		end
		end

			//------------- J type inst. -------------//
			6'h06: //BR
		begin
			imm_D_18 = instD_18[21:6];
			Badd_D_18 = {Rd_D_18,Rs_D_18,imm_D_18};
			Rd_D_18 = 0;
			Rs_D_18 = 0;
			alu_en_D_18 = 1'b0; //alu disabled
			reg_rw_D_18 = 1'b0; //register write disable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b10; //2 for badd as input
		if(Pre_Rd_18 == Rs_D_18 || Pre_Rd_18 == Rt_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		end
			6'h16: //BGT
		begin
			imm_D_18 = instD_18[21:6];
			alu_fn_D_18 = 2'b11; //01 for -
			alu_en_D_18 = 1'b1; //alu enabled
			reg_rw_D_18 = 1'b0; //register write disable
			mem_rw_D_18 = 1'b0; //memory write disable
			alu_ip_sel_18 = 2'b01; //1 for reg Rt as input
		if(Pre_Rd_18 == Rs_D_18 || Pre_Rd_18 == Rt_D_18 && pc_18 != 1)
			change_D = 1'b1; //change the input for ALU
		else
			change_D = 1'b0;
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1_D_18 = rmem[Rd_D_18];
			alu_ip2_1_D_18 = rmem[Rs_D_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1_D_18 = rmem[Rd_D_18];
			alu_ip2_1_D_18 = rmem[Rs_D_18];
		end
		end
		endcase
		if(op_D_18 != 6'h3a && op_D_18 != 6'h06)
		begin
		if(imm_D_18[15]==1'b1)
			imm_SE_D_18 = {16'hffff,imm_D_18};
		else
			imm_SE_D_18 = {16'h0000,imm_D_18};
		end
		if(op_D_18 == 6'h16)
			Badd_SE_D_18 = imm_SE_D_18;
		else if (op_D_18 == 6'h06)
		begin
		if(Badd_D_18[25]==1'b1)
			Badd_SE_D_18 = {6'h3f,Badd_D_18};
		else
			Badd_SE_D_18 = {6'h00,Badd_D_18};
		end
			alu_ip2_0_D_18 = imm_SE_D_18;
		if(alu_ip_sel_18 == 2'b00)
			alu_ip2_D_18 = alu_ip2_0_D_18;
		else if (alu_ip_sel_18 == 2'b01)
			alu_ip2_D_18 = alu_ip2_1_D_18;
		else
			alu_ip2_D_18 = Badd_SE_D_18;
		end
		always @(alu_en_E_18,change_E,reg_rw_E_18,mem_rw_E_18,alu_fn_E_18,
			op_E_18,Rd_E_18,alu_ip1_E_18,alu_ip2_E_18,imm_SE_E_18,Badd_SE_E_18)//--------// stage 3
		begin
			brn_en_E_18 = 2'b00;
		if(alu_en_E_18)
		begin
		if (change_E == 1'b1 && op_E_18 == 6'h17)
		begin
			alu_ip2F_E_18 = dmem[alu_out_M_18];
		end
		else if (change_E == 1'b1 && op_E_18 == 6'h3a && alu_fn_E_18 == 2'b10)
		begin
		if(reg_rw_WB_18==1'b0)
		begin
			alu_ip1F_E_18 = rmem[Rd_WB_18];
		end
		else
		begin
		repeat(1)
		@(negedge clk_18);
			alu_ip1F_E_18 = rmem[Rd_WB_18];
		end
			alu_ip2F_E_18 = alu_out_M_18;
		end
		else if (change_E == 1'b1 && op_E_18 == 6'h3a && alu_fn_E_18 == 2'b00)
		begin
			alu_ip1F_E_18 = alu_ip1_E_18;
			alu_ip2F_E_18 = alu_out_M_18;
		end
		else
		begin
			alu_ip1F_E_18 = alu_ip1_E_18;
			alu_ip2F_E_18 = alu_ip2_E_18;
		end
		case(alu_fn_E_18)
			2'b00:
			alu_out_E_18 = alu_ip1F_E_18 + alu_ip2F_E_18;
			2'b01:
			alu_out_E_18 = alu_ip1F_E_18 - alu_ip2F_E_18;
			2'b10:
			alu_out_E_18 = alu_ip1F_E_18 * alu_ip2F_E_18;
			2'B11:
		begin
		if(alu_ip1_E_18 > alu_ip2_E_18) begin
			brn_en_E_18 = 2'b11;
		end
		else
			brn_en_E_18 = 2'b00;
		end
		endcase
		end
		else
		begin
			alu_out_E_18 = Badd_SE_E_18;
			brn_en_D_18 = 2'b10;
		end
		end
		always @(reg_rw_M_18,mem_rw_M_18,Rd_M_18,alu_out_M_18,op_M_18)//-----------------// stage 4
		begin
		if(mem_rw_M_18 == 1'b1 && op_M_18 == 6'h15)
		begin
		if(reg_rw_M_18 == 1'b0)
			dmem[21] = rmem[Rd_M_18];
		end
		end
		always @(reg_rw_WB_18,mem_rw_WB_18,Rd_WB_18,alu_out_WB_18,op_WB_18)//---------// stage 5
		begin
		if(reg_rw_WB_18 == 1'b1)
			rmem[Rd_WB_18] = alu_out_WB_18;
		end
endmodule
