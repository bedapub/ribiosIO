*ribiosIO*: File input/output module of the ribios suite
===

![R-CMD-check badge](https://github.com/bedapub/ribiosIO/workflows/R-CMD-check/badge.svg)

## What is *ribiosIO*?

*ribiosIO* is a R package that file input/output operations with high performance and low latency.


## Installation

`ribiosIO` depends on the `ribiosUtils` package, which should be installed first.

Run following commands in the R console.

```{R}
library(devtools)
devtools::install_github("bedapub/ribiosIO")
```

## Todo

1. Now the source files (`.h` and `.c`) are copied from `ribiosUtils` version 1.5-9, because to export all functions from `ribiosUtils` can be laborious.
    1. Solution 1: we export functions little by little
    2. Solution 2: we stay with the redundancy
    3. Solution 3: we move the C-level function to ribiosUtils, and import these functions (likely the easiest option to implement).
