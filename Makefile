#
#
PROG =	emepctm
###################################################

#include Makefile.SRCS

###################################################

# prefered netCDF 4.2.1.1 or later
#LIBS = -lnetcdff -lnetcdf -lmpi_usempi -lmpi_mpifh -lmpi
LIBS = -lnetcdff -lnetcdf
INCL = -I${NETCDFINCLUDE} -I${MPI_INCLUDE} -I${MPI_LIB}
LLIB = -L${NETCDFLIB} -L${MPI_LIB}

# options by nc-config/nf-config utility
#INCL = $(shell nc-config --fflags)
#LLIB = $(shell nc-config --flibs)

#F90 = gfortran
F90 = mpifort

# GNU gfortran compiler (tested for version 8.5.0)
F90FLAGS = -fdefault-real-8  -ffixed-line-length-none -ffree-line-length-none -Wno-error=line-truncation -O3 -g
# GNU gfortran compiler (tested for version 12.2.0 and 11.3.0)
F90FLAGS = -fdefault-real-8 -fallow-argument-mismatch  -ffixed-line-length-none -ffree-line-length-none -Wno-error=line-truncation -O3 -g
#DEBUG flag
#F90FLAGS += -Wall -fbacktrace -fbounds-check -fimplicit-none -pedantic
# GNU gfortran compiler (version 4.4.3 or later)
#F90FLAGS = -ffree-line-length-none -fdefault-real-8 -O3 -fno-range-check

# Intel ifort compiler (comment out if gfortran used)
#F90FLAGS = -g -r8 -IPF_fp_relaxed -assume noold_maxminloc -O2 -march=core-avx2

###################################################


LDFLAGS = $(F90FLAGS) $(LLIB) -o $(PROG) $(FOBJ) $(INCL) $(LIBS)


.SUFFIXES: $(SUFFIXES)  .f90

.f90.o:
	$(F90) $(F90FLAGS) $(INCL) -c $<


all:  $(PROG)


# Include the dependency-list (created by makedepf90)
include dependencies

$(PROG): $(FOBJ)
	 $(F90) $(LDFLAGS)
#

clean: diskclean

diskclean:
	rm -f $(PROG) *.o *.mod

##########################################################
