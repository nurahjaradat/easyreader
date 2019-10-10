#------------------------------------------------------
# Import a dataset
#------------------------------------------------------
#' @title Import data into a data frame
#' @description Import data from Excel, text files, and
#' statistical packages.
#' @param file datafile to import
#' @param ... parameters passed to the importing function
#' @return data frame
#' @details The \code{import} function is a wrapper for functions in the
#' haven, readxl, and vroom packages.
#' @examples
#' \dontrun{
#' if(interactive()){
#'  mydataframe <- import("mydata.csv")
#'  }
#' }
#' @seealso
#'  \code{\link[tools]{fileutils}}
#'  \code{\link[haven]{read_sas}},\code{\link[haven]{read_dta}},\code{\link[haven]{read_spss}}
#'  \code{\link[readxl]{read_excel}}
#'  \code{\link[vroom]{vroom}}
#' @rdname import
#' @export
#' @importFrom tools file_ext
#' @importFrom haven read_sas read_stata read_spss
#' @importFrom readxl read_excel
#' @importFrom vroom vroom
import <- function(file, ...){

  # if no file specified, prompt user

  if(missing(file))
    file <- file.choose()


  # get file info

  file <- tolower(file)
  basename <- basename(file)
  extension <- tools::file_ext(file)


  # import dataset

  df <- switch(extension,
               "sas7bdat" = haven::read_sas(file, ...),
               "dta" = haven::read_stata(file, ...),
               "sav" = haven::read_spss(file, ...),
               "xlsx" = readxl::read_excel(file, ...),
               "xls" = readxl::read_excel(file, ...),
               vroom::vroom(file, ...)
  )

  # return data frame
  return(df)

}
