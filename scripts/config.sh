#!/bin/bash

# --- Global Configuration ---
THREADS=8

# --- Paths ---
# Base directories
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INPUT_DIR="$BASE_DIR/data/raw"
OUTPUT_BASE="$BASE_DIR/data/processed"

# Reference Genomes (Update these with actual paths)
BOWTIE2_INDEX="/path/to/bowtie2_index/hg38"
STAR_INDEX="/path/to/star_index/hg38"
GTF_FILE="/path/to/annotation/genes.gtf"

# --- Tool Specific Config ---
# Add any specific flags here
TRIM_GALORE_FLAGS="--fastqc"
BOWTIE2_FLAGS="--dovetail" # Often used for CUT&RUN
MACS3_FLAGS=""

echo "Configuration loaded."
