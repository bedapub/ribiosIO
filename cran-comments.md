## Test environments

* Local: Linux Mint 21.2 (x86_64), R 4.5.2
* GitHub Actions:
  - Windows (R release)
  - macOS (R release, R devel)
  - Ubuntu (R release, R oldrel)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Notes for CRAN reviewers

This package provides data structures and functions for file input/output
in computational biology, developed at F. Hoffmann-La Roche AG.

Key functionality includes:
- Reading/writing GCT (Gene Cluster Text) files
- Reading/writing GMT (Gene Matrix Transposed) files
- Reading CLS, CHIP, BED, and FASTA files

The package includes C code for high-performance file parsing. The C source
code is derived from the Bioinfo-C (BIOS) library.

The package depends on ribiosUtils (on CRAN).
