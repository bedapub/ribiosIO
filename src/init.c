#include "ribios_io.h"

#define CALLMETHOD_DEF(fun, numArgs) {#fun, (DL_FUNC) &fun, numArgs} 

static const R_CallMethodDef callMethods[] = {
  CALLMETHOD_DEF(read_gct, 3),
  CALLMETHOD_DEF(read_gmt, 1),
  CALLMETHOD_DEF(write_gmt, 2),
  CALLMETHOD_DEF(read_chip, 1),
  CALLMETHOD_DEF(read_biokit_exprs, 1),

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

  /* C functions implemented in ribiosUtils to be exported*/
  // Required by ribiosArg
  // arg_init
  // arg_isInit
  // arg_getPos
  // arg_present
  // strReplace
  // usage
  R_RegisterCCallable("ribiosUtils", "arg_init", (DL_FUNC) &arg_init);
  R_RegisterCCallable("ribiosUtils", "arg_isInit", (DL_FUNC) &arg_isInit);
  R_RegisterCCallable("ribiosUtils", "arg_getPos", (DL_FUNC) &arg_getPos);
  R_RegisterCCallable("ribiosUtils", "arg_present", (DL_FUNC) &arg_present);
  R_RegisterCCallable("ribiosUtils", "strReplace", (DL_FUNC) &strReplace);
  R_RegisterCCallable("ribiosUtils", "usage", (DL_FUNC) &usage);
  R_RegisterCCallable("ribiosUtils", "hlr_callocs", (DL_FUNC) &hlr_callocs);

}
