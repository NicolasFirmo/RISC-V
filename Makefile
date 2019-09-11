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
GHDL_FLAGS  = --std=93 --ieee=synopsys --warn-no-vital-generic

WAVEFORM_VIEWER = gtkwave
# WAVEFILE = $(SIM_DIR)/$(TESTBENCH).ghw
# SAVEFILE = simulation/$(TESTBENCH).gtkw

.PHONY: clean all

#view : $(WAVEFILE)
#	$(WAVEFORM_VIEWER) $^ $(SAVEFILE)

# Compilation of the TestBenches
$(SIM_DIR)/%.bin: test/%.vhd $(FILES)
	# Set the working directory
	mkdir -p $(SIM_DIR)/
	
	# Importing the sources
	@echo "Importing ..."
	$(GHDL_CMD) -i $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $^
	# Compiling the sources
	@echo "Starting make .."
	$(GHDL_CMD) -m  $(GHDL_FLAGS)  --workdir=$(SIM_DIR)/ --work=lib_VHDL $*
	
	# Cleaning of the directory
	# mv e~$(call lc, $*).o $(SIM_DIR)/
	mv $(SIM_DIR)/$*.o $(SIM_DIR)/$*.bin

# Running and generation of the wavefile
$(WAVEFILE): $(SIM_DIR)/$(TESTBENCH).bin
	@echo "Run .."
	@./$(SIM_DIR)/$(TESTBENCH).bin $(GHDL_SIM_OPT) --wave=$@

# Cleaning the working directory and the binary files
clean:
	@rm -rf $(SIM_DIR)
	@rm -rf simulation/*

all:  $(SIM_DIR)/MemoryTB.bin
