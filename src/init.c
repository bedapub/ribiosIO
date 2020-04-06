#include "ribios_io.h"

#define CALLMETHOD_DEF(fun, numArgs) {#fun, (DL_FUNC) &fun, numArgs} 

static const R_CallMethodDef callMethods[] = {
  CALLMETHOD_DEF(c_read_gct, 3),
  CALLMETHOD_DEF(c_read_gmt, 1),
  CALLMETHOD_DEF(c_write_gmt, 2),
  CALLMETHOD_DEF(c_read_chip, 1),
  CALLMETHOD_DEF(c_c_read_biokit_exprs, 1),

  {NULL, NULL, 0}
};

void R_init_ribiosIO(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(info, FALSE);
  R_forceSymbols(info, TRUE);
}
