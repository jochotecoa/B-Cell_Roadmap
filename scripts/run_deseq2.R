#!/usr/bin/env Rscript

# Simple DESeq2 wrapper for B-Cell Roadmap project

suppressPackageStartupMessages({
  library(DESeq2)
  library(optparse)
})

option_list <- list(
  make_option(c("-i", "--input"), type="character", default=NULL, help="Path to counts directory", metavar="character"),
  make_option(c("-o", "--output"), type="character", default=NULL, help="Output directory", metavar="character")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if (is.null(opt$input) || is.null(opt$output)){
  print_help(opt_parser)
  stop("Input and Output paths must be provided", call.=FALSE)
}

# Ensure output directory exists
if (!dir.exists(opt$output)) {
  dir.create(opt$output, recursive = TRUE)
}

print(paste("Running DESeq2 on:", opt$input))
print(paste("Saving results to:", opt$output))

# --- Skeleton for DESeq2 analysis ---
# 1. Load data
# counts_files <- list.files(opt$input, pattern="*.txt", full.names=TRUE)
# 2. Build dds object
# 3. Run DESeq()
# 4. Save results

print("DESeq2 template execution finished.")
