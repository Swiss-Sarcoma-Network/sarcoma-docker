### Helper functions needed to write to / remove from database

pkgload::pkg_version() # in order to silence NOTE: Namespace in Imports field not imported from: ‘pkgload’

dfs <- function(x, child, parent) {

  visit <- function(i) {
    if (perm[i]) {
      return(NULL)
    }

    if (temp[i]) stop("Not a DAG")

    temp[i] <<- TRUE

    for (j in unique(parent[which(i == child)])) visit(j)

    temp[i] <<- FALSE
    perm[i] <<- TRUE

    res <<- c(i, res)

    NULL
  }

  stopifnot(
    identical(length(child), length(parent)),
    all(child %in% x), all(parent %in% x), all(child != parent)
  )

  if (!length(child)) {
    return(x)
  }

  child <- match(child, x)
  parent <- match(parent, x)

  perm <- logical(length(x))
  temp <- logical(length(x))

  res <- integer()

  while (!all(perm)) {
    visit(which(!perm)[1L])
  }

  x[res]
}

topo_sort_tables <- function(dm, reverse = TRUE) {
  dm_fks <- dm::dm_get_all_fks(dm)
  t <- dfs(names(dm), dm_fks[["child_table"]], dm_fks[["parent_table"]])
  if(reverse){
    t <- rev(t)
  }
  t
}

data_path <- function(file) {
  system.file("extdata", file, package = "ssndb")
}

#' Update Shiny inputs
#' @description This function calls shiny inputs.
#' @param fun type of update shiny input function
#' @param id inputId of shiny input finction
#' @param val value that is used to update
#' @param sess Shiny session
#' @export
update_field <- function(fun, id, val, sess) {

  # stopifnot(
  #   length(val) < 2
  # )

  if (fun %in% c("updateSelectizeInput", "updateSelectInput", "updateTreeview")) {
    do.call(fun, list(session = sess, inputId = id, selected = val))
  } else if (fun == "updateAirDateInput" && isTRUE(val == "") |
             fun == "updateAirDateInput" && length(val) == 0 |
             fun == "updateAirDateInput" && is.na(val)) {
    do.call(fun, list(session = sess, inputId = id, clear = TRUE))
  } else {
    do.call(fun, list(session = sess, inputId = id, value = val))
  }
}

labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

# we can implement a "poor man's" variant of slice()
# for the particular class. (It doesn't work quite the same
# in all cases.)
#' @export
slice.tbl_sql <- function(.data, ...) {
  rows <- c(...)

  .data %>%
    mutate(...row_id = row_number()) %>%
    filter(...row_id %in% !!rows) %>%
    select(-...row_id)
}

is_string <- function(x) {
  is.character(x) && length(x) == 1L
}
