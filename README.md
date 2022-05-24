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
