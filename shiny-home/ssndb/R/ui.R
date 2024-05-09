css <- "
.nav.navbar-nav .form-group.shiny-input-container {
  margin-bottom: 0; height: 38px;
}
.nav.navbar-nav .form-group.shiny-input-container > label {
  display: inline;
}
"

ui <- function() {
  #shinymanager::secure_app(
  page_navbar(id = "tab",
    theme = bs_theme(
      secondary = "#CCCCCB", success = "#80807D",
      warning = "#CCCCCB", font_scale = NULL,
      bootswatch = "flatly"
    ),
    title = "SSN-Registry",
    header = tagList(tags$style(HTML(css))),
    nav_panel("Personal", icon = icon("user"), id = "test",
        personal()
    ),
    nav_panel("Clinical", icon = icon("book-medical"),
        clinical()
    ),
    nav_panel("SB", icon = icon("calendar"),
        sarcoma_board()
    ),
    nav_panel("RAD", icon = icon("desktop"),
        radiology()
    ),
    nav_panel("PAT", icon = icon("microscope"),
        pathology()
    ),
    nav_panel("SUR", icon = icon("screwdriver"),
        surgery()
    ),
    nav_panel("RT", icon = icon("radiation"),
        radiotherapy()
    ),
    nav_panel("SYST", icon = icon("capsules"),
        systemic_therapy()
    ),
    nav_spacer(),
    nav_item(
      pid_input(inputId = "pid")
    ),
    footer = shinyWidgets::useShinydashboard()
  )
  #)
}

