#!/usr/bin/env Rscript

# Simple Chicago wrapper for liCHi-C analysis

suppressPackageStartupMessages({
  library(Chicago)
})

args <- commandArgs(trailingOnly=TRUE)

if (length(args) < 2) {
  stop("Usage: Rscript run_chicago.R <hicup_output_dir> <output_dir>", call.=FALSE)
}

input_dir <- args[1]
output_dir <- args[2]

# Ensure output directory exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

print(paste("Running Chicago analysis on:", input_dir))

# --- Skeleton for Chicago analysis ---
# 1. Prepare Chicago data (makeChicagoData)
# 2. Run Chicago pipeline (chicagoPipeline)
# 3. Export significant interactions

print("Chicago template execution finished.")
