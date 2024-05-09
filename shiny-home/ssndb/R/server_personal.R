#' Server part of the "Personal data" tab
#' @description
#' All server functions for the "Personal data" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords personal server
#'
#' @export

server_personal <- function(input, output, session, iv) {

  add_btn <- reactiveVal()

  observe({

    add_btn(input$personal_add)
  })

  observe({

    if (add_btn() > 0) {
      shinyjs::show("personal_pid_new")
    } else {
      shinyjs::hide("personal_pid_new")
    }
  })

  observeEvent(input$personal_consent == TRUE, {

    lapply(
      c("personal_institution", "personal_last_name", "personal_first_name",
        "personal_date_birth", "personal_gender", "personal_street",
        "personal_house_nr", "personal_post_code", "personal_city",
        "personal_country", "personal_phone_number", "personal_email",
        "personal_insurance_name", "personal_insurance_class", "personal_insurance_number",
        "personal_ahv", "personal_gp_name", "personal_gp_email"),
      shinyjs:: toggleState,
      condition = input$personal_consent == TRUE)
  })

  observeEvent(input$personal_add, {

    updateSelectInput(session = session,
                      inputId = "pid",
                      selected = "Edit existing patient")

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "personal_institution", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "personal_date_birth", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_last_name", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_first_name", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "personal_gender", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_street", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_house_nr", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_post_code", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_city", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_country", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_phone_number", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_email", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_insurance_name", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "personal_insurance_class", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_insurance_number", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_ahv", val = ""),
      list(sess = session, fun = "updateCheckboxInput", id = "personal_consent", val = !input$personal_consent),
      list(sess = session, fun = "updateTextInput", id = "personal_gp_name", val = ""),
      list(sess = session, fun = "updateTextInput", id = "personal_gp_email", val = "")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }

  })

  observeEvent(input$personal_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient" & input$personal_pid_new == "") {
      showNotification("PID is missing")
      flag <- TRUE
    }

    if (input$personal_institution == "" | input$personal_institution == "Please choose institution") {
      iv$add_rule("personal_institution", sv_required())
      iv$add_rule("personal_institution", sv_not_equal("Please choose institution", message_fmt = "Not a valid institution."))
      showNotification("Institution is missing or invalid")
      flag <- TRUE
    }

    if (input$personal_email != "" & stringr::str_detect(string = input$personal_email, pattern = "@") == FALSE) {
      showNotification("The entered email address is not valid.")
      flag <- TRUE
    }

    if (flag == FALSE) {

      if (input$pid == "Edit existing patient") {
        pid <- input$personal_pid_new
      } else {
        pid <- input$pid
      }

      if (input$personal_insurance_name != "") {
        personal_insurance_name <- input$personal_insurance_name
      } else {
        personal_insurance_name <- "Unknown"
      }

      newtab_personal_clinical <- data.frame(
        pid = as.character(pid),
        institution = as.factor(input$personal_institution),
        last_name = as.character(stringr::str_to_title(input$personal_last_name)),
        first_name = as.character(stringr::str_to_title(input$personal_first_name)),
        date_birth = convert_null_date(input$personal_date_birth),
        gender = as.factor(input$personal_gender),
        street = as.character(input$personal_street),
        house_nr = as.character(input$personal_house_nr),
        post_code = as.numeric(input$personal_post_code),
        city = as.character(input$personal_city),
        country = as.character(input$personal_country),
        phone_number = as.character(input$personal_phone_number),
        email = as.character(input$personal_email),
        insurance_name = as.character(personal_insurance_name),
        insurance_class = as.factor(input$personal_insurance_class),
        insurance_number = as.character(input$personal_insurance_number),
        ahv = as.character(input$personal_ahv),
        consent = as.logical(input$personal_consent),
        gp_name = as.character(input$personal_gp_name),
        gp_email = as.character(input$personal_gp_email)
      )

      rows_upsert(x = get_dm()$personal_clinical,
                  y = newtab_personal_clinical,
                  by = "pid",
                  copy = TRUE,
                  in_place = TRUE)

      showNotification("Data were submitted successfully.")

      choices <- c("Edit existing patient",
                   sort(unique(get_column(table = "personal_clinical", column = "pid")))
                   )

      updateSelectInput(
        session = session,
        inputId = "pid",
        choices = choices,
        selected = pid
      )

      if (isTruthy(input$personal_pid_new)) {
      add_btn(0)

      updateTextInput(
        session = session,
        inputId = "personal_pid_new",
        value = "")
      }
    }
  })

  observeEvent(req(input$pid), {
    sel <- get_dm()$personal_clinical %>%
      filter(pid == !!input$pid)

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "personal_institution", val = pull(sel, institution)),
      list(sess = session, fun = "updateTextInput", id = "personal_last_name", val = pull(sel, last_name)),
      list(sess = session, fun = "updateTextInput", id = "personal_first_name", val = pull(sel, first_name)),
      list(sess = session, fun = "updateSelectInput", id = "personal_gender", val = pull(sel, gender)),
      list(sess = session, fun = "updateTextInput", id = "personal_street", val = pull(sel, street)),
      list(sess = session, fun = "updateTextInput", id = "personal_house_nr", val = pull(sel, house_nr)),
      list(sess = session, fun = "updateTextInput", id = "personal_post_code", val = pull(sel, post_code)),
      list(sess = session, fun = "updateTextInput", id = "personal_city", val = pull(sel, city)),
      list(sess = session, fun = "updateTextInput", id = "personal_country", val = pull(sel, country)),
      list(sess = session, fun = "updateTextInput", id = "personal_phone_number", val = pull(sel, phone_number)),
      list(sess = session, fun = "updateTextInput", id = "personal_email", val = pull(sel, email)),
      list(sess = session, fun = "updateTextInput", id = "personal_insurance_name", val = pull(sel, insurance_name)),
      list(sess = session, fun = "updateSelectInput", id = "personal_insurance_class", val = pull(sel, insurance_class)),
      list(sess = session, fun = "updateTextInput", id = "personal_insurance_number", val = pull(sel, insurance_number)),
      list(sess = session, fun = "updateTextInput", id = "personal_ahv", val = pull(sel, ahv)),
      list(sess = session, fun = "updateCheckboxInput", id = "personal_consent", val = pull(sel, consent)),
      list(sess = session, fun = "updateTextInput", id = "personal_gp_name", val = pull(sel, gp_name)),
      list(sess = session, fun = "updateTextInput", id = "personal_gp_email", val = pull(sel, gp_email)),
      list(sess = session, fun = "updateAirDateInput", id = "personal_date_birth", val = pull(sel, date_birth))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })
}
