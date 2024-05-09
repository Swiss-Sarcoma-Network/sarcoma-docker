#' Server part of the "Sarcoma board" tab
#' @description
#' All server functions for the "Sarcoma board" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords sb server
#'
#' @export

server_sb <- function(input, output, session, iv) {

  dat_sb <- reactiveVal()

  observeEvent(input$pid, {

    dat_sb(
      get_dm()$sarcoma_board %>%
        filter(pid == !!input$pid) %>%
        collect()
      )

    output$sb_table <- DT::renderDataTable({
      DT::datatable(
        data = dat_sb() %>%
          select(pid, sb_date, sb_reason),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  observeEvent(req(input$sb_table_cell_clicked), {

    tmp <- dat_sb()

    sb_date <- tmp %>% slice(input$sb_table_rows_selected) %>% pull(sb_date)

    if (length(sb_date) > 0) {
      sel <- tmp %>% filter(.data$sb_date == .env$sb_date)
    } else {
      sel <- tmp %>% slice(0)
    }

    cfg <- list(
      list(sess = session, fun = "updateTextAreaInput", id = "sb_question", val = pull(sel, sb_question)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_suggestion", val = pull(sel, sb_suggestion)),
      list(sess = session, fun = "updateSelectInput", id = "sb_fast_track", val = pull(sel, fast_track)),
      list(sess = session, fun = "updateSelectInput", id = "sb_reason", val = pull(sel, sb_reason)),
      list(sess = session, fun = "updateSelectInput", id = "sb_current_situation", val = pull(sel, sb_current_situation)),
      list(sess = session, fun = "updateSelectInput", id = "sb_whoops_institution", val = pull(sel, sb_whoops_institution)),
      list(sess = session, fun = "updateSelectInput", id = "sb_followup_status", val = pull(sel, sb_followup_status)),
      list(sess = session, fun = "updateSelectInput", id = "sb_prior_therapy", val = pull(sel, sb_prior_therapy)),
      list(sess = session, fun = "updateSelectInput", id = "sb_followup_reason", val = pull(sel, sb_followup_reason)),
      list(sess = session, fun = "updateTextInput", id = "sb_recurrence_dates", val = pull(sel, sb_recurrence_dates)),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_t", val = pull(sel, ajcc_t)),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_n", val = pull(sel, ajcc_n)),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_m", val = pull(sel, ajcc_m)),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_initial", val = pull(sel, ajcc_initial)),
      list(sess = session, fun = "updateSelectInput", id = "ecog_sb", val = pull(sel, ecog_sb)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_sux", val = pull(sel, decision_sux)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_sux_comment", val = pull(sel, decision_sux_comment)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_rt", val = pull(sel, decision_rt)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_rt_comment", val = pull(sel, decision_rt_comment)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_syst", val = pull(sel, decision_syst)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_syst_comment", val = pull(sel, decision_syst_comment)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_fup", val = pull(sel, decision_fup)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_fup_comment", val = pull(sel, decision_fup_comment)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_diagnostics", val = pull(sel, decision_diagnostics)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_diagnostics_comment", val = pull(sel, decision_diagnostics_comment)),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_palliative", val = pull(sel, decision_palliative)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_palliative_comment", val = pull(sel, decision_palliative_comment)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_summary", val = pull(sel, sb_summary)),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_details", val = pull(sel, sb_details)),
      list(sess = session, fun = "updateSelectInput", id = "sb_last_decision_executed", val = pull(sel, sb_last_decision_executed)),
      list(sess = session, fun = "updateAirDateInput", id = "sb_date", val = pull(sel, sb_date)),
      list(sess = session, fun = "updateAirDateInput", id = "sb_whoops_date", val = pull(sel, sb_whoops_date)),
      list(sess = session, fun = "updateAirDateInput", id = "sb_recurrence_date", val = pull(sel, sb_recurrence_date)),
      list(sess = session, fun = "updateSelectInput", id = "sb_presenting_physician", val = pull(sel, sb_presenting_physician))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$sb_table_add, {

    df <- dat_sb() %>%
      select(pid, sb_date, sb_reason)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("sb_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateTextAreaInput", id = "sb_question", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_suggestion", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "sb_date", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "sb_whoops_date", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "sb_recurrence_date", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_fast_track", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_reason", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_current_situation", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_whoops_institution", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_followup_status", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_prior_therapy", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_followup_reason", val = ""),
      list(sess = session, fun = "updateTextInput", id = "sb_recurrence_dates", val = ""),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_t", val = ""),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_n", val = ""),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_m", val = ""),
      # list(sess = session, fun = "updateSelectInput", id = "sb_ajcc_initial", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "ecog_sb", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_sux", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_sux_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_rt", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_rt_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_syst", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_syst_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_fup", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_fup_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_diagnostics", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_diagnostics_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_decision_palliative", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_decision_palliative_comment", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_summary", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sb_details", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_last_decision_executed", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sb_presenting_physician", val = "")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }

  })

  output$sb_ecog_criteria <- renderUI({

    if (input$sb_ecog_criteria_display == TRUE) {
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
    } else
      if (input$sb_ecog_criteria_display == FALSE) { }
  })

  observeEvent(input$sb_submit, {
    flag <- FALSE
    table_sb_dates <- get_dm()$sarcoma_board_date %>% collect() # is not edited, therefore call outside reactiveVal

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }
    if (length(input$sb_date) == 0) {
      iv$add_rule("sb_date", sv_required())
      showNotification("Date of SB is missing.")
      flag <- TRUE
    }

    if (is.null(input$sb_date) | length(input$sb_date) == 0) {
      sb_date <- as.Date(NA)
    } else {
      sb_date <- as.Date(input$sb_date)
    }

    if (all(!sb_date %in% table_sb_dates$sb_date & !is.na(sb_date))) {
      showNotification("Sarcoma board date is invalid because not on a Tuesday")
      flag <- TRUE
    }

    if (flag == FALSE) {
      if (length(input$sb_prior_therapy) > 0) {
        sb_prior_therapy <- input$sb_prior_therapy
      } else {
        sb_prior_therapy <- NA
      }

      if (input$sb_whoops_institution == "") {
        sb_whoops_institution <- "Please choose institution"
      } else {
        sb_whoops_institution <- input$sb_whoops_institution
      }

      newtab <- data.frame(
        pid = as.character(input$pid),
        sb_question = as.character(input$sb_question),
        sb_suggestion = as.character(input$sb_suggestion),
        fast_track = as.factor(input$sb_fast_track),
        sb_date = sb_date,
        sb_reason = as.factor(input$sb_reason),
        sb_current_situation = as.factor(input$sb_current_situation),
        sb_whoops_date = convert_null_date(input$sb_whoops_date),
        sb_whoops_institution = as.factor(sb_whoops_institution),
        sb_followup_status = as.factor(input$sb_followup_status),
        sb_prior_therapy = sb_prior_therapy,
        sb_followup_reason = as.factor(input$sb_followup_reason),
        sb_recurrence_date = convert_null_date(input$sb_recurrence_date),
        sb_recurrence_dates = as.character(input$sb_current_situation),
        # ajcc_t = as.factor(input$sb_ajcc_t),
        # ajcc_n = as.factor(input$sb_ajcc_n),
        # ajcc_m = as.factor(input$sb_ajcc_m),
        # ajcc_initial = as.factor(input$sb_ajcc_initial),
        ecog_sb = as.integer(input$ecog_sb),
        decision_sux = as.factor(input$sb_decision_sux),
        decision_sux_comment = as.character(input$sb_decision_sux_comment),
        decision_rt = as.factor(input$sb_decision_rt),
        decision_rt_comment = as.character(input$sb_decision_rt_comment),
        decision_syst = as.factor(input$sb_decision_syst),
        decision_syst_comment = as.character(input$sb_decision_syst_comment),
        decision_fup = as.factor(input$sb_decision_fup),
        decision_fup_comment = as.character(input$sb_decision_fup_comment),
        decision_diagnostics = as.factor(input$sb_decision_diagnostics),
        decision_diagnostics_comment = as.character(input$sb_decision_diagnostics_comment),
        decision_palliative = as.character(input$sb_decision_palliative),
        decision_palliative_comment = as.character(input$sb_decision_palliative_comment),
        sb_summary = as.character(input$sb_summary),
        sb_details = as.character(input$sb_details),
        sb_presenting_physician = as.factor(input$sb_presenting_physician),
        sb_last_decision_executed = as.factor(input$sb_last_decision_executed)
      )

      nr_rows_before <- nrow(dat_sb())

      rows_upsert(x = get_dm()$sarcoma_board,
                  y = newtab,
                  by = c("pid", "sb_date"),
                  copy = TRUE,
                  in_place = TRUE)

      dat_sb(
        get_dm()$sarcoma_board %>%
          filter(pid == !!input$pid) %>%
          collect()
        )

      nr_rows_after <- nrow(dat_sb())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("sb_table") %>%
          DT::replaceData(data = dat_sb() %>% select(pid, sb_date, sb_reason)) %>%
          DT::selectRows(input$sb_table_rows_selected)
      } else {
        DT::dataTableProxy("sb_table") %>%
          DT::replaceData(data = dat_sb() %>% select(pid, sb_date, sb_reason)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }
  })
}
