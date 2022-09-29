# Snakerail

Snakemake wrapper for [monorail](https://github.com/langmead-lab/monorail-external).

How to use:

1. Remove all `module load singularity` lines from [Snakerail](https://github.com/davemcg/Snakerail/blob/main/Snakerail) unless your HPC also uses a module system
  - Then install singularity with conda
2. `git clone https://github.com/davemcg/Snakerail.git`
2. `git clone https://github.com/langmead-lab/monorail-external`
3. Install reference info and images using monorail scripts:
  - `cd /path/to/ref/folder`
  - `bash ~/path/monorail-external/get_unify_refs.sh`
  - `bash ~/path/monorail-external/get_human_ref_indexes.sh`
  - `singularity pull docker://quay.io/broadsword/recount-unify:1.1.0`
  - `singularity pull docker://quay.io/benlangmead/recount-rs5:1.0.6`
4. ONLY IF YOU HAVE SINGLE END FILES: copy the `run_recount_pump_single.sh` in `src` of this repo to the `singularity` folder in wherever you cloned the monorail repo. For example: `cp ~/path/to/Snakerail/src/run_recount_pump_single.sh ~/path/monorail-external/singularity/`
5. Copy and edit the [yaml](https://github.com/davemcg/Snakerail/blob/main/snakerail_config.yaml) to your working dir
6. Create file metadata file in tsv format (used in [yaml](https://github.com/davemcg/Snakerail/blob/main/snakerail_config.yaml) as `study_fq`). Example [here](https://github.com/davemcg/Snakerail/blob/main/study_fq.tsv)
7. Run (**SPECIFIC TO NIH HPC**) `bash /path/to/repo/Snakerail/Snakerail/Snakerail.wrapper.sh snakerail_config.yaml`
  - a bit more generically, you could run something like `snakemake -s /path/to/this/repo/Snakerail --configfile snakerail_config.yaml`


# Uh, doesn't monorail use Snakemake?

Yes, but the `pump` and `unify` steps are (at least for me) a bit fiddly to keep track of the individual steps. So this wraps the whole thing in one Snakefile. Essentially you start with a metadata tsv (first col is study, second col is fastq prefix, and third col is `single` or `paired` to denote how the sequencing was done) and your fastq files in a folder. It runs `pump`, then moves them all into a folder for `unify`. After `unify` finishes, it munges the unify output into a [RSE](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) for direct use in [recount3](https://bioconductor.org/packages/release/bioc/html/recount3.html)

# Why doesn't David just remove all the `module` lines?

Because this is for my working use on NIH HPC, which uses a module system which I abuse instead of rolling my own containers or conda envs or something. If you do want to run this and are having trouble, let me know. I don't think it's much more effort to make more general. Again, I'm lazy and don't want to optimize further if only I am using it. 

# What is with that file in `src`?????

Monorail has a bug (?) where the script they provide to run it assumes, for a local run, that it is paired end. This script just tweaks it lightly to take out the second fq file and move up the study name by one
