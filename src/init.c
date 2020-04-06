#include "ribios_io.h"
#include <R_ext/Rdynload.h>

#define CALLMETHOD_DEF(fun, numArgs) {#fun, (DL_FUNC) &(fun), (numArgs)}

static const R_CallMethodDef callMethods[] = {
  CALLMETHOD_DEF(c_read_gct, 3),
  CALLMETHOD_DEF(c_read_gmt, 1),
  CALLMETHOD_DEF(c_write_gmt, 2),
  CALLMETHOD_DEF(c_read_chip, 1),
  CALLMETHOD_DEF(c_read_biokit_exprs, 1),
  {NULL, NULL, 0}
};

void R_init_ribiosIO(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  /* the line below says that the DLL is not to be searched
   * for entry points specified by character strings so
   * .C etc calls will only find registered symbols
   */  
  R_useDynamicSymbols(info, FALSE); 
  /* R_forceSymbols call only allows .C etc calls which 
   * specify entry points by R objects such as C_routineName
   * (and not by character strings)
   */ 
  R_forceSymbols(info, TRUE);

}
