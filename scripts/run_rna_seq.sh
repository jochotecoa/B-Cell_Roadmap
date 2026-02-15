#!/bin/bash

# RNA-seq Processing Pipeline
# Based on Preprocessing/RNA-seq/README.md

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

OUTPUT_DIR="$OUTPUT_BASE/rna_seq"

# Ensure output directory structure exists
mkdir -p "$OUTPUT_DIR"/{fastqc,aligned,counts}

echo "Starting RNA-seq pipeline..."

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

    # --- 2. Alignment (STAR) ---
    echo "  Step 2: Alignment with STAR"
    # STAR --runThreadN "$THREADS" --genomeDir "$STAR_INDEX" --readFilesIn "$R1" "$R2" --readFilesCommand zcat --outFileNamePrefix "$OUTPUT_DIR/aligned/${sample}_" --outSAMtype BAM SortedByCoordinate

    # --- 3. Counting (featureCounts) ---
    echo "  Step 3: Counting with featureCounts"
    # featureCounts -T "$THREADS" -p -t exon -g gene_id -a "$GTF_FILE" -o "$OUTPUT_DIR/counts/${sample}_counts.txt" "$OUTPUT_DIR/aligned/${sample}_Aligned.sortedByCoord.out.bam"

done

# --- 4. Differential Analysis (DESeq2 - R package) ---
echo "Step 4: Differential Analysis (Requires R script)"
# Rscript scripts/run_deseq2.R "$OUTPUT_DIR/counts" "$OUTPUT_DIR/differential_expression"

echo "RNA-seq pipeline completed."
