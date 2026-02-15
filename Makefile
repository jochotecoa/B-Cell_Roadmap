# Makefile for B-Cell Roadmap Reproducibility

.PHONY: all setup references atac_seq cut_and_run lichi_c rna_seq clean

all: setup references atac_seq cut_and_run lichi_c rna_seq

setup:
	@echo "Checking conda environment..."
	conda env create -f environment.yml || conda env update -f environment.yml

references:
	@echo "Downloading reference data..."
	bash scripts/download_references.sh

atac_seq:
	@echo "Running ATAC-seq pipeline..."
	bash scripts/run_atac_seq.sh

cut_and_run:
	@echo "Running CUT&RUN pipeline..."
	bash scripts/run_cut_and_run.sh

lichi_c:
	@echo "Running liCHi-C pipeline..."
	bash scripts/run_lichi_c.sh

rna_seq:
	@echo "Running RNA-seq pipeline..."
	bash scripts/run_rna_seq.sh

clean:
	@echo "Cleaning up processed data..."
	rm -rf data/processed/*
