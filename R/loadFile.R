#' Attempt to load a binary RData file
#' 
#' The function attempts to load a binary file, returning \code{TRUE} if
#' succeeded. Otherwise it returns \code{FALSE}.
#' 
#' 
#' @param rDataFile Character, RData file name
#' @param env Environment, where should be the RData loaded into. By default it
#' is loaded into the global environment.
#' @return The function is used for its side effects.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{iofile}} can be used to find file from input data
#' directory.
#' @examples
#' 
#' \dontrun{
#' rf <- tempfile()
#' myData <- c(3,4,5)
#' save(myData, file=rf)
#' if(!loadFile(rf)) {
#' stop("Something went wrong\n")
#' }
#' }
#' 
#' @export loadFile
loadFile <- function (rDataFile, env = globalenv()) {
    if (file.exists(rDataFile)) {
        load(rDataFile, env)
        return(TRUE)
    }
    else {
        return(FALSE)
    }
}

#' Load an object by its name from a RData file
#' @param file A RData file
#' @param obj Object name. If set as \code{NULL}, all objects are returned
#' @param verbose Whether the loading process should be verbose, see \code{\link{load}}
#'
#' @export
loadObject <- function(file, obj=NULL, verbose=FALSE) {
  env <- new.env()
  load(file, env, verbose = verbose)
  if(is.null(obj))
     obj <- ls(envir=env)
  get(obj, env)
}

#' Load an object from a RDS file and returns a logical flag
#' 
#' @param rdsFile Character string, name of the rds file to be loaded
#' @param variableName Character string or variable name, variable name to which the loaded value is assigned to
#' @param refhook Logical, passed to \code{\link[base]{readRDS}}
#' 
#' @return Logical, \code{TRUE} if the file loading was successful, otherwise \code{FALSE}
#' @export
loadRDS <- function(rdsFile, variableName, refhook=NULL) {
  variableName <- as.character(substitute(variableName))
  if(file.exists(rdsFile)) {
    obj <- readRDS(rdsFile, refhook=refhook)
    assign(variableName, value=obj, envir=parent.frame())
    return(TRUE)
  } else {
    return(FALSE)
  }
}
