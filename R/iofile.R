#' Get the data directory
#' @return A directory
#' The value stored in options is returned
#' @export
getDataDir <- function() {
  return(options("ribiosIO")$ribiosIO$dataDir)
}

#' Set the data directory
#' @param path Path to the data directory
#' @return \code{NULL}
#' The value is set in the options
#' @export
setDataDir <- function(path) {
  options("ribiosIO"=list(dataDir=path))
  return(invisible(NULL))
}

#' Get file names for data import/export
#' 
#' @param x File or directory name
#'
#' Quite often we need to import and export data (especially bulky files)
#' into a directory other than the local file. This function is a
#' shortcut to get full names of import/export files.
#' 
#' The function first determines whether the option \code{dataDir}
#' in the options of \code{ribiosIO} exists. If yes, its value will be
#' used as the directory from/to which input/export files should be
#' read/written.
#'
#' If the value does not exist yet, the function
#' tries to use a folder named \code{data} in the current working
#' directory as \code{dataDir}. If this local folder exists, its name
#' will be assigned to the \code{dataDir} option. If
#' the folder does not exist, the function will report an error and quit.
#'
#' The steps above guarantees that there is an option named \code{dataDir},
#' pointing to a directory where files are read from or
#' written to.
#'
#' The parameter \code{x} can be file or directory names in the
#' \code{dataDir} directory. In this case, \code{iofile(x)} returns
#' their full names. When \code{x} is missing or \code{NULL}, \code{iofile()}
#' returns the value of \code{dataDir}. A common usage for the later case is 
#' \code{dir(iofile())}.
#'
#' @return Character string, the full path to the data directory (when \code{x}
#' is \code{NULL}) or the full file path(s) within the data directory.
#' @examples
#' setDataDir(system.file("extdata", package="ribiosIO"))
#' dir(iofile())
#' readLines(iofile("test.gct"), n=2)
#' @export
iofile <- function(x=NULL) {
  dataDir <- getDataDir()
  if(is.null(dataDir)) {
    if (file.exists("./data")) {
      message("DATA_DIR defined as ./data\n")
      setDataDir("./data")
    } else {
      stop("DATA_DIR not defined, or ./data does not exist. Call 'setDataDir' first.\n")
    }
  }
  if(missing(x) || is.null(x)) {
    return(dataDir)
  } else {
    file.path(dataDir, x)
  }
}
