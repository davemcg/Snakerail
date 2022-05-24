#!/bin/bash

mkdir -p 00log

sbcmd="sbatch --cpus-per-task={threads} \
--mem={cluster.mem} \
--time={cluster.time} \
--partition={cluster.partition} \
--output={cluster.output} \
--error={cluster.error} \
{cluster.extra}"

snakemake -s /home/mcgaugheyd/git/monorail-external/Snakerail \
  -pr --local-cores 2 --jobs 500 \
  --cluster-config /home/mcgaugheyd/git/monorail-external/cluster.json \
  --cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
  --configfile $1 \
  -k --restart-times 0 \
  --resources parallel=6 
