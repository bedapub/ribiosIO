# ribiosIO 1.1.0

* Initial CRAN submission
* Package prepared for CRAN submission with comprehensive documentation
* Depends on ribiosUtils (on CRAN)

# ribiosIO 1.0.43 (2016-06-21)

* `loadObject` allows the obj option to take the value NULL

# ribiosIO 1.0.42 (2016-01-25)

* Improve read_gct.c by providing meaningful error messages when file is inconsistent

# ribiosIO 1.0.41 (2016-12-20)

* `read_rocheNGS_exprs` renamed to `read_biokit_exprs`
* `read_biokit_exprs` updated for new Biokit pipeline output files
* Add `read_trimmed_lines`
* Add `loadObject`

# ribiosIO 1.0.36 (2015-10-12)

* `read_rocheNGS_exprs`: skip the header line

# ribiosIO 1.0.35 (2015-06-10)

* `readMatrix` added option 'as.matrix'

# ribiosIO 1.0.34 (2015-03-11)

* Add parameter to control NA format in `write_gct`

# ribiosIO 1.0.32 (2014-10-31)

* Start using roxygen2
* Add `writeMatrix` and `readMatrix` for numerical matrix I/O

# ribiosIO 1.0.31 (2014-05-08)

* `writeList` renamed to `write.tableList`
* C-level functions renamed to avoid confusion with R function names

# ribiosIO 1.0.30 (2014-05-07)

* Add `writeList` function to write a series of tables

# ribiosIO 1.0.28 (2013-12-02)

* `read_gmt_list` uses gene-set names as names of the returning list

# ribiosIO 1.0.27 (2013-11-14)

* `write_gmt` supports simple lists as input

# ribiosIO 1.0.26 (2013-05-31)

* `read_gct_matrix` prints detailed error messages for column mismatches

# ribiosIO 1.0.25 (2013-02-28)

* Add function `read_pheno` to import pheno data information

# ribiosIO 1.0.24 (2013-02-26)

* Bug fix: `read_gmt_list` supports gene sets without any genes

# ribiosIO 1.0.23 (2013-02-22)

* Bug fixes for `read_exprs_matrix`
* `read_exprs_matrix` reads in description of gct files

# ribiosIO 1.0.22 (2013-02-21)

* `write_gct` handles 0-row matrix

# ribiosIO 1.0.21 (2013-02-20)

* `read_exprs_matrix` handles non-numeric second column

# ribiosIO 1.0.20 (2012-11-19)

* Add new function `read_chip` to read chip files

# ribiosIO 1.0.19 (2012-11-01)

* Add new function `write_gmt_list` to export GMT lists

# ribiosIO 1.0.18 (2012-10-24)

* Add `read_cls` for reading CLS files

# ribiosIO 1.0.17 (2012-10-22)

* `write_gct` uses the 'desc' attribute of input matrix if available

# ribiosIO 1.0.16 (2012-07-12)

* `read_exprs_matrix` uses more stringent grep to detect GCT files

# ribiosIO 1.0.15 (2012-07-10)

* Add `write_gct` function to export Matrix in GCT format
* `read_exprs_matrix` does not interpret hashes as comment char

# ribiosIO 1.0.14 (2012-07-04)

* read_gct C file: second line less strict, allowing empty cells

# ribiosIO 1.0.13 (2012-06-21)

* `isGctFile` is less strict regarding spaces

# ribiosIO 1.0.12 (2012-06-12)

* Add `isGctFile` function to determine GCT file format compliance

# ribiosIO 1.0.11 (2012-06-07)

* Documentation improvements for `read_gmt_list`

# ribiosIO 1.0.10 (2012-05-07)

* Cleanup src/Makevar: remove hard-coded dependencies

# ribiosIO 1.0.9 (2012-04-10)

* Add `read_fasta` and `write_fasta` for FASTA-format sequence files

# ribiosIO 1.0.8 (2012-02-22)

* C-function `read_gct` supports both file and character string input
* Add `read_gctstr_matrix` for parsing GCT format strings

# ribiosIO 1.0.7 (2012-01-09)

* Add `loadFile` from the ribios package

# ribiosIO 1.0.6 (2011-12-08)

* Package cleanup and benchmarking

# ribiosIO 1.0.5 (2011-12-08)

* Add man pages for `read_gmt_list` and `iofile`

# ribiosIO 1.0.4 (2011-12-07)

* Add `read_gmt_list` function to read GMT files

# ribiosIO 1.0.3 (2011-11-18)

* Add correct version of `iofile`

# ribiosIO 1.0.2 (2011-11-17)

* `read_exprs_matrix` supports full table and duplicated row names

# ribiosIO 1.0.1 (2011-11-16)

* Add `read_exprs_matrix` for importing expression matrix from file
* C routine `read_gct` checks second line with arrayMax

# ribiosIO 1.0.0 (2011-11-15)

* Initial release: refactor `read_gct` from ribiosExpression
