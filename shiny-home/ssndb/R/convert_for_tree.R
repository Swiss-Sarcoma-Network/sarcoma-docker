#' Converts null input to the standard input used for [ssndb::tree_server()]
#' @description
#' Converts a value that is not truthy [shiny::isTruthy()] into the  placeholder missing
#'   value for the respective table
#'
#' @param object object that gets converted to placeholder missing value if null
#' @param table table in [ssndb::data_model()] to which this object corresponds
#'
#' @return value
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords convert tree
#'
#' @export

convert_for_tree <- function(object, table) {

  stopifnot(table %in% c("anatomic_region", "diagnosis_who", "resection_name",
                         "reconstruction_name", "amputation_name", "hemipelvectomy_name"))

  if (table == "anatomic_region") {
    nul <- "Not (yet) determined"
  } else {
    nul <- "Not applicable"
  }

  if (shiny::isTruthy(object)) {
    return(object)
  } else {
    return(nul)
  }

}

