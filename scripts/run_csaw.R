#!/usr/bin/env Rscript

# Simple csaw/GenomicRanges wrapper for CUT&RUN analysis

suppressPackageStartupMessages({
  library(csaw)
  library(GenomicRanges)
})

args <- commandArgs(trailingOnly=TRUE)

if (length(args) < 2) {
  stop("Usage: Rscript run_csaw.R <input_bam_dir> <output_dir>", call.=FALSE)
}

input_dir <- args[1]
output_dir <- args[2]

# Ensure output directory exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

print(paste("Running csaw analysis on:", input_dir))

# --- Skeleton for csaw analysis ---
# 1. Read BAM files
# 2. Count reads in windows
# 3. Filter and normalize
# 4. Detect differential binding

print("csaw template execution finished.")
