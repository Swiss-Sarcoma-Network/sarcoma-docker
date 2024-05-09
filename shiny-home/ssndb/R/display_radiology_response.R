#' Displays radiology response info in UI
#' @description
#' Renders information about radiology response (Recist, Choi, Percist) for the "Radiology" panel in UI
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords radiology ui
#'
#' @export

display_radiology_response <- function(input, output, session) {

  output$Radiology_RecistDisplay_text <- renderUI({

    if (input$Radiology_RecistDisplay== TRUE) {
      HTML(
        paste(
          "<b> complete remission (CR):</b> no macroscopic tumor visible <br>
        <b> partial remission (PR):</b> >30% reduction of longest tumor diameter <br>
        <b> stable disease (SD):</b> neither CR, PR, OP nor PD <br>
        <b> progressive disease (PD):</b> >20% increase of longest tumor diameter and/or new lesions"
        )
      )
    }
    else
      if (input$Radiology_RecistDisplay== FALSE) { }
  })

  output$Radiology_ChoiDisplay_text <- renderUI({

    if (input$Radiology_ChoiDisplay== TRUE) {
      HTML(
        paste(
          "<b> complete response (CR):</b> no macroscopic tumor visible <br>
        <b> partial response (PR):</b> >10% reduction of longest tumor diameter or decrease of tumor density by 10% <br>
        <b> stable disease (SD):</b> neither CR, PR, PD AND no clinical worsening <br>
        <b> progressive disease (PD):</b> >10% increase in longest tumor/TL diameter; AND/OR decrease of tumor density on CT by 15%, AND/OR new lesions; AND/OR new intramural nodules OR increase of size of such intramural lesions."
        )
      )
    }
    else
      if (input$Radiology_ChoiDisplay== FALSE) { }
  })

  output$Radiology_Percist_text <- renderUI({

    if (input$Radiology_Percist== TRUE) {
      HTML(
        paste(
          "<b> CMR:</b> Complete resolution of 18F-FDG uptake within the measurable target lesion so that it is less than mean liver activity and at the level of surrounding background blood pool activity. Disappearance of all other lesions to background blood pool levels. No new suspicious 18F-FDG avid lesions. If progression by RECIST must verify with follow up <br>
        <b> PMR:</b> Reduction of a minimum of 30% in target measurable tumor 18F-FDG SUL peak, with absolute drop in SUL of at least 0.8 SUL units. No increase >30% of SUL or size in all other lesions. No new lesions. <br>
        <b> SMD:</b> Not CMR, PMR, or Progressive metabolic disease (PMD). No new lesions. <br>
        <b> PMD:</b> >30% increase in 18F-FDG SUL peak, with >0.8 SUL units increase in tumor SUV peak from the baseline scan in pattern typical of tumor and not of infection/treatment effect.	OR Visible increase in the extent of 18F-FDG tumor uptake. OR New 18F-FDG avid lesions which are typical of cancer and not related to treatment effect or infection."
        )
      )
    }
    else
      if (input$Radiology_Percist== FALSE) { }
  })
}
