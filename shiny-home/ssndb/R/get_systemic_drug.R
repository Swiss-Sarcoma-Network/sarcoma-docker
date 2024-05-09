#' Returns the ‘drug‘ dataframe with factor variables specified as such
#' @description
#' Returns the ‘drug‘ dataframe with factor variables specified as such
#'
#' @return drug dataframe
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords drug
#'
#' @importFrom DBI dbReadTable
#'
#' @export

get_systemic_drug <- function(){
  con <- get_con()
  df <- dbReadTable(con, "systemic_drug")

  df$dose_unit <-  factor(
    x = df$dose_unit,
    levels = c("mg/m2 per day",
               "mg/kg  per day",
               "AUC per day",
               "absolute dose in mg per day",
               "cumulative dose in mg per day",
               "units per day")
    )

  df$frequency_unit <- factor(
    x = df$frequency_unit,
    levels = c("x times per week",
               "x times per month",
               "daily",
               "every other day",
               "other")
  )

  df$route <- factor(
    x = df$route,
    levels = c("intra-venous (IV)",
               "subcutaneous (SC)",
               "per os (pos)",
               "intra-muscular (IM)",
               "intra-osseous (IO")
  )

  df$drug <- factor(
    x = df$drug,
    levels = sort(dbReadTable(con, "drug")$drug_name)
  )

  return(df)

}
