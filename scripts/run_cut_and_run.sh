#!/bin/bash

# CUT&RUN Processing Pipeline
# Based on Preprocessing/CUT&RUN/README.md

set -e

# --- Configuration ---
# Update these paths
INPUT_DIR="data/raw"
OUTPUT_DIR="data/processed/cut_and_run"
GENOME_INDEX="path/to/bowtie2_index"
THREADS=8

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/fastqc"
mkdir -p "$OUTPUT_DIR/aligned"
mkdir -p "$OUTPUT_DIR/filtered"
mkdir -p "$OUTPUT_DIR/peaks"

# --- 1. Trimming and Quality Control ---
echo "Step 1: Trimming and Quality Control"
# trim_galore --fastqc --output_dir "$OUTPUT_DIR/fastqc" "$INPUT_DIR/sample_R1.fastq.gz" "$INPUT_DIR/sample_R2.fastq.gz"

# --- 2. Alignment (CUT&RUN specific parameters) ---
echo "Step 2: Alignment"
# bowtie2 -x "$GENOME_INDEX" -1 "$INPUT_DIR/sample_R1_val_1.fq.gz" -2 "$INPUT_DIR/sample_R2_val_2.fq.gz" 
#   --very-sensitive-local --no-unal --no-mixed --no-discordant -k 2 --phred33 -I 10 -X 700 
#   --dovetail -p "$THREADS" -S "$OUTPUT_DIR/aligned/sample.sam"

# --- 3. Filtering ---
echo "Step 3: Filtering"
# samtools view -bS "$OUTPUT_DIR/aligned/sample.sam" > "$OUTPUT_DIR/aligned/sample.bam"
# samtools sort "$OUTPUT_DIR/aligned/sample.bam" -o "$OUTPUT_DIR/aligned/sample.sorted.bam"
# samtools index "$OUTPUT_DIR/aligned/sample.sorted.bam"
# sambamba markdup -r -t "$THREADS" "$OUTPUT_DIR/aligned/sample.sorted.bam" "$OUTPUT_DIR/filtered/sample.dedup.bam"

# --- 4. Coverage ---
echo "Step 4: Coverage"
# bamCoverage -b "$OUTPUT_DIR/filtered/sample.dedup.bam" -o "$OUTPUT_DIR/coverage/sample.bw"

# --- 5 & 6. Peak Matrix and Background Matrix (R scripts needed) ---
echo "Steps 5 & 6: Peak Calling (Requires R scripts with csaw/GenomicRanges)"
# Rscript run_csaw.R "$OUTPUT_DIR/filtered/sample.dedup.bam" "$OUTPUT_DIR/peaks"

echo "CUT&RUN pipeline completed."
