#' Get and cache dm object
#' @description
#' Gets dm object connection and caches it
#'
#' @param con uses get_con to get the current connection to the DB
#'
#' @return dm object
#'
#' @author Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords connection, dm
#'#'
#' @export
#'

get_dm <- local({

  my_dm <- NULL

  function(con = get_con()) {

    if (length(my_dm) == 0L) {
      message("getting dm")
      my_dm <<- dm::dm_from_con(con = con, learn_keys = TRUE)
    }

    stopifnot(length(my_dm) > 0L)

    my_dm
  }
})
