#' Write data to the database
#' @description
#' Writes dataframes stored as a list to the specified database
#'
#' @param data dataframe(s) to write to database saved as a list
#' @param dm dm object
#'
#' @return None
#'
#' @author Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords write
#' @export


write_dm <- function(data, dm = get_dm()){

  con <- dm:: dm_get_con(dm)

  tables <- topo_sort_tables(dm)
  for(table in tables[tables %in% names(data)]){
    DBI:: dbWriteTable(conn = con, name = table, value = data[[table]], append = TRUE)
  }
}
