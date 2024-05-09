#' Creates a shiny server object that corresponds with [ssndb::tree_ui()]
#' @description
#' Creates a shiny server object that corresponds with [ssndb::tree_ui()]
#'
#' @param input Shiny's input object
#' @param output Shiny's output object
#' @param session Shiny's session object
#' @param input_id input_id for the Shiny inputs in the [ssndb::tree_modal()]
#' @param tree [ssndb::create_tree()] or [shinytreeview::make_tree()] object
#' @param label label for functions inside the [ssndb::tree_modal()]
#' @param multiple logical that indicates if multiple values are allowed for [shinytreeview::treeviewInput()], defaults to FALSE
#'
#' @return shiny::moduleServer() object
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords tree_server module
#'
#' @export

tree_server <- function(input, output, session, input_id, tree, label, multiple = FALSE) {
      message("server")

      open <- paste(input_id, "open", sep = "_")
      dismiss <- paste(input_id, "dismiss", sep = "_")
      text_id <- paste(input_id, "text", sep = "_")
      search <- paste(input_id, "search", sep = "_")
      collapse <- paste(input_id, "collapse", sep = "_")

      shinyjs::disable(text_id)

      observeEvent(input[[open]], {
        message("open")

        if (!isTruthy(input[[text_id]])) {
          selected_val <- tree[[1]]$text
        } else {
          selected_val <- input[[text_id]]
        }

        if (multiple == TRUE) {
          selected_val <- stringr::str_split(selected_val, ",")[[1]]
        }

        showModal(
          tree_modal(
            session = session,
            input_id = input_id,
            tree = tree,
            label = label,
            selected = selected_val,
            multiple = multiple
          )
        )
      })

      observeEvent(input[[dismiss]], {
        message("dismiss")

        if (length(input[[input_id]]) > 1) {
          contains_na <- stringr::str_detect(input[[input_id]], "Not applicable")
          inp <- input[[input_id]][!contains_na]
        } else {
          inp <- input[[input_id]]
        }

        updateTextAreaInput(
          session = session,
          inputId = text_id,
          value = inp
        )

        removeModal()
      })

      observeEvent(input[[search]], {
        message("search")
        req(input[[search]])

        shinytreeview::searchTreeview(
          inputId = input_id,
          pattern = input[[search]],
          reveal_results = TRUE,
          ignore_case = TRUE,
          exact_match = FALSE,
          collapse_before = TRUE
        )
      })

      observeEvent(input[[collapse]], {
        message("collapse")

        shinytreeview::collapseTreeview(inputId = input_id)
      })
}
