#' Server part of the "Surgery" tab
#' @description
#' All server functions for the "Surgery" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords surgery server
#'
#' @export

server_surgery <- function(input, output, session, iv) {

  dat_surgery <- reactiveVal()

  observeEvent(input$pid, {

    dat_surgery(
      get_dm()$surgery %>%
        filter(pid == !!input$pid) %>%
        collect()
    )

    output$sux_table <- DT::renderDataTable({
      DT:: datatable(
        data = dat_surgery() %>%
          select(pid, sux_date, sux_indication),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "sux_anatomic_region",
    tree = ssndb::create_tree("anatomic_region_name"),
    label = "anatomic region"
  )

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "sux_resection",
    tree = ssndb::create_tree("resection_name"),
    label = "resection",
    multiple = TRUE
  )

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "sux_reconstruction",
    tree = ssndb::create_tree("reconstruction_name"),
    label = "reconstruction",
    multiple = TRUE
  )

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "sux_amputation",
    tree = ssndb::create_tree("amputation_name"),
    label = "amputation",
    multiple = TRUE
  )

  tree_server(
    input = input,
    output = output,
    session = session,
    input_id = "sux_hemipelvectomy",
    tree = ssndb::create_tree("hemipelvectomy_name"),
    label = "hemipelvectomy",
    multiple = TRUE
  )

  observeEvent(input$sux_table_add, {

    df <- dat_surgery() %>%
      select(pid, sux_date, sux_indication)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("sux_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "sux_institution", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sux_indication", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "sux_date", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sux_side", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "sux_size", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "sux_margin", val = ""),
      list(sess = session, fun = "updateSelectizeInput", id = "sux_disciplines", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_anatomic_region_text", val = "Not (yet) determined"),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_resection_text", val = "Not applicable"),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_reconstruction_text", val = "Not applicable"),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_amputation_text", val = "Not applicable"),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_hemipelvectomy_text", val = "Not applicable")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })

  observeEvent(req(length(input$sux_table_cell_clicked) > 0), {
    tmp_surgery <- dat_surgery()
    sux_date <- tmp_surgery %>% slice(input$sux_table_rows_selected) %>% pull(sux_date)

    tmp_disciplines <- get_dm()$surgery_disciplines %>% filter(pid == !!input$pid)
    tmp_resection <- get_dm()$resection %>% filter(pid == !!input$pid)
    tmp_reconstruction <- get_dm()$reconstruction %>% filter(pid == !!input$pid)
    tmp_amputation <- get_dm()$amputation %>% filter(pid == !!input$pid)
    tmp_hemipelvectomy <- get_dm()$hemipelvectomy %>% filter(pid == !!input$pid)


    if (length(sux_date) > 0) {
      sel_surgery <- tmp_surgery %>% filter(.data$sux_date == .env$sux_date)
      sel_disciplines <- tmp_disciplines %>% filter(.data$sux_date == .env$sux_date)
      sel_resection <- tmp_resection %>% filter(.data$sux_date == .env$sux_date)
      sel_reconstruction <- tmp_reconstruction %>% filter(.data$sux_date == .env$sux_date)
      sel_amputation <- tmp_amputation %>% filter(.data$sux_date == .env$sux_date)
      sel_hemipelvectomy <- tmp_hemipelvectomy %>% filter(.data$sux_date == .env$sux_date)
    } else{
      sel_surgery <- tmp_surgery %>% slice(0)
      sel_disciplines <- tmp_disciplines %>% slice(0)
      sel_resection <- tmp_resection %>% slice(0)
      sel_reconstruction <- tmp_reconstruction %>% slice(0)
      sel_amputation <- tmp_amputation %>% slice(0)
      sel_hemipelvectomy <- tmp_hemipelvectomy %>% slice(0)
    }

    anatomic_reg <- sel_surgery %>% pull(sux_anatomic_region)
    resection <-  sel_resection %>% pull(resection_name)
    reconstruction <- sel_reconstruction %>% pull(reconstruction_name)
    amputation <- sel_amputation %>% pull(amputation_name)
    hemipelvectomy <- sel_hemipelvectomy %>% pull(hemipelvectomy_name)


    cfg <- list(
      list(sess = session, fun = "updateSelectInput", id = "sux_institution", val = pull(sel_surgery, sux_institution)),
      list(sess = session, fun = "updateSelectInput", id = "sux_indication", val = pull(sel_surgery, sux_indication)),
      list(sess = session, fun = "updateSelectInput", id = "sux_side", val = pull(sel_surgery, sux_side)),
      list(sess = session, fun = "updateNumericInput", id = "sux_size", val = pull(sel_surgery, sux_size)),
      list(sess = session, fun = "updateSelectInput", id = "sux_margin", val = pull(sel_surgery, sux_margin)),
      list(sess = session, fun = "updateAirDateInput", id = "sux_date", val = pull(sel_surgery, sux_date)),
      list(sess = session, fun = "updateTreeview", id = "sux_anatomic_region", val = pull(sel_surgery, sux_anatomic_region)),
      list(sess = session, fun = "updateSelectizeInput", id = "sux_disciplines", val = pull(sel_disciplines, discipline)),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_anatomic_region_text", val = convert_for_tree(anatomic_reg, "anatomic_region")),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_resection_text", val = convert_for_tree(resection, "resection_name")),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_reconstruction_text", val = convert_for_tree(reconstruction, "reconstruction_name")),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_amputation_text", val = convert_for_tree(amputation, "amputation_name")),
      list(sess = session, fun = "updateTextAreaInput", id = "sux_hemipelvectomy_text", val = convert_for_tree(hemipelvectomy, "hemipelvectomy_name"))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }

  })

  observeEvent(input$sux_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }

    if (length(input$sux_date) == 0) {
      iv$add_rule("sux_date", sv_required())
      showNotification("Date of surgery is missing.")
      flag <- TRUE
    }

    if (input$sux_institution == "" | input$sux_institution == "Please choose institution") {
      iv$add_rule("sux_institution", sv_required())
      iv$add_rule("sux_institution", sv_not_equal("Please choose institution", message_fmt = "Not a valid institution."))
      showNotification("Institution of surgery is missing.")
      flag <- TRUE
    }

    if (flag == FALSE) {
      if (input$sux_1strevision != "") {
        sux_indication_details <- as.character(input$sux_1strevision)
      } else {
        if (input$sux_2ndrevision != "") {
          sux_indication_details <- as.character(input$sux_2ndrevision)
        } else {
          if (input$sux_other_reason != "") {
            sux_indication_details <- as.character(input$sux_other_reason)
          } else {
            sux_indication_details <- ""
          }
        }
      }

      ##### Surgery #####

      newtab_surgery <- data.frame(
        pid = as.character(input$pid), # compund pk with sux_date
        sux_date = convert_null_date(input$sux_date),
        sux_institution = as.factor(input$sux_institution), #fk-constraint
        sux_indication = as.factor(input$sux_indication),
        sux_indication_details = sux_indication_details,
        sux_side = as.factor(input$sux_side),
        sux_anatomic_region = convert_for_tree(input$sux_anatomic_region_text, "anatomic_region"), # fk-constraint
        sux_size = as.numeric(input$sux_size),
        sux_margin = as.factor(input$sux_margin)
      )

      dm <- get_dm()

      nr_rows_before <- nrow(dat_surgery())


      rows_upsert(x = dm$surgery,
                  y = newtab_surgery,
                  by = c("pid", "sux_date"),
                  copy = TRUE,
                  in_place = TRUE)

      ##### Resection #####

      if (input$sux_resection_text != "Not applicable") {
        newtab_resection <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          resection_name =  stringr::str_split(input$sux_resection_text, ",")[[1]]
        )
        } else {
          newtab_resection <- data.frame(
            pid = as.character(input$pid),
            sux_date = as.Date(input$sux_date),
            resection_name = "Not applicable"
          )
        }

      tab_resection <- dm$resection %>%
        filter(pid == !!input$pid & sux_date == !!input$sux_date) %>%
        collect()

      if (nrow(setdiff(x = tab_resection, newtab_resection)) > 0) {
        rows_delete(x = dm$resection,
                    y = setdiff(x = tab_resection, y= newtab_resection),
                    by = c("pid", "sux_date", "resection_name"),
                    copy = TRUE,
                    in_place = TRUE,
                    unmatched = "ignore")
      }
      if (nrow(setdiff(x = newtab_resection, y = tab_resection)) > 0 &
          all(newtab_resection$resection_name  != "Not applicable")) {
        rows_insert(
          x = dm$resection,
          y = newtab_resection,
          by = c("pid", "sux_date", "resection_name"),
          copy = TRUE,
          in_place = TRUE,
          conflict = "ignore")
      }

      ##### Reconstruction #####

      if (input$sux_reconstruction_text != "Not applicable") {
        newtab_reconstruction <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          reconstruction_name =  stringr::str_split(input$sux_reconstruction_text, ",")[[1]]
        )
      } else {
        newtab_reconstruction <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          reconstruction_name = "Not applicable"
        )
      }

      tab_reconstruction <- dm$reconstruction %>%
        filter(pid == !!input$pid & sux_date == !!input$sux_date) %>%
        collect()

      if (nrow(setdiff(x = tab_reconstruction, newtab_reconstruction)) > 0) {
        rows_delete(x = dm$reconstruction,
                    y = setdiff(x = tab_reconstruction, y= newtab_reconstruction),
                    by = c("pid", "sux_date", "reconstruction_name"),
                    copy = TRUE,
                    in_place = TRUE,
                    unmatched = "ignore")
      }
      if (nrow(setdiff(x = newtab_reconstruction, y = tab_reconstruction)) > 0 &
          all(newtab_reconstruction$reconstruction_name  != "Not applicable")) {
        rows_insert(
          x = dm$reconstruction,
          y = newtab_reconstruction,
          by = c("pid", "sux_date", "reconstruction_name"),
          copy = TRUE,
          in_place = TRUE,
          conflict = "ignore")
      }

      ##### Amputation #####

      if (input$sux_amputation_text != "Not applicable") {
        newtab_amputation <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          amputation_name =  stringr::str_split(input$sux_amputation_text, ",")[[1]]
        )
      } else {
        newtab_amputation <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          amputation_name = "Not applicable"
        )
      }

      tab_amputation <- dm$amputation %>%
        filter(pid == !!input$pid & sux_date == !!input$sux_date) %>%
        collect()

      if (nrow(setdiff(x = tab_amputation, newtab_amputation)) > 0) {
        rows_delete(x = dm$amputation,
                    y = setdiff(x = tab_amputation, y= newtab_amputation),
                    by = c("pid", "sux_date", "amputation_name"),
                    copy = TRUE,
                    in_place = TRUE,
                    unmatched = "ignore")
      }
      if (nrow(setdiff(x = newtab_amputation, y = tab_amputation)) > 0 &
          all(newtab_amputation$reconstruction_name  != "Not applicable")) {
        rows_insert(
          x = dm$amputation,
          y = newtab_amputation,
          by = c("pid", "sux_date", "amputation_name"),
          copy = TRUE,
          in_place = TRUE,
          conflict = "ignore")
      }

      ##### Hemipelvectomy #####

      if (input$sux_hemipelvectomy_text != "Not applicable") {
        newtab_hemipelvectomy <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          hemipelvectomy_name = stringr::str_split(input$sux_hemipelvectomy_text, ",")[[1]]
        )
      } else {
        newtab_hemipelvectomy <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          hemipelvectomy_name = "Not applicable"
        )
      }

      tab_hemipelvectomy <- dm$hemipelvectomy %>%
        filter(pid == !!input$pid & sux_date == !!input$sux_date) %>%
        collect()

      if (nrow(setdiff(x = tab_hemipelvectomy, newtab_hemipelvectomy)) > 0) {
        rows_delete(x = dm$hemipelvectomy,
                    y = setdiff(x = tab_hemipelvectomy, y= newtab_hemipelvectomy),
                    by = c("pid", "sux_date", "hemipelvectomy_name"),
                    copy = TRUE,
                    in_place = TRUE,
                    unmatched = "ignore")
      }
      if (nrow(setdiff(x = newtab_hemipelvectomy, y = tab_hemipelvectomy)) > 0 &
          all(newtab_hemipelvectomy$hemipelvectomy_name  != "Not applicable")) {
        rows_insert(
          x = dm$hemipelvectomy,
          y = newtab_hemipelvectomy,
          by = c("pid", "sux_date", "hemipelvectomy_name"),
          copy = TRUE,
          in_place = TRUE,
          conflict = "ignore")
      }

      ##### Sux disciplines #####

      if (length(input$sux_disciplines) > 0) {
      newtab_sux_disciplines <- data.frame(
        pid = as.character(input$pid),
        sux_date = as.Date(input$sux_date),
        discipline = as.character(input$sux_disciplines)
        )
      } else{
        newtab_sux_disciplines <- data.frame(
          pid = as.character(input$pid),
          sux_date = as.Date(input$sux_date),
          discipline = ""
          )
      }

      tab_sux_disciplines <- dm$surgery_disciplines %>%
        filter(pid == !!input$pid & sux_date == !!input$sux_date) %>%
        collect()

      if (nrow(setdiff(x = tab_sux_disciplines, newtab_sux_disciplines)) > 0) {
        rows_delete(x = dm$surgery_disciplines,
                    y = setdiff(x = tab_sux_disciplines, y= newtab_sux_disciplines),
                    by = c("pid", "sux_date", "discipline"),
                    copy = TRUE,
                    in_place = TRUE,
                    unmatched = "ignore")
      }
      if (nrow(setdiff(x = newtab_sux_disciplines, y = tab_sux_disciplines)) > 0 &
          all(newtab_sux_disciplines$discipline != "")) {
        rows_insert(
          x = dm$surgery_disciplines,
          y = newtab_sux_disciplines,
          by = c("pid", "sux_date", "discipline"),
          copy = TRUE,
          in_place = TRUE,
          conflict = "ignore")
      }

      dat_surgery(
        get_dm()$surgery %>%
          filter(pid == !!input$pid) %>%
          collect()
      )

      nr_rows_after <- nrow(dat_surgery())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("sux_table") %>%
          DT::replaceData(data = dat_surgery() %>% select(pid, sux_date, sux_indication)) %>%
          DT::selectRows(input$sux_table_rows_selected)
      } else {
        DT::dataTableProxy("sux_table") %>%
          DT::replaceData(data = dat_surgery() %>% select(pid, sux_date, sux_indication)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }
  })
}
