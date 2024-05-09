#' Server part of the "Radiology" tab
#' @description
#' All server functions for the "Radiology" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords radiology server
#'
#' @export

server_radiology <- function(input, output, session, iv) {

  dat_radiology <- reactiveVal()

  observeEvent(input$pid, {

    dat_radiology(get_dm()$radiology %>%
                  filter(pid == !!input$pid) %>%
                  collect()
                 )

    output$rad_table <- DT::renderDataTable({
      DT:: datatable(
        data = dat_radiology() %>%
          select(pid, rad_date, rad_timing, rad_type, rad_exam),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  display_radiology_response(input = input, output = output, session = session)

  observeEvent(req(input$rad_table_cell_clicked), {

    tmp <- dat_radiology()

    rad_date <- tmp %>% slice(input$rad_table_rows_selected) %>% pull(rad_date)
    rad_type <- tmp %>% slice(input$rad_table_rows_selected) %>% pull(rad_type)

    if (length(rad_date) != 0 & length(rad_type) != 0) {
      sel <- tmp %>% filter(.data$rad_date == .env$rad_date & .data$rad_type == .env$rad_type)
    } else {
      sel <- tmp %>% slice(0)
    }

    cfg <- list(
      list(sess = session, fun = "updateAirDateInput", id = "rad_date", val = pull(sel, rad_date)),
      list(sess = session, fun = "updateSelectInput", id = "rad_timing", val = pull(sel, rad_timing)),
      list(sess = session, fun = "updateSelectInput", id = "rad_type", val = pull(sel, rad_type)),
      list(sess = session, fun = "updateSelectizeInput", id = "rad_exam", val = pull(sel, rad_exam)),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeA", val = pull(sel, size_a)),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeB", val = pull(sel, size_b)),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeC", val = pull(sel, size_c)),
      list(sess = session, fun = "updateSelectInput", id = "rad_fascia", val = pull(sel, fascia)),
      list(sess = session, fun = "updateSelectInput", id = "rad_recist", val = pull(sel, recist)),
      list(sess = session, fun = "updateSelectInput", id = "rad_choi", val = pull(sel, choi)),
      list(sess = session, fun = "updateSelectInput", id = "rad_irecist", val = pull(sel, irecist)),
      list(sess = session, fun = "updateSelectInput", id = "rad_percist", val = pull(sel, percist)),
      list(sess = session, fun = "updateTextAreaInput", id = "rad_report_text", val = pull(sel, rad_report_text))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(input$rad_table_add, {

    df <- dat_radiology() %>%
      select(pid, rad_date, rad_timing, rad_type, rad_exam)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("rad_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "rad_timing", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_type", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "rad_date", val = ""),
      list(sess = session, fun = "updateSelectizeInput", id = "rad_exam", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeA", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeB", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "rad_sizeC", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_fascia", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_recist", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_choi", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_irecist", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "rad_percist", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "rad_report_text", val = "")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }

  })

  observeEvent(input$rad_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }

    if (length(input$rad_date) == 0) {
      iv$add_rule("rad_date", sv_required())
      showNotification("Date of radiology is missing.")
      flag <- TRUE
    }

    if (input$rad_type == "") {
      iv$add_rule("rad_type", sv_required())
      showNotification("Type of imaging is missing.")
      flag <- TRUE
    }

    if (flag == FALSE) {
      newtab <- tibble(
        pid = as.character(input$pid),
        rad_date = convert_null_date(input$rad_date),
        rad_timing = as.factor(input$rad_timing),
        rad_type = as.factor(input$rad_type),
        rad_exam = as.factor(input$rad_exam),
        size_a = as.numeric(input$rad_sizeA),
        size_b = as.numeric(input$rad_sizeB),
        size_c = as.numeric(input$rad_sizeC),
        fascia = as.factor(input$rad_fascia),
        recist = as.factor(input$rad_recist),
        choi = as.factor(input$rad_choi),
        percist = as.factor(input$rad_percist),
        irecist = as.factor(input$rad_irecist),
        rad_report_text = as.character(input$rad_report_text)
        )

      file <- input$rad_report$datapath

      if (!is.null(file)) {
        newtab$rad_report =
          list(readBin(file, "raw", file.info(file)[["size"]]))
      }

      if (input$rad_metastasis == "Yes") {
        newtab_metastasis <- data.frame(
          pid = as.character(input$pid),
          rad_date = convert_null_date(input$rad_date),
          rad_type = as.factor(input$rad_type),
          met_number = as.numeric(input$rad_metastasis_nr),
          met_location = as.factor(input$rad_metastasis_location)
          )

        rows_upsert(x = get_dm()$metastasis,
                    y = newtab_metastasis,
                    by = c("pid", "rad_date", "met_location"),
                    copy = TRUE,
                    in_place = TRUE)
      }

      nr_rows_before <- nrow(dat_radiology())

      rows_upsert(x = get_dm()$radiology,
                  y = newtab,
                  by = c("pid", "rad_date", "rad_type"),
                  copy = TRUE,
                  in_place = TRUE)

      dat_radiology(
        get_dm()$radiology %>%
          filter(pid == !!input$pid) %>%
          collect()
        )

      nr_rows_after <- nrow(dat_radiology())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("rad_table") %>%
          DT::replaceData(data = dat_radiology() %>% select(pid, rad_date, rad_timing, rad_type, rad_exam)) %>%
          DT::selectRows(input$rad_table_rows_selected)
      } else{
        DT::dataTableProxy("rad_table") %>%
          DT::replaceData(data = dat_radiology() %>% select(pid, rad_date, rad_timing, rad_type, rad_exam)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }
  })

  output$rad_report_download <- renderUI({
    rad_date <- dat_radiology() %>% slice(input$rad_table_rows_selected) %>% pull(rad_date)
    rad_type <- dat_radiology() %>% slice(input$rad_table_rows_selected) %>% pull(rad_type)

    if (length(rad_date) != 0 & length(rad_type) != 0) {
      tab <- dat_radiology() %>%
        filter(.data$rad_date == .env$rad_date & .data$rad_type == .env$rad_type) %>%
        pull(rad_report)

      if (isTRUE(!is.na(tab[length(tab)]))) {
       download <- fluidRow(
          column(4,
            renderPrint(paste("File available: ",
                              paste("radiology", input$pid, input$rad_date, sep = "_"),
                              ".pdf",sep = "")
                 )
            ),
          column(4,
            downloadButton(outputId = "rad_report_download_button",
                           label = "Download radiology report")
          )
        )

       replace <- fileInput(inputId = "rad_report",
                      label = "Replace radiology report",
                      multiple = FALSE,
                      accept = ".pdf")

       tagList(download, replace)
      } else {
        fileInput(inputId = "rad_report",
                  label = "Upload radiology report",
                  multiple = FALSE,
                  accept = ".pdf")
      }
    } else {
      fileInput(inputId = "rad_report",
                label = "Upload radiology report",
                multiple = FALSE,
                accept = ".pdf")
    }
  })

  output$rad_report_download_button <- downloadHandler(
    filename = paste(paste("radiology", input$pid, input$rad_date, sep = "_"), ".pdf", sep = ""),
    content = function(file) {
      tmp <- dat_radiology()
      rad_date <- tmp %>% slice(input$rad_table_rows_selected) %>% pull(rad_date)
      rad_type <- tmp %>% slice(input$rad_table_rows_selected) %>% pull(rad_type)
      res <- tmp %>%
        filter(.data$rad_date == .env$rad_date & .data$rad_type == .env$rad_type) %>%
        pull(rad_report)
      writeBin(res[[length(res)]], file)
    }
  )

}
