options(shiny.autoload.r = FALSE)

pkgload::load_all(".")

shinyApp(ui = ui(), server = server)
