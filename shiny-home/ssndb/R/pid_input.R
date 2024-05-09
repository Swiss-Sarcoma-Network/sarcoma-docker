#' Create select Input for PID
#' @description
#' Creates a selectInput function for PID, chooses the PID column from personal_clinical
#' using the get_column function
#'
#' @param inputId inputId used in Shiny's selectInput function
#'
#' @return Shiny selectInput object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords PID, selectInput
#'
#' @export

pid_input <- function(inputId){

  col <- get_column(table = "personal_clinical", column = "pid")

  if (isTruthy(col)) {

    selectInput(
      inputId = inputId,
      label = "",
      choices = c("Edit existing patient", sort(unique(col)))
    )
  }
}
