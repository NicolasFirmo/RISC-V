# vhdl files
FILES = src/*$(VHDLEX)
TESTBENCHFILES = test/*$(VHDLEX)
VHDLEX = .vhd

SIM_DIR=simulation

# testbench
#GHDL CONFIG
GHDL_CMD = ghdl

STOP_TIME = 2000ns

# Simulation break condition
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)
GHDL_FLAGS  = --ieee=synopsys --warn-no-vital-generic

WAVEFORM_VIEWER = gtkwave

.PHONY: clean all

# Compilation of the TestBenches
$(SIM_DIR)/%.o: test/%.vhd $(FILES)
	# Set the working directory
	mkdir -p $(SIM_DIR)/
	
	# Importing the sources
	@echo "Importing ..."
	$(GHDL_CMD) -i $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $^
	# Compiling the sources
	@echo "Starting make .."
	$(GHDL_CMD) -m  $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $*
	
	# Cleaning of the directory
	mv $* $(SIM_DIR)/$*

# Running and generation of the wavefile
$(SIM_DIR)/%.ghw: $(SIM_DIR)/%.o
	@echo "Run .."
	@./$(SIM_DIR)/$* $(GHDL_SIM_OPT) --wave=$@

# Cleaning the working directory and the binary files
clean:
	@rm -rf $(SIM_DIR)/*

all:  $(SIM_DIR)/MemoryTB.o

demux: $(SIM_DIR)/demux32tb.o $(SIM_DIR)/demux32tb.ghw

regfile: $(SIM_DIR)/regfile64tb.o $(SIM_DIR)/regfile64tb.ghw

mul: $(SIM_DIR)/multb.o $(SIM_DIR)/multb.ghw

div: $(SIM_DIR)/divtb.o $(SIM_DIR)/divtb.ghw

clz: $(SIM_DIR)/clztb.o $(SIM_DIR)/clztb.ghw

datapath: $(SIM_DIR)/datapathtb.o
