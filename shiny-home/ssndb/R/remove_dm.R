#' Removes data from the database
#' @description
#' Removes selected tables or all data from the database using a dm or con object
#'
#' @param data dataframes to be removed from the datbase stored as a list
#' @param dm dm object
#' @param con con object, defaults to get_con() function
#' @param all set all = TRUE to delete all data from the database
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, adapted from Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords remove
#'#'
#' @export


remove_dm <- function(data, dm, con = get_con(), all = FALSE){

  if (!is.null(con)){
    dm <- dm:: dm_from_con(con, schema = "public", learn_keys = TRUE)
  }

  if (length(dm) == 0){
    return(invisible(NULL))
  }

  con <- dm:: dm_get_con(dm)

  tables <- topo_sort_tables(dm, reverse = FALSE)

  if (all){
    for(table in tables){
      DBI:: dbRemoveTable(conn = con, name = table)
    }
  } else{
    for(table in tables[tables %in% names(data)]){
      DBI:: dbRemoveTable(conn = con, name = table)
    }
  }
  }

# Integrate input validation, e.g. is.True(all)
# stop if not all=logical(1)
# give error when con and dm provided
