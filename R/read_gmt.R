read_gmt_list <- function(gmt.file) {
  gmt.file <- checkfile(gmt.file)
  ll <- .Call(C_read_gmt, gmt.file)
  return(ll)
}
