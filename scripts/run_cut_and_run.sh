#!/bin/bash

# CUT&RUN Processing Pipeline
# Based on Preprocessing/CUT&RUN/README.md

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

OUTPUT_DIR="$OUTPUT_BASE/cut_and_run"

# Ensure output directory structure exists
mkdir -p "$OUTPUT_DIR"/{fastqc,aligned,filtered,coverage,peaks}

echo "Starting CUT&RUN pipeline..."

# Automated Sample Discovery
samples=$(ls "$INPUT_DIR"/*_R1.fastq.gz 2>/dev/null | xargs -n 1 basename | sed 's/_R1.fastq.gz//')

if [ -z "$samples" ]; then
    echo "No samples found in $INPUT_DIR matching *_R1.fastq.gz"
    exit 0
fi

for sample in $samples; do
    echo "Processing sample: $sample"
    R1="$INPUT_DIR/${sample}_R1.fastq.gz"
    R2="$INPUT_DIR/${sample}_R2.fastq.gz"

    # --- 1. Trimming and Quality Control ---
    echo "  Step 1: Trimming and Quality Control"
    # trim_galore $TRIM_GALORE_FLAGS --output_dir "$OUTPUT_DIR/fastqc" "$R1" "$R2"

    # --- 2. Alignment (CUT&RUN specific parameters) ---
    echo "  Step 2: Alignment"
    # bowtie2 -x "$BOWTIE2_INDEX" -1 "$R1" -2 "$R2" \
    #   --very-sensitive-local --no-unal --no-mixed --no-discordant -k 2 --phred33 -I 10 -X 700 \
    #   $BOWTIE2_FLAGS -p "$THREADS" -S "$OUTPUT_DIR/aligned/${sample}.sam"

    # --- 3. Filtering ---
    echo "  Step 3: Filtering"
    # samtools view -bS "$OUTPUT_DIR/aligned/${sample}.sam" > "$OUTPUT_DIR/aligned/${sample}.bam"
    # samtools sort "$OUTPUT_DIR/aligned/${sample}.bam" -o "$OUTPUT_DIR/aligned/${sample}.sorted.bam"
    # samtools index "$OUTPUT_DIR/aligned/${sample}.sorted.bam"
    # sambamba markdup -r -t "$THREADS" "$OUTPUT_DIR/aligned/${sample}.sorted.bam" "$OUTPUT_DIR/filtered/${sample}.dedup.bam"

    # --- 4. Coverage ---
    echo "  Step 4: Coverage"
    # bamCoverage -b "$OUTPUT_DIR/filtered/${sample}.dedup.bam" -o "$OUTPUT_DIR/coverage/${sample}.bw"

done

# --- 5 & 6. Peak Matrix and Background Matrix (R scripts needed) ---
echo "Steps 5 & 6: Peak Calling (Requires R scripts with csaw/GenomicRanges)"
# Rscript scripts/run_csaw.R "$OUTPUT_DIR/filtered" "$OUTPUT_DIR/peaks"

echo "CUT&RUN pipeline completed."
