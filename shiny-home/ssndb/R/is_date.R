#' Checks if object is a date with format "%Y-%m-%d"
#' @description
#' Checks if object is a date with format "%Y-%m-%d"
#'
#' @param date object
#' @param date.format format of the date object, defaults to "%Y-%m-%d"
#'
#' @return logical
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords date
#'
#' @export
#'

is_date <- function(date, date.format = "%Y-%m-%d") {

  stopifnot(class(date) %in% c("character", "Date"))

  tryCatch(!is.na(as.Date(date, date.format)),
           error = function(err) {FALSE})
}
