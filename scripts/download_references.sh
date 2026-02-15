#!/bin/bash

# scripts/download_references.sh
# Downloads standard hg38 reference files needed for the pipelines

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

REF_DIR="$BASE_DIR/data/references"
mkdir -p "$REF_DIR"

echo "Downloading hg38 reference files to $REF_DIR..."

# 1. Chromosome sizes
if [ ! -f "$REF_DIR/hg38.chrom.sizes" ]; then
    echo "Fetching hg38.chrom.sizes..."
    curl -L http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.chrom.sizes -o "$REF_DIR/hg38.chrom.sizes"
fi

# 2. ENCODE Blacklist
if [ ! -f "$REF_DIR/hg38-blacklist.v2.bed.gz" ]; then
    echo "Fetching hg38 blacklist..."
    curl -L https://github.com/Boyle-Lab/Blacklist/raw/master/lists/hg38-blacklist.v2.bed.gz -o "$REF_DIR/hg38-blacklist.v2.bed.gz"
fi

# 3. GENCODE Annotations (v44 is a good stable version for hg38)
if [ ! -f "$REF_DIR/gencode.v44.annotation.gtf.gz" ]; then
    echo "Fetching GENCODE v44 GTF..."
    curl -L https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_44/gencode.v44.annotation.gtf.gz -o "$REF_DIR/gencode.v44.annotation.gtf.gz"
fi

echo "Reference downloads complete."
echo "Note: You still need to build or download Bowtie2 and STAR indices manually as they are very large."
