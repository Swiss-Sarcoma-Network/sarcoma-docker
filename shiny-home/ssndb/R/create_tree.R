#' Creates a tree analogous to make_tree, only lowest level is selectable
#' @description
#' Creates a [shinytreeview::make_tree()] object from a table in the database,
#'  only the lowest level is selectable
#'
#' @param table name of the table to display, needs to be present in get_dm() environment
#'
#' @return [shinytreeview::make_tree()] object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords shinytreeview create_tree make_tree
#'
#' @importFrom shinytreeview make_tree
#'
#' @export

create_tree <- function(table) {

  if (table == "resection_name") {
    data <- load(data_path("tree_resection_name.RData"))
    stopifnot(length(data) == 1)
    return(get(data))
  }

  if (table == "reconstruction_name") {
    data <- load(data_path("tree_reconstruction_name.RData"))
    stopifnot(length(data) == 1)
    return(get(data))
  }

  if (table == "anatomic_region_name") {
    data <- load(data_path("tree_anatomic_region_name.RData"))
    stopifnot(length(data) == 1)
    return(get(data))
  }

  if (table == "amputation_name") {
    data <- load(data_path("tree_amputation_name.RData"))
    stopifnot(length(data) == 1)
    return(get(data))
  }

  if (table == "hemipelvectomy_name") {
    data <- load(data_path("tree_hemipelvectomy_name.RData"))
    stopifnot(length(data) == 1)
    return(get(data))
  }

  if (!table %in% c("resection_name", "anatomic_region_name",
                    "reconstruction_name", "amputation_name",
                    "hemipelvectomy_name")) {

    data <- get_dm()[[table]] %>% collect()

    stopifnot(nrow(data) > 0)

    args <- list(
      data = data,
      levels = names(data)
    )

    args[args$levels[1:(ncol(data)-1)]] <- list(list(selectable = FALSE))

    make.tree <- do.call(make_tree, args)

    return(make.tree)
  }
}
