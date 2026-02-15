#!/bin/bash

# liCHi-C Processing Pipeline
# Based on Preprocessing/liCHi-C/README.md

set -e

# --- Configuration ---
# Update these paths
INPUT_DIR="data/raw"
OUTPUT_DIR="data/processed/lichi_c"
GENOME_INDEX="path/to/bowtie2_index"
HICUP_CONFIG="path/to/hicup.conf"
THREADS=8

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/hicup"
mkdir -p "$OUTPUT_DIR/chicago"

# --- 1. Mapping and Filtering (HiCUP) ---
echo "Step 1: Mapping and Filtering with HiCUP"
# hicup --config "$HICUP_CONFIG" --outdir "$OUTPUT_DIR/hicup" --threads "$THREADS"

# --- 2. Capture Efficiency ---
echo "Step 2: Capture Efficiency"
# hicup_capture_efficiency --outdir "$OUTPUT_DIR/hicup" --threads "$THREADS"

# --- 3. Interaction Calling (Chicago - R package) ---
echo "Step 3: Interaction Calling with Chicago (Requires R script)"
# Rscript run_chicago.R "$OUTPUT_DIR/hicup/sample_R1_2.hicup.bam" "$OUTPUT_DIR/chicago"

echo "liCHi-C pipeline completed."
