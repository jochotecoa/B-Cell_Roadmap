#!/bin/bash

# ATAC-seq Processing Pipeline
# Based on Preprocessing/ATAC-seq/README.md

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

OUTPUT_DIR="$OUTPUT_BASE/atac_seq"

# Ensure output directory structure exists
mkdir -p "$OUTPUT_DIR"/{fastqc,aligned,filtered,coverage,peaks}

echo "Starting ATAC-seq pipeline..."

# Automated Sample Discovery
# Assumes files in $INPUT_DIR are named SampleName_R1.fastq.gz and SampleName_R2.fastq.gz
samples=$(ls "$INPUT_DIR"/*_R1.fastq.gz 2>/dev/null | xargs -n 1 basename | sed 's/_R1.fastq.gz//')

if [ -z "$samples" ]; then
    echo "No samples found in $INPUT_DIR matching *_R1.fastq.gz"
    # Create structure even if no samples, for consistency
    exit 0
fi

for sample in $samples; do
    echo "Processing sample: $sample"
    R1="$INPUT_DIR/${sample}_R1.fastq.gz"
    R2="$INPUT_DIR/${sample}_R2.fastq.gz"

    # --- 1. Trimming and Quality Control ---
    echo "  Step 1: Trimming and Quality Control"
    # trim_galore $TRIM_GALORE_FLAGS --output_dir "$OUTPUT_DIR/fastqc" "$R1" "$R2"

    # --- 2. Alignment ---
    echo "  Step 2: Alignment"
    # bowtie2 -x "$BOWTIE2_INDEX" -1 "$OUTPUT_DIR/fastqc/${sample}_R1_val_1.fq.gz" -2 "$OUTPUT_DIR/fastqc/${sample}_R2_val_2.fq.gz" -S "$OUTPUT_DIR/aligned/${sample}.sam" -p "$THREADS"

    # --- 3. Filtering ---
    echo "  Step 3: Filtering"
    # samtools view -bS "$OUTPUT_DIR/aligned/${sample}.sam" > "$OUTPUT_DIR/aligned/${sample}.bam"
    # samtools sort "$OUTPUT_DIR/aligned/${sample}.bam" -o "$OUTPUT_DIR/aligned/${sample}.sorted.bam"
    # samtools index "$OUTPUT_DIR/aligned/${sample}.sorted.bam"
    # sambamba markdup -r -t "$THREADS" "$OUTPUT_DIR/aligned/${sample}.sorted.bam" "$OUTPUT_DIR/filtered/${sample}.dedup.bam"

    # --- 4. Coverage ---
    echo "  Step 4: Coverage"
    # bamCoverage -b "$OUTPUT_DIR/filtered/${sample}.dedup.bam" -o "$OUTPUT_DIR/coverage/${sample}.bw"

    # --- 5. Peak Calling (HMMRATAC) ---
    echo "  Step 5: Peak Calling"
    # macs3 hmmratac -i "$OUTPUT_DIR/filtered/${sample}.dedup.bam" -n "$sample" --outdir "$OUTPUT_DIR/peaks"

done

echo "ATAC-seq pipeline completed."
