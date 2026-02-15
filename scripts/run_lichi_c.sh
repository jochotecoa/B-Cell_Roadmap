#!/bin/bash

# liCHi-C Processing Pipeline
# Based on Preprocessing/liCHi-C/README.md

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

OUTPUT_DIR="$OUTPUT_BASE/lichi_c"

# Ensure output directory structure exists
mkdir -p "$OUTPUT_DIR"/{hicup,chicago}

echo "Starting liCHi-C pipeline..."

# Automated Sample Discovery
samples=$(ls "$INPUT_DIR"/*_R1.fastq.gz 2>/dev/null | xargs -n 1 basename | sed 's/_R1.fastq.gz//')

if [ -z "$samples" ]; then
    echo "No samples found in $INPUT_DIR matching *_R1.fastq.gz"
    exit 0
fi

for sample in $samples; do
    echo "Processing sample: $sample"
    
    # --- 1. Mapping and Filtering (HiCUP) ---
    echo "  Step 1: Mapping and Filtering with HiCUP"
    # hicup --config "$HICUP_CONFIG" --outdir "$OUTPUT_DIR/hicup" --threads "$THREADS"

    # --- 2. Capture Efficiency ---
    echo "  Step 2: Capture Efficiency"
    # hicup_capture_efficiency --outdir "$OUTPUT_DIR/hicup" --threads "$THREADS"

done

# --- 3. Interaction Calling (Chicago - R package) ---
echo "Step 3: Interaction Calling with Chicago (Requires R script)"
# Rscript scripts/run_chicago.R "$OUTPUT_DIR/hicup" "$OUTPUT_DIR/chicago"

echo "liCHi-C pipeline completed."
