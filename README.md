# Three-Dimensional Epigenome Roadmap of Human B-cell Differentiation

This repository provides the computational framework to reproduce the epigenomic landscape analysis of human B-cell differentiation, as described in de Haro-Blázquez et al. (2025).

## Table of Contents
1. [Project Overview](#project-overview)
2. [Directory Structure](#directory-structure)
3. [Getting Started](#getting-started)
4. [Configuration](#configuration)
5. [Pipeline Details](#pipeline-details)
6. [Reproducibility](#reproducibility)
7. [Reference](#reference)

---

## Project Overview
This study integrates multiple high-throughput sequencing technologies to map the 3D chromatin organization and epigenetic state across human B-cell differentiation. This repository handles the preprocessing of:
- **ATAC-seq**: Chromatin accessibility mapping.
- **CUT&RUN**: Histone modification and TF binding localization.
- **RNA-seq**: Transcriptional profiling.
- **liCHi-C**: High-resolution promoter-enhancer interaction mapping.

## Directory Structure
```text
.
├── data/
│   ├── raw/                # Place raw FASTQ files here (*_R1.fastq.gz)
│   ├── metadata.csv        # Sample-to-condition mapping
│   ├── references/         # Downloaded genome annotations and sizes
│   └── processed/          # Generated pipeline outputs (BAM, BW, counts)
├── Preprocessing/          # Detailed methodology for each sequencing type
├── scripts/                # Executable bash pipelines and R analysis templates
├── environment.yml         # Pinned conda environment dependencies
├── Makefile                # Master workflow orchestrator
└── README.md
```

## Getting Started

### 1. Environment Setup
We use Conda to manage all bioinformatics dependencies (Bowtie2, STAR, SAMtools, R/Bioconductor, etc.).
```bash
conda env create -f environment.yml
conda activate b-cell-roadmap
```

### 2. Download Core References
Fetch standard hg38 chromosome sizes, blacklists, and gene annotations:
```bash
make references
```

## Configuration
Before running the pipelines, you **must** update the global configuration in `scripts/config.sh`.
- Set `THREADS` based on your hardware.
- Provide paths to your local `BOWTIE2_INDEX` and `STAR_INDEX`.
- Ensure `GTF_FILE` points to the annotation downloaded in the previous step.

## Pipeline Details

All pipelines support **Automated Sample Discovery**. Simply place your paired-end FASTQ files in `data/raw/` following the naming convention `SampleName_R1.fastq.gz` and `SampleName_R2.fastq.gz`.

### RNA-seq (`make rna_seq`)
- **Trimming**: Trim Galore removes adapters.
- **Alignment**: STAR maps reads to the genome.
- **Quantification**: featureCounts generates gene-level count matrices.
- **Analysis**: `scripts/run_deseq2.R` handles differential expression.

### ATAC-seq (`make atac_seq`)
- **Alignment**: Bowtie2 mapping.
- **Filtering**: Removal of duplicates (sambamba) and mitochondrial reads.
- **Peak Calling**: MACS3 HMMRATAC identifies accessible regions.

### CUT&RUN (`make cut_and_run`)
- **Alignment**: Bowtie2 with `--dovetail` for short fragment retention.
- **Analysis**: `scripts/run_csaw.R` performs window-based binding analysis.

### liCHi-C (`make lichi_c`)
- **Processing**: HiCUP handles mapping and artifact filtering.
- **Interactions**: CHiCAGO (`scripts/run_chicago.R`) identifies significant 3D loops.

## Reproducibility
To ensure exact reproduction of the paper's results:
1. Use the specific versions pinned in `environment.yml`.
2. Map your samples in `data/metadata.csv` to match the experimental design.
3. Use the `Makefile` to ensure steps are executed in the correct dependency order.

## Reference
de Haro-Blázquez R., Tomás-Daza L., Fanlo-Escudero L. *et al.*
**Three-Dimensional Epigenome Roadmap of Human B-cell Differentiation Uncovers Mechanisms of Humoral Immunity and Oncogenesis.**
bioRxiv (2025). [doi:10.64898/2025.12.22.695871](https://www.biorxiv.org/content/10.64898/2025.12.22.695871v1)
