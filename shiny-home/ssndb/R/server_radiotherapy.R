#' Server part of the "Radiotherapy" tab
#' @description
#' All server functions for the "Radiotherapy" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords radiotherapy server
#'
#' @export

server_radiotherapy <- function(input, output, session, iv) {

  dat_radiotherapy <- reactiveVal()

  observeEvent(input$pid, {

    dat_radiotherapy(
      get_dm()$radiotherapy %>%
        filter(pid == !!input$pid) %>%
        collect()
    )

    output$rt_table <- DT::renderDataTable({
      DT:: datatable(
        data = dat_radiotherapy() %>%
          select(pid, rt_type, rt_start, rt_end),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  observeEvent(req(input$rt_table_cell_clicked), {

    tmp <- dat_radiotherapy()
    tmp_ht <- get_dm()$hyperthermia %>%
      filter(pid == !!input$pid) %>%
      collect()

    rt_id <- tmp %>% slice(input$rt_table_rows_selected) %>% pull(rt_id)

    if (length(rt_id) != 0) {
      sel <- tmp %>% filter(.data$rt_id == .env$rt_id)
      sel_ht <- tmp_ht %>% filter(.data$ht_id == .env$rt_id)
    } else{
      sel <- tmp %>% slice(0)
      sel_ht <- tmp_ht %>% slice(0)
    }

    if(!isTruthy(pull(sel_ht, ht_combination))) {
      ht_combination <- "no"
    } else {
      ht_combination <- pull(sel_ht, ht_combination)
    }

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "rt_indication", val = pull(sel, rt_indication)),
      list(sess = session, fun = "updateSelectInput", id = "rt_type", val = pull(sel, rt_type)),
      list(sess = session, fun = "updateSelectInput", id = "rt_institution", val = pull(sel, rt_institution)),
      list(sess = session, fun = "updateNumericInput", id = "rt_total_dose", val = pull(sel, rt_total_dose)),
      list(sess = session, fun = "updateNumericInput", id = "rt_fractions", val = pull(sel, rt_fractions)),
      list(sess = session, fun = "updateNumericInput", id = "rt_ptv", val = pull(sel, rt_ptv)),
      list(sess = session, fun = "updateNumericInput", id = "rt_gtv", val = pull(sel, rt_gtv)),
      list(sess = session, fun = "updateSelectInput", id = "rt_previous_area", val = pull(sel, rt_previous_area)),
      list(sess = session, fun = "updateSelectInput", id = "rt_lymphedema", val = pull(sel, rt_lymphedema)),
      list(sess = session, fun = "updateSelectInput", id = "radiation_oncologist", val = pull(sel, radiation_oncologist)),
      list(sess = session, fun = "updateTextInput", id = "rt_comment", val = pull(sel, rt_comment)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_date_referral", val = pull(sel, rt_date_referral)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_date_first_consult", val = pull(sel, rt_date_first_consult)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_start", val = pull(sel, rt_start)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_end", val = pull(sel, rt_end)),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia", val = ht_combination),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_indication", val = pull(sel_ht, ht_indication)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_hyperthermia_start", val = pull(sel_ht, ht_start)),
      list(sess = session, fun = "updateAirDateInput", id = "rt_hyperthermia_end", val = pull(sel_ht, ht_end)),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_type", val = pull(sel_ht, ht_type)),
      list(sess = session, fun = "updateNumericInput", id = "rt_hyperthermia_sessions", val = pull(sel_ht, ht_sessions)),
      list(sess = session, fun = "updateTextInput", id = "rt_hyperthermia_schedule", val = pull(sel_ht, ht_schedule)),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_board", val = pull(sel_ht, ht_board_indication))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$rt_table_add, {

    df <- dat_radiotherapy() %>%
      select(pid, rt_type, rt_start, rt_end)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("rt_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "rt_indication", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_type", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_date_referral", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_date_first_consult", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_start", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_end", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_institution", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rt_total_dose", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rt_fractions", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rt_ptv", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rt_gtv", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_previous_area", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_lymphedema", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "radiation_oncologist", val = ""),
      list(sess = session, fun = "updateTextInput", id = "rt_comment", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia", val = "No"),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_indication", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_hyperthermia_start", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rt_hyperthermia_end", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_type", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rt_hyperthermia_sessions", val = ""),
      list(sess = session, fun = "updateTextInput", id = "rt_hyperthermia_schedule", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rt_hyperthermia_board", val = "")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$rt_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }
    if (input$rt_type == "") {
      iv$add_rule("rt_type", sv_required())
      showNotification("Type of radiotherapy is missing.")
      flag <- TRUE
    }
    if (length(input$rt_start) == 0) {
      iv$add_rule("rt_start", sv_required())
      showNotification("Start of radiotherapy is missing.")
      flag <- TRUE
    }
    if (input$rt_institution == "" | input$rt_institution == "Please choose institution") {
      iv$add_rule("rt_institution", sv_required())
      iv$add_rule("rt_institution", sv_not_equal("Please choose institution", message_fmt = "Not a valid institution."))
      showNotification("Institution of radiotherapy is missing or invalid.")
      flag <- TRUE
    }

    if (flag == FALSE) {
      rt_id <-  paste(input$pid, input$rt_start, input$rt_end, sep = "_")

      newtab <- tibble(
        pid = as.character(input$pid), # compound pk with pat_type & pat_date
        rt_id = rt_id,
        rt_indication = as.factor(input$rt_indication),
        rt_type = as.factor(input$rt_type),
        rt_date_referral = convert_null_date(input$rt_date_referral),
        rt_date_first_consult = convert_null_date(input$rt_date_first_consult),
        rt_start = as.Date(input$rt_start),
        rt_end = convert_null_date(input$rt_end),
        rt_institution = as.factor(input$rt_institution), # fk-constraint
        rt_total_dose = as.numeric(input$rt_total_dose),
        rt_fractions = as.numeric(input$rt_fractions),
        rt_ptv = as.numeric(input$rt_ptv),
        rt_gtv = as.numeric(input$rt_gtv),
        rt_previous_area = as.factor(input$rt_previous_area),
        rt_lymphedema = as.factor(input$rt_lymphedema),
        radiation_oncologist = as.character(input$radiation_oncologist), # fk-constraint to users
        rt_comment = as.character(input$rt_comment)
      )

      file <- input$rt_plan$datapath

      if (!is.null(file)) {
        newtab$rt_plan = # add column to df to upsert
          list(readBin(file, "raw", file.info(file)[["size"]]))
      }

      nr_rows_before <- nrow(dat_radiotherapy())

      rows_upsert(x = get_dm()$radiotherapy,
                  y = newtab,
                  by = c("pid", "rt_type", "rt_start"),
                  copy = TRUE,
                  in_place = TRUE)

      if (input$rt_hyperthermia == "yes: radiation-hyperthermia") {
        newtab_hyperthermia <- tibble(
          ht_id = rt_id,
          pid = as.character(input$pid),
          ht_combination = as.factor(input$rt_hyperthermia), # pk ht_combination and ht_start
          ht_type = as.factor(input$rt_hyperthermia_type),
          ht_indication = as.factor(input$rt_hyperthermia_indication),
          ht_start = convert_null_date(input$rt_hyperthermia_start),
          ht_end = convert_null_date(input$rt_hyperthermia_end),
          ht_sessions = as.numeric(input$rt_hyperthermia_sessions),
          ht_schedule = as.character(input$rt_hyperthermia_schedule),
          ht_board_indication = as.factor(input$rt_hyperthermia_board)
        )

        rows_upsert(x = get_dm()$hyperthermia,
                    y = newtab_hyperthermia,
                    by = c("pid", "ht_combination", "ht_start"),
                    copy = TRUE,
                    in_place = TRUE)
      }

      dat_radiotherapy(
        get_dm()$radiotherapy %>%
          filter(pid == !!input$pid) %>%
          collect()
        )

      nr_rows_after <- nrow(dat_radiotherapy())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("rt_table") %>%
          DT::replaceData(data = dat_radiotherapy() %>% select(pid, rt_type, rt_start, rt_end)) %>%
          DT::selectRows(input$rt_table_rows_selected)
      } else {
        DT::dataTableProxy("rt_table") %>%
          DT::replaceData(data = dat_radiotherapy() %>% select(pid, rt_type, rt_start, rt_end)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }

  })

  output$rt_plan_download <- renderUI({
    tmp <- dat_radiotherapy()

    rt_type <- tmp %>% slice(input$rt_table_rows_selected) %>% pull(rt_type)
    rt_start <- tmp %>% slice(input$rt_table_rows_selected) %>% pull(rt_start)

    if (length(rt_start) != 0 & length(rt_type) != 0) {
      tab <- dat_radiotherapy() %>%
        filter(.data$rt_start == .env$rt_start & .data$rt_type == .env$rt_type) %>%
        pull(rt_plan)

      if (isTRUE(!is.na(tab[length(tab)]))) {
        download <- fluidRow(
          column(4,
                 renderPrint(paste("File available: ",
                                   paste("radiotherapy", input$pid, input$rt_start, sep = "_"),
                                   ".pdf", sep = "")
                 )
          ),
          column(4,
                 downloadButton(outputId = "rt_plan_download_button",
                                label = "Download radiotherapy plan")
          )
        )

        replace <- fileInput(inputId = "rt_report",
                             label = "Replace radiotherapy plan",
                             multiple = FALSE,
                             accept = ".pdf")

        tagList(download, replace)
      }
    } else {
      fileInput(inputId = "rt_report",
                label = "Upload radiotherapy plan",
                multiple = FALSE,
                accept = ".pdf")
    }
  })



  output$rt_plan_download_button <- downloadHandler(
    filename = paste(paste("radiotherapy", input$pid, input$rt_start, sep = "_"), ".pdf", sep = ""),
    content = function(file) {
      tmp <- dat_radiotherapy()

      rt_type <- tmp %>% slice(input$rt_table_rows_selected) %>% pull(rt_type)
      rt_start <- tmp %>% slice(input$rt_table_rows_selected) %>% pull(rt_start)

      res <- tmp %>%
        filter(.data$rt_start == .env$rt_start & .data$rt_type == .env$rt_type) %>%
        pull(rt_plan)

      writeBin(res[[length(res)]], file)
    }
  )
}
