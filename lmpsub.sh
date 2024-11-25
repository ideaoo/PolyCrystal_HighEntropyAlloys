#!/bin/bash
#PBS -l select=2:ncpus=40:mpiprocs=40:ompthreads=1
#PBS -N 700_big_cycle
#PBS -q ct160
#PBS -P MST109282
#PBS -j oe
#PBS -e 700_big_cycle.err
#PBS -o 700_big_cycle.stderr

JOB=fatigue_700.in

if [ -f ${JOB}.sub ]
then
    rm ${JOB}.sub
fi
if [ -f ${JOB}.stderr ]
then
    rm ${JOB}.stderr
fi
if [ -f ${JOB}.err ]
then
    rm ${JOB}.err
fi

cd $PBS_O_WORKDIR

module purge
module load intel/2018_u1
module load cuda/8.0.61

echo "Your LAMMPS job starts at `date`"

echo "Start time:" `date` 2>&1 > time.log
t1=`date +%s`

mpiexec.hydra -PSM2 /pkg/CMS/LAMMPS/lammps-16Mar18/bin/lmp_run_cpu -in ./${JOB} -log ${JOB}.out

t2=`date +%s`
echo "Finish time:" `date` 2>&1 >> time.log
echo "Total runtime:" $[$t2-$t1] "seconds" 2>&1 >> time.log

qstat -x -f ${PBS_JOBID} 2>&1 > job.log

echo "Your LAMMPS job completed at  `date` "
