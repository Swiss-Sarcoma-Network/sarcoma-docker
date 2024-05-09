#' Create select Input for User
#' @description
#' Creates a [shiny::selectInput()] function for User by subsetting by desired discipline and
#' pasting first and last name to a string which is then displayed as choices
#'
#' @param inputId inputId used in [shiny::selectInput()] function
#' @param label label used in [shiny::selectInput()] function
#' @param user_discipline discipline to subset by in the user table
#' @param multiple logical that indicates if in [shiny::selectInput()]: multiple = TRUE should be set
#'
#' @return Shiny selectInput object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords user, selectInput
#'
#' @export

user_input <- function(inputId, label, user_discipline, multiple = FALSE) {

  user <- get_dm()$user %>% dplyr::collect() %>% as.data.frame()

  if (!is.null(user_discipline)) {

    rows <- stringr::str_detect(string = user$discipline, pattern = user_discipline)

    stopifnot(any(rows == TRUE))

  } else {
    rows <- TRUE
  }

  names <- paste(user[rows,"first_name"], user[rows,"last_name"])
  institution <- user[rows,"institution"]
  discipline <- user[rows,"discipline"]



  if ("Unknown Unknown" %in% names) {
    names[names=="Unknown Unknown"] <- "Unknown"
  }

  stopifnot(length(names) > 0)

  if (multiple == TRUE){

    selectInput(inputId = inputId,
                   label = label,
                   choices = c("", paste(names, "/", institution, "/", discipline)),
                   multiple = TRUE)

  } else {

    selectInput(inputId = inputId,
                   label = label,
                choices = c("", paste(names, "/", institution, "/", discipline))
                   # choices = c("", names)
                   )
  }
}

