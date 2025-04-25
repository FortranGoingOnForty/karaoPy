# Simple, but not-so-simple, Makefile
# (for karaoke_dsp Fortran module + test driver)
# 2025, mfw

FC        := gfortran
FFLAGS    := -O2 -Wall
MODDIR    := src/karaoke_dsp
BINDIR    := build
MODFLAGS  := -J $(BINDIR)
SRCS      := $(MODDIR)/dsp.f90
DRIVER    := $(MODDIR)/dsp_driver.f90
MODULE_OBJ:= $(BINDIR)/dsp.o
DRIVER_OBJ:= $(BINDIR)/dsp_driver.o
EXE       := $(BINDIR)/dsp_test

.PHONY: all clean

all: $(EXE)

# ensure build directory exists
$(BINDIR):
	mkdir -p $@

# compile module
$(MODULE_OBJ): $(SRCS) | $(BINDIR)
	$(FC) $(FFLAGS) $(MODFLAGS) -c $< -o $@

# compile driver (depends on the module .mod file in $(BINDIR))
$(DRIVER_OBJ): $(DRIVER) $(MODULE_OBJ)
	$(FC) $(FFLAGS) $(MODFLAGS) -c $< -o $@

# link into executable
$(EXE): $(MODULE_OBJ) $(DRIVER_OBJ)
	$(FC) $(FFLAGS) -o $@ \
		$(MODFLAGS) \
		$(MODULE_OBJ) $(DRIVER_OBJ)

clean:
	rm -rf $(BINDIR)