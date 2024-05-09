server <- function(input, output, session) {

  # credentials <- get_dm()$test %>% collect()
  # res_auth <- shinymanager::secure_server( # put into imports
  #   check_credentials = shinymanager::check_credentials(credentials)
  # )

  observe({
    choices <- c("Edit existing patient",
                 sort(unique(get_column(table = "personal_clinical", column = "pid")))
    )
    updateSelectInput(
      session = session,
      inputId = "pid",
      choices = choices)
  })

  iv <- InputValidator$new()
  iv$enable()

  server_personal(input = input, output = output, session = session, iv = iv)

  server_clinical(input = input, output = output, session = session, iv = iv)

  server_sb(input = input, output = output, session = session, iv = iv)

  server_radiology(input = input, output = output, session = session, iv = iv)

  server_pathology(input = input, output = output, session = session, iv = iv)

  server_surgery(input = input, output = output, session = session, iv = iv)

  server_radiotherapy(input = input, output = output, session = session, iv = iv)

  server_syst(input = input, output = output, session = session, iv = iv)
}
