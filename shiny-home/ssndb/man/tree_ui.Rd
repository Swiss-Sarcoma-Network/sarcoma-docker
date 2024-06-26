% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tree_ui.R
\name{tree_ui}
\alias{tree_ui}
\title{Creates a shiny UI object with an open button for \code{\link[=tree_modal]{tree_modal()}} and a text field used with \code{\link[=tree_modal]{tree_modal()}}}
\usage{
tree_ui(input_id, label)
}
\arguments{
\item{input_id}{input_id for the Shiny inputs in the modal}

\item{label}{label for Shiny inputs}
}
\value{
Shiny UI object
}
\description{
Creates a shiny UI object with a \code{\link[shiny:actionButton]{shiny::actionButton()}} that opens the \code{\link[=tree_modal]{tree_modal()}}
and a \code{\link[shiny:textInput]{shiny::textInput()}} used with \code{\link[=tree_modal]{tree_modal()}}.
The text field is used to update the selected value of the \code{\link[shinytreeview:treeviewInput]{shinytreeview::treeviewInput()}}
inside the \code{\link[=tree_modal]{tree_modal()}}.
Likewise, the value that was selected in \code{\link[shinytreeview:treeviewInput]{shinytreeview::treeviewInput()}} inside the
\code{\link[=tree_modal]{tree_modal()}} is used to update the \code{\link[shiny:textInput]{shiny::textInput()}}.
}
\author{
Philip Heesen, \email{philip.heesen@uzh.ch}
}
\keyword{tree_ui}
