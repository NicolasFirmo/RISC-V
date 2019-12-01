library ieee;
use ieee.std_logic_1164.all;
use work.riscv.all;

entity Datapath is port(

    clk : std_logic

);
end Datapath;

architecture Behavioral of Datapath is

    component ProgramMemory is port (
        clk, wren 	: in std_logic;
        frmt		: in std_logic_vector(2 downto 0);
        address		: in std_logic_vector(63 downto 0);
        data		: in std_logic_vector(63 downto 0);
        q			: out std_logic_vector
    );
    end component;

    component DataMemory is port (
        clk, wren 	: in std_logic;
        frmt		: in std_logic_vector(2 downto 0);
        address		: in std_logic_vector(63 downto 0);
        data		: in std_logic_vector(63 downto 0);
        q			: out std_logic_vector
    );
    end component;

    component Mux2x1 is port (
        input0, input1  : in std_logic_vector;
        sel             : in std_logic;
        output          : out std_logic_vector
    );
    end component;

    component Reg32 is port (
        clk, ld		: in std_logic;
        d			: in std_logic_vector(31 downto 0);
        q 			: out std_logic_vector(31 downto 0);
        c           : in std_logic := '0'
    );
    end component;

    component Reg64 is port (
        clk, ld : in std_logic;
        d		: in std_logic_vector(63 downto 0);
        q		: out std_logic_vector(63 downto 0)
    );
    end component;

    component ALU is port (
        alu_fun		: in  std_logic_vector(3 downto 0);
        a, b		: in  std_logic_vector(63 downto 0);
        c			: out std_logic_vector(63 downto 0)
    );
    end component;

    component AluDecoder is port (
        inst		: in  std_logic_vector(31 downto 0);
        alu_fun     : out std_logic_vector(3 downto 0)
    );
    end component;

    component MemoryDecoder is port (
        inst		: in  std_logic_vector(31 downto 0);
        frmt        : out std_logic_vector(2 downto 0);
        wren        : out std_logic
    );
    end component;

    component RegFile64 is port (
        -- Clock e sinal de load
        clk, ld						: in std_logic;
        -- Endereços dos registradores
        addr_rs1, addr_rs2, addr_rd	: in std_logic_vector(4 downto 0);
        -- Dados de entrada do registro referenciado por addr_rs1
        d 							: in std_logic_vector(63 downto 0);
        -- Saídas dos registradores referenciados por addr_rs1 e addr_rs2
        q0, q1 						: out std_logic_vector(63 downto 0)
    );
    end component;

    component mux4x64 is port (
        e0, e1, e2, e3  : in std_logic_vector(63 downto 0);
        sw              : in std_logic_vector(1 downto 0);
        s               : out std_logic_vector(63 downto 0)
    );
    end component;

    component BTypeExt is port (
        e: in std_logic_vector(11 downto 0);
        s: out std_logic_vector(63 downto 0)
    );
    end component;

    component ITypeExt is port (
        e: in std_logic_vector(11 downto 0);
        s: out std_logic_vector(63 downto 0)
    );
    end component;

    component STypeExt is port (
        e: in std_logic_vector(11 downto 0);
        s: out std_logic_vector(63 downto 0)
    );
    end component;

    component JTypeExt is port (
        e: in std_logic_vector(19 downto 0);
        s: out std_logic_vector(63 downto 0)
    );
    end component;

    component UTypeExt is port (
        e: in std_logic_vector(19 downto 0);
        s: out std_logic_vector(63 downto 0)
    );
    end component;

    --* Write to instruction memory
    signal w_inst_mem       : std_logic := '0';

    --* Instruction memory address
    signal inst_mem_addr    : std_logic_vector(63 downto 0) := (others => '0');

    --* Instruction memory data
    signal inst_mem_data    : std_logic_vector(63 downto 0) := (others => '0');

    --* Instruction
    signal inst2            : std_logic_vector(63 downto 0) := (others => '0');

    --* Instruction
    alias inst : std_logic_vector(31 downto 0) is inst2(31 downto 0);

    --* Instructions

    signal inst_reg_stage, inst_ex_stage, inst_mem_stage, inst_wb_stage : std_logic_vector(31 downto 0) := (others => '0');

    alias rs1_addr : std_logic_vector(4 downto 0) is inst_reg_stage(19 downto 15);
    alias rs2_addr : std_logic_vector(4 downto 0) is inst_reg_stage(24 downto 20);
    alias rd_addr : std_logic_vector(4 downto 0) is inst_wb_stage(11 downto 7);
    alias rd_addr_past_1 : std_logic_vector(4 downto 0) is inst_mem_stage(11 downto 7);
    alias rd_addr_past_2 : std_logic_vector(4 downto 0) is inst_ex_stage(11 downto 7);

    signal branch_offset : std_logic_vector(63 downto 0) := (others => '0');

    --* Write to data memory
    signal w_data_mem : std_logic := '0';

    signal data_frmt : std_logic_vector(2 downto 0) := (others => '0');

    signal data_mem_data_in, data_mem_data_out, data_mem_addr : std_logic_vector(63 downto 0) := (others => '0');

    signal ld_pc : std_logic := '1';

    signal pc, pc_plus_4, pc_branch, pc_next, pc_ex_stage, pc_reg_stage: std_logic_vector(63 downto 0) := (others => '0');

    signal pc_sel : std_logic := '0';

    signal alu_fun : std_logic_vector(3 downto 0) := (others => '0');

    signal alu_op1, alu_op2, alu_out : std_logic_vector(63 downto 0) := (others => '0');

    signal flush_pipeline : std_logic := '0';
    signal ld_regfile : std_logic := '0';
    signal bypass_alu : std_logic := '0';
    signal branch_type_sel : std_logic := '0';

    signal rs1_data, rs2_data, rs1_data_or_alu_out, 
           rs2_data_or_alu_out, rd_data, rs1_data_ex, rs2_data_ex             : std_logic_vector(63 downto 0) := (others => '0');

    signal j_imm, u_imm : std_logic_vector(19 downto 0) := (others => '0');

    signal i_imm, s_imm, b_imm : std_logic_vector(11 downto 0) := (others => '0');

    signal b_imm_ext, j_imm_ext, u_imm_ext, s_imm_ext, i_imm_ext : std_logic_vector(63 downto 0) := (others => '0');

    signal alu_op1_sel, alu_op2_sel : std_logic_vector(1 downto 0) := (others => '0');

    alias alu_out_past_1 : std_logic_vector(63 downto 0) is data_mem_addr;
    signal alu_out_past_2 : std_logic_vector(63 downto 0) := (others => '0');
Begin
    
    -- Instruction memory
    inst_mem    : ProgramMemory port map(clk, w_inst_mem, "010", inst_mem_addr, inst_mem_data, inst2);

    -- Data memory
    data_mem    : DataMemory port map(clk, w_data_mem, data_frmt, data_mem_addr, data_mem_data_in, data_mem_data_out);

    -- Program Counter Regiter
    pc_reg      : Reg64 port map(clk, ld_pc, pc_next, pc);

    pc_next <= pc + "0100";

    -- Program Counter Mux
    pc_mux      : Mux2x1 port map(pc_plus_4, pc_branch, pc_sel, pc_next);

    core_alu    : ALU port map(alu_fun, alu_op1, alu_op2, alu_out);

    alu_decoder : AluDecoder port map(inst_ex_stage, alu_fun);

    mem_decoder : MemoryDecoder port map(inst_mem_stage, data_frmt, w_data_mem);

    regfile     : RegFile64 port map(clk, ld_regfile, rs1_addr, rs2_addr, rd_addr, rd_data, rs1_data, rs2_data);

    alu_op1_mux : mux4x64 port map (u_imm_ext, rs1_data_or_alu_out, x"0000000000000000", x"0000000000000000", alu_op1_sel, alu_op1);

    alu_op2_mux : mux4x64 port map (pc_ex_stage, s_imm_ext, i_imm_ext, rs2_data_or_alu_out, alu_op2_sel, alu_op2);

    rs1_alu_mux : Mux2x1 port map (rs1_data_ex, alu_out, bypass_alu, rs1_data_or_alu_out);

    rs2_alu_mux : Mux2x1 port map(rs2_data_ex, alu_out, bypass_alu, rs2_data_or_alu_out);

    branch_type_mux : Mux2x1 port map(j_imm_ext, b_imm_ext, branch_type_sel, branch_offset);

    pc_branch <= branch_offset + pc;

    -- Pipepile regiters

    inst_reg_stage_reg  : Reg32 port map(clk, '1', inst, inst_reg_stage, flush_pipeline);
    inst_ex_stage_reg   : Reg32 port map(clk, '1', inst_reg_stage, inst_ex_stage, flush_pipeline);
    inst_mem_stage_reg  : Reg32 port map(clk, '1', inst_ex_stage, inst_mem_stage, flush_pipeline);
    inst_wb_stage_reg   : Reg32 port map(clk, '1', inst_mem_stage, inst_wb_stage, flush_pipeline);

    rs1_ex_stage_reg        : Reg64 port map(clk, '1', rs1_data, rs1_data_ex);
    rs2_ex_stage_reg        : Reg64 port map(clk, '1', rs2_data, rs2_data_ex);

    rs2_mem_stage_reg       : Reg64 port map(clk, '1', rs2_data_ex, data_mem_data_in);
    alu_out_mem_stage_reg   : Reg64 port map(clk, '1', alu_out, data_mem_addr);
    pc_mem_stage_reg        : Reg64 port map(clk, '1', pc, pc_reg_stage);
    pc_ex_stage_reg         : Reg64 port map(clk, '1', pc_reg_stage, pc_ex_stage);

    alu_out_past_2_reg      : Reg64 port map(clk, '1', alu_out_past_1, alu_out_past_2);

    -- B immediate reordernation
    b_imm(11) <= inst_reg_stage(31);
    b_imm(10) <= inst_reg_stage(7);
    b_imm(9 downto 4) <= inst_reg_stage(30 downto 25);
    b_imm(3 downto 0) <= inst_reg_stage(11 downto 8);

    -- J immediate reordenation
    j_imm(19) <= inst_reg_stage(31);
    j_imm(18 downto 11) <= inst_reg_stage(19 downto 12);
    j_imm(10) <= inst_reg_stage(20);
    j_imm(9 downto 0) <= inst_reg_stage(30 downto 21);

    -- U immediate reordenation
    u_imm <= inst_reg_stage(31 downto 12);

    -- S immediate reordenation
    s_imm(11 downto 5) <= inst_reg_stage(31 downto 25);
    s_imm(4 downto 0) <= inst_reg_stage(11 downto 7);

    -- I immediate reordenation
    i_imm <= inst_reg_stage(31 downto 20);

    b_type_ext           : BTypeExt port map(b_imm, b_imm_ext);
    i_type_ext           : ITypeExt port map(i_imm, i_imm_ext);
    j_type_ext           : JTypeExt port map(j_imm, j_imm_ext);
    u_type_ext           : UTypeExt port map(u_imm, u_imm_ext);
    s_type_ext           : STypeExt port map(s_imm, s_imm_ext);

end Behavioral;