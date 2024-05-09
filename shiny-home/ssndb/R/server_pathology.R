#' Server part of the "Pathology" tab
#' @description
#' All server functions for the "Pathology" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords pathology server
#'
#' @export

server_pathology <- function(input, output, session, iv) {

  dat_pathology <- reactiveVal()

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "pat_diagnosis",
    tree = ssndb::create_tree("diagnosis_who"),
    label = "WHO 2013 diagnosis",
    multiple = FALSE
  )

  observeEvent(input$pid, {

    dat_pathology(
      get_dm()$pathology %>%
        filter(pid == !!input$pid) %>%
        collect()
      )

    output$pat_table <- DT::renderDataTable({
      DT::datatable(
        data = dat_pathology() %>%
          select(pid, pat_type, pat_date),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  observeEvent(req(input$pat_table_cell_clicked), {

    tmp <- dat_pathology()

    pat_date <- tmp %>% slice(input$pat_table_rows_selected) %>% pull(pat_date)
    pat_type <- tmp %>% slice(input$pat_table_rows_selected) %>% pull(pat_type)

    if (length(pat_date) != 0 & length(pat_date) != 0) {
      sel <- tmp %>% filter(.data$pat_date == .env$pat_date & .data$pat_type == .env$pat_type)
    } else {
      sel <- tmp %>% slice(0)
    }

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "pat_type", val = pull(sel, pat_type)),
      list(sess = session, fun = "updateSelectInput", id = "pat_type_biopsy", val = pull(sel, pat_type_biopsy)),
      list(sess = session, fun = "updateSelectInput", id = "pat_pathologist", val = pull(sel, pathologist)),
      list(sess = session, fun = "updateSelectInput", id = "pat_priortx", val = pull(sel, pat_priortx)),
      list(sess = session, fun = "updateSelectInput", id = "pat_reference", val = pull(sel, pat_reference)),
      list(sess = session, fun = "updateSelectInput", id = "pat_review_result", val = pull(sel, pat_review_result)),
      list(sess = session, fun = "updateSelectInput", id = "pat_grade", val = pull(sel, grade)),
      list(sess = session, fun = "updateSelectInput", id = "pat_margin", val = pull(sel, pat_margin)),
      list(sess = session, fun = "updateSelectInput", id = "pat_mib", val = pull(sel, mib)),
      list(sess = session, fun = "updateSelectInput", id = "pat_mitoses", val = pull(sel, mitoses)),
      list(sess = session, fun = "updateSelectInput", id = "pat_necrosis", val = pull(sel, necrosis)),
      list(sess = session, fun = "updateNumericInput", id = "pat_distance_margin", val = pull(sel, distance_margin)),
      list(sess = session, fun = "updateSelectInput", id = "pat_biological_barrier", val = pull(sel, biological_barrier)),
      list(sess = session, fun = "updateSelectInput", id = "pat_ihc", val = pull(sel, ihc)),
      list(sess = session, fun = "updateSelectInput", id = "pat_fish", val = pull(sel, fish)),
      list(sess = session, fun = "updateSelectInput", id = "pat_rna", val = pull(sel, rna)),
      list(sess = session, fun = "updateSelectInput", id = "pat_dna", val = pull(sel, dna)),
      list(sess = session, fun = "updateSelectInput", id = "pat_ihc_result", val = pull(sel, ihc_result)),
      list(sess = session, fun = "updateSelectInput", id = "pat_fish_result", val = pull(sel, fish_result)),
      list(sess = session, fun = "updateSelectInput", id = "pat_rna_result", val = pull(sel, rna_result)),
      list(sess = session, fun = "updateSelectInput", id = "pat_dna_result", val = pull(sel, dna_result)),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date", val = pull(sel, pat_date)),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_registrate", val = pull(sel, pat_date_registrate)),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report", val = pull(sel, pat_date_report)),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report_final", val = pull(sel, pat_date_report_final)),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report_reference", val = pull(sel, pat_date_report_reference)),
      list(sess = session, fun = "updateTextAreaInput", id = "pat_diagnosis_text", val = pull(sel, diagnosis_name))

    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$pat_table_add, {

    df <- dat_pathology() %>%
      select(pid, pat_type, pat_date)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("pat_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "pat_type", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_type_biopsy", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_registrate", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report_final", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "pat_date_report_reference", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_pathologist", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_priortx", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_reference", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_review_result", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_grade", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_margin", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_mib", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_mitoses", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_necrosis", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "pat_distance_margin", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_biological_barrier", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_ihc", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_fish", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_rna", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_dna", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_ihc_result", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_fish_result", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_rna_result", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "pat_dna_result", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "pat_diagnosis_text", val = pull(sel, diagnosis_name))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$pat_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }

    if (input$pat_type == "") {
      iv$add_rule("pat_type", sv_required())
      showNotification("Type of data entry is missing.")
      flag <- TRUE
    }

    if (length(input$pat_date) == 0) {
      iv$add_rule("pat_date", sv_required())
      showNotification("Date of biopsy/resection is missing.")
      flag <- TRUE
    }

    if (flag == FALSE) {
      newtab <- tibble(
        pid = as.character(input$pid), # compound pk with pat_type & pat_date
        pat_type = as.factor(input$pat_type),
        pat_type_biopsy = as.factor(input$pat_type_biopsy),
        pathologist = as.character(input$pat_pathologist),
        pat_date = convert_null_date(input$pat_date),
        pat_date_registrate = convert_null_date(input$pat_date_registrate),
        pat_date_report = convert_null_date(input$pat_date_report),
        pat_date_report_final = convert_null_date(input$pat_date_report_final),
        pat_reference = as.factor(input$pat_reference),
        pat_date_report_reference = convert_null_date(input$pat_date_report_reference),
        pat_review_result = as.factor(input$pat_review_result),
        pat_priortx = as.factor(input$pat_priortx),
        mib = as.factor(input$pat_mib),
        mitoses = as.factor(input$pat_mitoses),
        grade = as.factor(input$pat_grade),
        pat_margin = as.factor(input$pat_margin),
        necrosis = as.factor(input$pat_necrosis),
        distance_margin = as.numeric(input$pat_distance_margin),
        biological_barrier = as.factor(input$pat_biological_barrier),
        ihc = as.factor(input$pat_ihc),
        ihc_result = as.factor(input$pat_ihc_result),
        fish = as.factor(input$pat_fish),
        fish_result = as.factor(input$pat_fish_result),
        rna = as.factor(input$pat_rna),
        rna_result = as.factor(input$pat_rna_result),
        dna = as.factor(input$pat_dna),
        dna_result = as.factor(input$pat_dna_result),
        diagnosis_name = as.factor(input$pat_diagnosis_text)
      )

      file <- input$pat_report$datapath

      if (!is.null(file)) {
        newtab$pat_report =
          list(readBin(file, "raw", file.info(file)[["size"]]))
      }

      nr_rows_before <- nrow(dat_pathology())

      rows_upsert(x = get_dm()$pathology,
                  y = newtab,
                  by = c("pid", "pat_date", "pat_type"),
                  copy = TRUE,
                  in_place = TRUE)

      dat_pathology(
        get_dm()$pathology %>%
          filter(pid == !!input$pid) %>%
          collect()
      )

      nr_rows_after <- nrow(dat_pathology())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("pat_table") %>%
          DT::replaceData(data = dat_pathology() %>% select(pid, pat_type, pat_date)) %>%
          DT::selectRows(input$pat_table_rows_selected)
      } else {
        DT::dataTableProxy("pat_table") %>%
          DT::replaceData(data = dat_pathology() %>% select(pid, pat_type, pat_date)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }
  })

  output$pat_report_download <- renderUI({
    pat_date <- dat_pathology() %>% slice(input$pat_table_rows_selected) %>% pull(pat_date)
    pat_type <- dat_pathology() %>% slice(input$pat_table_rows_selected) %>% pull(pat_type)

    if (length(pat_date) != 0 & length(pat_type) != 0) {
      tab <- dat_pathology() %>%
        filter(.data$pat_date == .env$pat_date & .data$pat_type == .env$pat_type) %>%
        pull(pat_report)

      if (isTRUE(!is.na(tab[length(tab)]))) {
        download <- fluidRow(
          column(4,
                 renderPrint(paste("File available: ",
                                   paste("pathology", input$pid, input$pat_date, sep = "_"),
                                   ".pdf",sep = "")
                 )
          ),
          column(4,
                 downloadButton(outputId = "pat_report_download_button",
                                label = "Download pathology report")
          )
        )

        replace <- fileInput(inputId = "pat_report",
                             label = "Replace pathology report (one file only!)",
                             multiple = FALSE,
                             accept = ".pdf")

        tagList(download, replace)
      } else {
        fileInput(inputId = "pat_report",
                  label = "Upload pathology report (one file only!)",
                  multiple = FALSE,
                  accept = ".pdf")
      }
      } else {
      fileInput(inputId = "pat_report",
                label = "Upload pathology report (one file only!)",
                multiple = FALSE,
                accept = ".pdf")

      }
  })

  output$pat_report_download_button <- downloadHandler(
    filename = paste(paste("pathology", input$pid, input$pat_date, sep = "_"), ".pdf", sep = ""),
    content = function(file) {
      tmp <- dat_pathology()
      pat_date <- tmp %>% slice(input$pat_table_rows_selected) %>% pull(pat_date)
      pat_type <- tmp %>% slice(input$pat_table_rows_selected) %>% pull(pat_type)
      res <- tmp %>%
        filter(.data$pat_date == .env$pat_date & .data$pat_type == .env$pat_type) %>%
        pull(pat_report)
      writeBin(res[[length(res)]], file)
    }
  )

}
