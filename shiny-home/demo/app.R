#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RPostgres)
# Note that this works only from container to container,
# not when you run the app on the Host and try to connect
# directly, cause then the host would be localhost.
con <- dbConnect(Postgres(),
                 host = "db_container",
                 dbname = "postgres",
                 user = "postgres",
                 password = "postgres")

tbl <- dbGetQuery(con, 'SELECT * FROM demo.demo')
dbDisconnect(con)


# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Postgres DEMO query"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("limits",
                  "Number of records shown:",
                  min = 1,
                  max = 3,
                  value = 3)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("tbl")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$tbl <- renderTable({
        tbl[1:input$limits,]
  })

}

# Run the application
shinyApp(ui = ui, server = server)
