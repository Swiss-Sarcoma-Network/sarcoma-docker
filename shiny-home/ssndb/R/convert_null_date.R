#' Convert the value of a dateInput into an eligible format
#' @description
#' dateInputs that return a NULL value can not be written to the database,
#'  but have to be converted into NA
#'
#' @param input input from Shiny
#'
#' @return Date object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords date NA NULL
#'
#' @export

convert_null_date <- function(input) {

  stopifnot(class(input) %in% c("Date", "character") |
              is.null(input) |
              is.na(input), length(input) <= 1L)

  if (length(input) > 0) {
    as.Date(input)
  } else {
    as.Date(NA)
  }
}
