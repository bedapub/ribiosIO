#ifndef RIBIOS_IO_H
#define RIBIOS_IO_H

#ifdef __cplusplus
extern "C" {
#endif

#include <Rinternals.h>
#include <R.h>
#include <R_ext/Rdynload.h>  

// public functions
SEXP read_gct (SEXP filename, SEXP pchr, SEXP keepdesc);
SEXP read_gmt (SEXP filename);
SEXP write_gmt (SEXP list, SEXP filename);
SEXP read_chip (SEXP filename);
SEXP read_biokit_exprs (SEXP filename);

// common macros
#define max(a,b) (((a)>(b))?(a):(b))

#ifdef __cplusplus
}
#endif

#endif
