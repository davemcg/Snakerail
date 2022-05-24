# Snakerail

Snakemake wrapper for [monorail](https://github.com/langmead-lab/monorail-external).

How to use:

1. Remove all `module load singularity` lines unless your HPC also uses a module system
2. `git clone` [monorail](https://github.com/langmead-lab/monorail-external)
3. Install reference info and images using monorail scripts:
  - `cd /path/to/ref/folder`
  - `bash ~/path/monorail-external/get_unify_refs.sh`
  - `bash ~/path/monorail-external/get_human_ref_indexes.sh`
  - `singularity pull docker://quay.io/broadsword/recount-unify:1.1.0`
  - `singularity pull docker://quay.io/benlangmead/recount-rs5:1.0.6`
4. Copy and edit the [yaml](https://github.com/davemcg/Snakerail/blob/main/snakerail_config.yaml) to your working dir
5. Run (**SPECIFIC TO NIH HPC**) `bash /path/to/repo/Snakerail/Snakerail/Snakerail.wrapper.sh snakerail_config.yaml`
  - a bit more genericly, you could run something like `snakemake -s /path/to/this/repo/Snakerail --configfile snakerail_config.yaml`


# Uh, doesn't monorail use Snakemake?

Yes, but the `pump` and `unify` steps are (at least for me) a bit fiddly to keep track of the individual steps. So this wraps the whole thing in one Snakefile. Essentially you start with a metadata tsv (first col is study and second col is fastq prefix) and your fastq files. It runs `pump`, then moves them all into a folder for `unify` and after `unify` finishes, it munges the unify output into a [RSE](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) for use in [recount3](https://bioconductor.org/packages/release/bioc/html/recount3.html)
