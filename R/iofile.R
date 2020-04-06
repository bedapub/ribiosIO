getDataDir <- function() {
  return(options("ribiosIO")$ribiosIO$dataDir)
}

setDataDir <- function(path) {
  options("ribiosIO"=list(dataDir=path))
}

iofile <- function(x) {
  dataDir <- getDataDir()
  if(is.null(dataDir)) {
    if (file.exists("./data")) {
      message("DATA_DIR defined as ./data\n")
      setDataDir("./data")
    } else {
      stop("DATA_DIR not defined, or ./data does not exist. Call 'setDataDir' first.\n")
    }
  }
  if(missing(x)) {
    return(dataDir)
  } else {
    file.path(dataDir, x)
  }
}
