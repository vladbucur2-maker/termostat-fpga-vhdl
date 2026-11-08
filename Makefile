# Simulare cu GHDL (open-source): https://github.com/ghdl/ghdl
#   make         -> compilează și rulează testbench-ul
#   make compile -> doar analiză + elaborare (verifică sintaxa întregului design)
#   make clean   -> șterge fișierele generate

GHDL    ?= ghdl
WORKDIR := build/ghdl
FLAGS   := --std=08 --workdir=$(WORKDIR)
SRC     := $(wildcard src/*.vhd)
TB      := sim/simulare_UC.vhd
TOP     := top_level_Termostat
TB_TOP  := simulare_UC
STOP    ?= 3us

.PHONY: all compile sim clean

all: sim

compile:
	mkdir -p $(WORKDIR)
	$(GHDL) -i $(FLAGS) $(SRC) $(TB)
	$(GHDL) -m $(FLAGS) $(TOP)
	$(GHDL) -m $(FLAGS) $(TB_TOP)

sim: compile
	$(GHDL) -r $(FLAGS) $(TB_TOP) --stop-time=$(STOP) --vcd=$(WORKDIR)/$(TB_TOP).vcd
	@echo "Forme de undă: $(WORKDIR)/$(TB_TOP).vcd (se deschid cu GTKWave)"

clean:
	rm -rf build $(TOP) $(TB_TOP) *.o *.cf
