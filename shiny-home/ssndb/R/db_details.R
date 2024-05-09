#' Set database parameters
#' @description
#' Sets database parameters
#'
#' @author Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords db details
#'


db_cons <- new.env()

uid_default <- function() Sys.getenv("USER")

db_default <- function() "ssn_registry"

pwd_default <- function() {

  pwd <- Sys.getenv("POSTGRES_USR_PWD")

  if (pwd == "") {
    pwd <- uid_default()
  }

  pwd
}
