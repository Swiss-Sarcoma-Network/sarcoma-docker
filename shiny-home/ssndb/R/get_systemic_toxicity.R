#' Returns the ‘toxicity‘ dataframe with factor variables specified as such
#' @description
#' Returns the ‘toxicity‘ dataframe with factor variables specified as such
#'
#' @return toxicity dataframe
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords toxicity
#'
#' @importFrom DBI dbReadTable
#'
#' @export

get_systemic_toxicity <- function() {
  dm <- get_dm()
  toxicity <- dm$toxicity %>% collect()
  levs <- dm$toxicity_name %>% pull(toxicity_name)

  toxicity$toxicity_name <- factor(x = toxicity$toxicity_name,
                                   levels = levs)

  toxicity$toxicity_grade <- factor(x = toxicity$toxicity_grade,
                                    levels = c("Grade 1", "Grade 2", "Grade 3",
                                               "Grade 4", "Grade 5"))

  return(toxicity)
}
