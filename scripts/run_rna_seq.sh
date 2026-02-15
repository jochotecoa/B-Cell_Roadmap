#!/bin/bash

# RNA-seq Processing Pipeline
# Based on Preprocessing/RNA-seq/README.md

set -e

# --- Configuration ---
# Update these paths
INPUT_DIR="data/raw"
OUTPUT_DIR="data/processed/rna_seq"
GENOME_INDEX="path/to/star_index"
GTF_FILE="path/to/genes.gtf"
THREADS=8

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/fastqc"
mkdir -p "$OUTPUT_DIR/aligned"
mkdir -p "$OUTPUT_DIR/counts"

# --- 1. Trimming and Quality Control ---
echo "Step 1: Trimming and Quality Control"
# trim_galore --fastqc --output_dir "$OUTPUT_DIR/fastqc" "$INPUT_DIR/sample_R1.fastq.gz" "$INPUT_DIR/sample_R2.fastq.gz"

# --- 2. Alignment (STAR) ---
echo "Step 2: Alignment with STAR"
# STAR --runThreadN "$THREADS" --genomeDir "$GENOME_INDEX" --readFilesIn "$INPUT_DIR/sample_R1.fastq.gz" "$INPUT_DIR/sample_R2.fastq.gz" --readFilesCommand zcat --outFileNamePrefix "$OUTPUT_DIR/aligned/" --outSAMtype BAM SortedByCoordinate

# --- 3. Counting (featureCounts) ---
echo "Step 3: Counting with featureCounts"
# featureCounts -T "$THREADS" -p -t exon -g gene_id -a "$GTF_FILE" -o "$OUTPUT_DIR/counts/counts.txt" "$OUTPUT_DIR/aligned/Aligned.sortedByCoord.out.bam"

# --- 4. Differential Analysis (DESeq2 - R package) ---
echo "Step 4: Differential Analysis (Requires R script)"
# Rscript run_deseq2.R "$OUTPUT_DIR/counts/counts.txt" "$OUTPUT_DIR/differential_expression"

echo "RNA-seq pipeline completed."
