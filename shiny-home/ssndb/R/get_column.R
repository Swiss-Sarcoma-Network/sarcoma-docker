#' Returns a specific column
#' @description
#' Returns a specific column from a table in the datebase
#'
#' @param table table with the column to select
#' @param column column to select
#'
#' @return column from a table in the database
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords column, table
#'#'
#' @export

get_column <- function(table, column){

  stopifnot(
    length(table) == 1L,
    length(column) == 1L,
    class(table) == "character",
    class(column) == "character"
  )

  con <- get_con()

  stopifnot(
    table %in% DBI::dbListTables(con),
    column %in% names(DBI::dbReadTable(con, table))
  )

  df <- DBI::dbGetQuery(
    conn = con,
    paste("select", column, "from", table)
  )

  return(df[,1])
}
