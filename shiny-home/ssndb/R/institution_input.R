#' Create select Input for institution
#' @description
#' Creates a selectInput function for institution
#'
#' @param inputId inputId used in Shiny's selectInput function
#' @param label label used in Shiny's selectInput function
#'
#' @return Shiny selectInput object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords institution, selectInput
#'
#' @export


institution_input <- function(inputId, label) {

  stopifnot(!is.null(inputId), !is.null(label))

  object <- get_dm()$institution %>% pull(institution_name)

  stopifnot(length(object) > 0)

  choices <- sort(unique(object))

  selectInput(
    inputId = inputId,
    label = label,
    choices = c("Please choose institution", choices)
  )
}
