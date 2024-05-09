#' @importFrom methods setOldClass setMethod
#' @importMethodsFrom DBI dbDataType
#' @importClassesFrom RPostgres PqConnection
NULL

#' Generate SQL for custom data types
#'
#' SQL for data types as described in [blob()] can be generated using
#' [DBI::dbDataType()].
#'
#' @param dbObj Object for determining SQL dialect (e.g. connection)
#' @param obj Object for determining SQL type
#' @param ... Generic consistency
#'
#' @name dbDataType
#' @aliases dbDataType,PqConnection,data.frame-method
#' @rdname custom-dbDataType
#' @export
setMethod(
  "dbDataType",
  signature("PqConnection", "data.frame"),
  function(dbObj, obj, ...) {
    res <- Map(
      function(x, i) {
        DBI::dbDataType(dbObj, x, col = DBI::dbQuoteIdentifier(dbObj, i))
      },
      obj,
      names(obj)
    )
    stopifnot(all(vapply(res, is_string, logical(1L))))
    unlist(res)
  }
)

setOldClass("blob")

#' Constructor for custom data types
#'
#' Classes for support of data types not available from `DBI` natively.
#'
#' @export
blob <- function() {
  structure(
    list(),
    class = c("blob", "vctrs_list_of", "vctrs_vctr", "list"),
    ptype = raw()
  )
}

#' @name dbDataType
#' @aliases dbDataType,PqConnection,blob-method
#' @rdname custom-dbDataType
#' @export
#setMethod(
#  "dbDataType",
#  signature("PqConnection", "blob"),
#  function(dbObj, obj, ...) "bytea"
#)
