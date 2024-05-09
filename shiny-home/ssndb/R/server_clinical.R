#' Server part of the "Clinical data" tab
#' @description
#' All server functions for the "Clinical data" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords clinical server
#'
#' @export

server_clinical <- function(input, output, session, iv) {

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "clinical_anatomic_region",
    tree = ssndb::create_tree("anatomic_region_name"),
    label = "anatomic region"
  )

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "clinical_anatomic_region2",
    tree = ssndb::create_tree("anatomic_region_name"),
    label = "Additional tumor: Anatomic side of lesion"
  )

  observeEvent(input$clinical_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }

    if (flag == FALSE) {

      if (input$clinical_anatomic_region_text == "") {
        anatomic_region <- "Not (yet) determined"
      } else {
        anatomic_region <- input$clinical_anatomic_region_text
      }

      newtab_personal_clinical <- data.frame(
        pid = as.character(input$pid),
        referral_diagnosis = as.character(input$clinical_referral_diagnosis),
        anatomic_region = as.factor(anatomic_region),
        anatomic_side = as.factor(input$clinical_anatomic_side),
        clinical_history = as.character(input$clinical_history),
        ecog_initial = as.integer(input$clinical_ecog),
        last_contact_date = convert_null_date(input$clinical_last_contact_date),
        last_status = as.factor(input$clinical_last_status),
        death_reason = as.factor(input$clinical_death_reason),
        followup_physician = as.factor(input$clinical_followup_physician)
      )

      rows_upsert(x = get_dm()$personal_clinical,
                  y = newtab_personal_clinical,
                  by = "pid",
                  copy = TRUE,
                  in_place = TRUE)

      if (input$clinical_previous_cancer == "") {
        cancer_syndrome_value  <- input$clinical_cancer_syndrome_other
      } else {
        cancer_syndrome_value  <- input$clinical_previous_cancer
      }

      newtab_cancer_syndrome <- data.frame(
        pid = as.character(input$pid),
        cancer_syndrome_name = as.character(input$clinical_cancer_syndrome),
        value = as.character(cancer_syndrome_value),
        default = NA
      )

      rows_upsert(x = get_dm()$cancer_syndrome,
                  y = newtab_cancer_syndrome,
                  by = c("pid", "cancer_syndrome_name"),
                  copy = TRUE,
                  in_place = TRUE)

      if (any(isTruthy(input$clinical_anatomic_side2), isTruthy(input$clinical_anatomic_region2),
             isTruthy(input$clinical_clinical_history2))) {

        if (input$clinical_anatomic_region2_text == "") {
          anatomic_region2 <- "Not (yet) determined"
        } else {
          anatomic_region2 <- input$clinical_anatomic_region2_text
        }

      newtab_additional_tumor <- data.frame(
        pid = as.character(input$pid), #
        addtumor_anatomic_side = as.factor(input$clinical_anatomic_side2),
        addtumor_anatomic_region = as.factor(anatomic_region2),
        addtumor_clinical_history = as.character(input$clinical_clinical_history2)
      )

      rows_upsert(x = get_dm()$additional_tumor,
                  y = newtab_additional_tumor,
                  by = "pid",
                  copy = TRUE,
                  in_place = TRUE)

      }

      showNotification("Data were submitted successfully.")
    }
  })


  observeEvent(req(input$pid), {

    sel <- get_dm()$personal_clinical %>%
      filter(pid == !!input$pid)

    sel_cancer_syndrome <- get_dm()$cancer_syndrome %>%
      filter(pid == !!input$pid)

    anatomic_reg <- sel %>% pull(anatomic_region)

    if (isTruthy(anatomic_reg)) {
      selected_val <- anatomic_reg
    } else{
      selected_val <- "Not (yet) determined"
    }

    additional_tumor <- get_dm()$additional_tumor %>%
      filter(pid == !!input$pid)

    anatomic_reg2 <- additional_tumor %>% pull(addtumor_anatomic_region)

    if (isTruthy(anatomic_reg2)) {
      selected_val2 <- anatomic_reg2
    } else{
      selected_val2 <- "Not (yet) determined"
    }

    cancer_syndrome <- pull(sel_cancer_syndrome, cancer_syndrome_name)
    previous_cancer <- sel_cancer_syndrome %>% filter(cancer_syndrome_name == "Previous cancer") %>% pull(value)
    other_cancer_syndrome <- sel_cancer_syndrome %>% filter(cancer_syndrome_name == "Other") %>% pull(value)


    if (!isTruthy(cancer_syndrome)) {
      cancer_syndrome <- "No"
    }

    cfg <- list(
      list(sess = session, fun = "updateTextAreaInput", id = "clinical_referral_diagnosis", val = pull(sel, referral_diagnosis)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_anatomic_side", val = pull(sel, anatomic_side)),
      list(sess = session, fun = "updateTextInput", id = "clinical_history", val = pull(sel, clinical_history)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_ecog", val = pull(sel, ecog_initial)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_last_status", val = pull(sel, last_status)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_death_reason", val = pull(sel, death_reason)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_followup_physician", val = pull(sel, followup_physician)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_cancer_syndrome", val = cancer_syndrome),
      list(sess = session, fun = "updateTextAreaInput", id = "clinical_previous_cancer", val = previous_cancer),
      list(sess = session, fun = "updateTextAreaInput", id = "clinical_cancer_syndrome_other", val = other_cancer_syndrome),
      list(sess = session, fun = "updateAirDateInput", id = "clinical_last_contact_date", val = pull(sel, last_contact_date)),
      list(sess = session, fun = "updateTextAreaInput", id = "clinical_anatomic_region_text", val = selected_val),
      list(sess = session, fun = "updateSelectInput", id = "clinical_anatomic_side2", val = pull(additional_tumor, addtumor_anatomic_side)),
      list(sess = session, fun = "updateSelectInput", id = "clinical_clinical_history2", val = pull(additional_tumor, addtumor_clinical_history)),
      list(sess = session, fun = "updateTextAreaInput", id = "clinical_anatomic_region2_text", val = selected_val2)
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  output$clinical_ecog_criteria <- renderUI({

    if (input$clinical_ecog_criteria_display== TRUE) {
      HTML(
        paste(
          "<b> ECOG performance status </b> <br>
          <b>0:</b> Fully active, able to carry on all pre-disease performance without restriction, corresponds to KPI 100-90 <br>
          <b>1:</b> Restricted in physically strenuous activity but ambulatory and able to carry out work of a light or sedentary nature, e.g., light house work, office work, corresponds to KPI 80-70 <br>
          <b>2:</b> Ambulatory and capable of all selfcare but unable to carry out any work activities; up and about more than 50% of waking hours, corresponds to KPI 60-50 <br>
          <b>3:</b> Capable of only limited selfcare; confined to bed or chair more than 50% of waking hours, corresponds to KPI 40-30 <br>
          <b>4:</b> Completely disabled; cannot carry on any selfcare; totally confined to bed or chair, corresponds to KPI 20-10 <br>
          <b>5:</b> Dead, corresponds to KPI 0 <br>
          * KPI - Karnofsky Performance Index
          ")
      )
    }
    else
      if (input$clinical_ecog_criteria_display== FALSE) { }
  })
}
