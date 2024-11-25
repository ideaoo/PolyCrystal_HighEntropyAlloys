#!/bin/bash
#SBATCH -A MST110445         # Account name/project number
#SBATCH -J tensile_hea       # Job name
#SBATCH -p ct2k              # Partiotion name
#SBATCH -n 1120              # Number of MPI tasks (i.e. processes)
#SBATCH -c 1                 # Number of cores per MPI task
#SBATCH -N 20                # Maximum number of nodes to be allocated
#SBATCH -o %x-%j.out         # Path to the standard output file
#SBATCH -e %j.err            # Path to the standard error ouput file

JOB=in.hea_tensile


module purge
module load compiler/intel/2021 IntelMPI/2021 hdf5/1.12 netcdf/4.7.4 adios2/2.7.1

export I_MPI_FABRICS=shm:ofi
export UCX_TLS=rc,ud,sm,self
###export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so
unset  I_MPI_PMI_LIBRARY 
###export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0
export I_MPI_DEBUG=10
export I_MPI_HYDRA_BOOTSTRAP=slurm
### set cpu binding
export I_MPI_PIN=1

echo "Your LAMMPS job starts at `date`"

echo "Start time:" `date` 2>&1 > time.log
t1=`date +%s`

mpiexec.hydra /opt/ohpc/pkg/lammps/patch_10Mar2021-137-g73b9f22/lmp_intel_cpu_intelmpi -sf opt -nocite  -in ./$JOB -log $JOB.out

t2=`date +%s`
echo "Finish time:" `date` 2>&1 >> time.log
echo "Total runtime:" $[$t2-$t1] "seconds" 2>&1 >> time.log

echo "Your LAMMPS job completed at  `date` "  
