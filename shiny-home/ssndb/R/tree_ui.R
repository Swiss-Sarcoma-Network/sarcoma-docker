#' Creates a shiny UI object with an open button for [ssndb::tree_modal()] and a text field used with [ssndb::tree_modal()]
#' @description
#' Creates a shiny UI object with a [shiny::actionButton()] that opens the [ssndb::tree_modal()]
#'   and a [shiny::textInput()] used with [ssndb::tree_modal()].
#'   The text field is used to update the selected value of the [shinytreeview::treeviewInput()]
#'   inside the [ssndb::tree_modal()].
#'   Likewise, the value that was selected in [shinytreeview::treeviewInput()] inside the
#'   [ssndb::tree_modal()] is used to update the [shiny::textInput()].
#'
#' @param input_id input_id for the Shiny inputs in the modal
#' @param label label for Shiny inputs
#'
#' @return Shiny UI object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords tree_ui
#'
#' @export

tree_ui <- function(input_id, label) {

  tagList(
    value_box(
      title = "",
      theme_color = "secondary",
      actionButton(
        inputId = paste(input_id, "open", sep = "_"),
        label = paste("Open", label),
        style = 'font-size:150%'
      ),
      textAreaInput(
        inputId = paste(input_id, "text", sep = "_"),
        label = label,
        value = ""
      )
    )
  )
}
