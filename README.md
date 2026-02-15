# Three-Dimensional Epigenome Roadmap of Human B-cell Differentiation Uncovers Mechanisms of Humoral Immunity and Oncogenesis

This repository contains the necessary data and scripts to reproduce the main analysis of the manuscript.

The data (fastq and bams) needed to execute the preprocessing steps are available upon request at [EGA](https://ega-archive.org/) under the accession [EGSXXXXXXXXX]().

The processed data (bigwigs, bed, counts...) used in all the downstream analysis are publicly available at [GEO](https://www.ncbi.nlm.nih.gov/geo/) under the accession [GSEXXXXXXX]().

## Getting Started

To reproduce the analysis, we recommend setting up the Conda environment using the provided `environment.yml` file.

### Prerequisites

* [Conda](https://docs.conda.io/en/latest/) (Anaconda or Miniconda)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/JavierreLab/B-Cell_Roadmap.git
   cd B-Cell_Roadmap
   ```

2. Create the environment:
   ```bash
   conda env create -f environment.yml
   ```

3. Activate the environment:
   ```bash
   conda activate b-cell-roadmap
   ```

## Workflow Orchestration

To simplify reproduction, a `Makefile` is provided. You can run individual steps or the entire pipeline:

```bash
# Setup environment and download standard references
make setup
make references

# Run specific pipelines
make atac_seq
make rna_seq
```

### Sample Metadata
A template for sample metadata is available at `data/metadata.csv`. Update this file to map your local files to experimental conditions.

## Workflow Scripts

Executable scripts for each preprocessing workflow are available in the `scripts/` directory:

* `scripts/run_atac_seq.sh`: ATAC-seq processing.
* `scripts/run_cut_and_run.sh`: CUT&RUN processing.
* `scripts/run_lichi_c.sh`: liCHi-C processing.
* `scripts/run_rna_seq.sh`: RNA-seq processing.

Please refer to the `Preprocessing/` directory for detailed documentation on each workflow.

## Reference

de Haro-Blázquez R., Tomás-Daza L., Fanlo-Escudero L. _et al._ <br/>
Three-Dimensional Epigenome Roadmap of Human B-cell Differentiation Uncovers Mechanisms of Humoral Immunity and Oncogenesis. <br/>
bioRxiv (2025). [doi:10.64898/2025.12.22.695871](https://www.biorxiv.org/content/10.64898/2025.12.22.695871v1)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.
