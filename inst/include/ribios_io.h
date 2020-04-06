#ifndef RIBIOS_IO_H
#define RIBIOS_IO_H

#ifdef __cplusplus
extern "C" {
#endif

#include <Rinternals.h>
#include <R.h>
#include <R_ext/Rdynload.h>  

#include "bios_headers/array.h"
#include "bios_headers/format.h"
#include "bios_headers/hlrmisc.h"
#include "bios_headers/linestream.h"
#include "bios_headers/log.h"
#include "bios_headers/plabla.h"

// public functions
SEXP c_read_gct (SEXP filename, SEXP pchr, SEXP keepdesc);
SEXP c_read_gmt (SEXP filename);
SEXP c_write_gmt (SEXP list, SEXP filename);
SEXP c_read_chip (SEXP filename);
SEXP c_read_biokit_exprs (SEXP filename);

// common macros
#define max(a,b) (((a)>(b))?(a):(b))

#ifdef __cplusplus
}
#endif

#endif
