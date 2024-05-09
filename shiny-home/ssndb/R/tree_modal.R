#' Creates a [shiny::modalDialog()] with a [shinytreeview::treeviewInput()]
#' @description
#' Creates a [shiny::modalDialog()] with a [shinytreeview::treeviewInput()],
#' a search field, a close treeviewInput button and a dismiss modal button.
#' The tree is created using the [ssndb::create_tree()] function.
#'
#' @param session Shiny session object
#' @param input_id input_id for the Shiny inputs in the modal
#' @param tree [ssndb::create_tree()] or [shinytreeview::make_tree()] object
#' @param label label for Shiny inputs
#' @param selected selected value for [shinytreeview::treeviewInput()], defaults to NULL
#' @param multiple logical that indicates if multiple values are allowed for [shinytreeview::treeviewInput()]

#'
#' @return [shiny::modalDialog()] object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords treeviewInput create_tree modalDialog
#'
#' @export
#'

tree_modal <- function(session, input_id, tree, label, selected = NULL, multiple){

  stopifnot(!is.null(input_id))
  stopifnot(!is.null(tree))
  stopifnot(class(tree) == "list")
  stopifnot(!is.null(label))

  dismiss_btn <- paste(input_id, "dismiss", sep = "_")
  search_btn <- paste(input_id, "search", sep = "_")
  collapse_btn <- paste(input_id, "collapse", sep = "_")

  if (is.null(selected)) {
    selected <- tree[[1]]$text
  }

  modalDialog(
    fluidRow(
      column(6,
             actionButton(
               inputId = dismiss_btn,
               label = "Confirm",
               class = "btn-warning"
             ),
             textInput(
               inputId = search_btn,
               label = paste("Search for", label)
             )
      ),
      column(6,
             actionButton(
               inputId = collapse_btn,
               label = paste("Collapse", label, "tree")
             )
      )
    ),
    shinytreeview::treeviewInput(
      inputId = input_id,
      label = label,
      choices = tree,
      selected = selected,
      multiple = multiple
      # ,prevent_unselect = FALSE
    ),
    footer = NULL
  )
}
