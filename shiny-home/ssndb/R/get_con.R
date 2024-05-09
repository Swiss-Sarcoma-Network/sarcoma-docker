#' Get and cache connection
#' @description
#' Gets DBI connection
#'
#' @param dbname defaults to db_default()
#' @param uid defaults to uid_default()
#' @param pwd defaults to pwd_default()
#'
#' @return None
#'
#' @author Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords connection
#'#'
#' @export
#'


get_con <- function(dbname = db_default(), uid = uid_default(),
                    pwd = pwd_default()) {

  db_key <- paste0(dbname, "_", uid)

  if (exists(db_key, envir = db_cons, inherits = FALSE)) {
    if (DBI::dbIsValid(db_cons[[db_key]])) {
      return(db_cons[[db_key]])
    }
  }
  #
  can_connect <- DBI::dbCanConnect(
    RPostgres::Postgres(),
    host = "db_container",
    dbname = "postgres",
    user = "postgres",
    password = "postgres"
  )

  if (can_connect == TRUE) {
    con <- DBI::dbConnect(
      RPostgres::Postgres(),
      host = "db_container",
      dbname = "postgres",
      user = "postgres",
      password = "postgres"
    )
  } else {
    con <- DBI::dbConnect(
      RPostgres::Postgres(),
      user = uid,
      password = pwd,
      dbname = dbname
    )
  }
  # con <- DBI::dbConnect(
  # RPostgres::Postgres(),
  # host = 'ssndb.cnbjjotrdenn.us-east-1.rds.amazonaws.com', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
  # port = 5432, # or any other port specified by your DBA
  # user = 'postgres',
  # password = 'postgres')

  # assign(db_key, con, envir = db_cons)

  con
}
