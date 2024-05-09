#' Server part of the "Systemic therapy" tab
#' @description
#' All server functions for the "Systemic therapy" tab (in page_navbar())
#'
#' @param input input from Shiny
#' @param output output to Shiny
#' @param session Shiny session
#' @param iv InputValidator from the shinyvalidate package
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#' @keywords systemic server
#'
#' @export

server_syst <- function(input, output, session, iv) {

  dat <- get_systemic_drug()
  used_drugs <- dat %>% pull(drug)
  args <- list(
    drug = list(
      choices = levels(dat$drug),
      selected = "")
  )
  edit_cols <- setdiff(colnames(dat), "systemic_therapy_id") # editable columns

  df <- get_systemic_toxicity() %>% select(-toxicity_type)
  args_tox <- list(
    toxicity_name = list(
      choices = levels(df$toxicity_name),
      selected = "")
  )
  edit_cols_tox <- setdiff(colnames(df), "systemic_therapy_id") # editable columns


  dat_systemic_therapy <- reactiveVal()

  observeEvent(input$pid, {

    dat_systemic_therapy(
      get_dm()$systemic_therapy %>%
        filter(pid == !!input$pid) %>%
        collect()
    )

    output$syst_table <- DT::renderDataTable({

      DT:: datatable(
        data = dat_systemic_therapy() %>%
          select(pid, syst_start, syst_end),
        selection = "single",
        options = list(dom = 't')
      )
    })
  })

  observeEvent(input$syst_table_add, {

    df <- dat_systemic_therapy() %>%
      select(pid, syst_start, syst_end)

    df[nrow(df)+1, ] <- NA

    DT::dataTableProxy("syst_table") %>%
      DT::replaceData(data = df) %>%
      DT::selectRows(selected = nrow(df))

    cfg <- list(
      list(sess = session, fun = "updateSelectizeInput", id = "syst_reason", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "syst_start", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "syst_end", val = ""),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_bone_protocol", val = ""),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_softtissue_protocol", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_oncologist", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_institution", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_reason_discontinuation", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_cycles_planned", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "syst_line", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_rct", val = ""),
      list(sess = session, fun = "updateTextAreaInput", id = "syst_comment", val = ""),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_clinical_trial", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia", val = "No"),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_indication", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "syst_hyperthermia_start", val = ""),
      list(sess = session, fun = "updateAirDateInput", id = "syst_hyperthermia_end", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_type", val = ""),
      list(sess = session, fun = "updateNumericInput", id = "syst_hyperthermia_sessions", val = ""),
      list(sess = session, fun = "updateTextInput", id = "syst_hyperthermia_schedule", val = ""),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_board", val = "")
    )

    for (x in cfg) {
      do.call(update_field, x)
    }
  })


  observeEvent(input$syst_submit, {
    flag <- FALSE

    if (input$pid == "" | input$pid == "Edit existing patient") {
      showNotification("PID is missing.")
      flag <- TRUE
    }
    if (length(input$syst_start) == 0) {
      iv$add_rule("syst_start", sv_required())
      showNotification("Start date of systemic therapy is missing.")
      flag <- TRUE
    }
    if (length(input$syst_end) == 0) {
      iv$add_rule("syst_end", sv_required())
      showNotification("End date of systemic therapy is missing.")
      flag <- TRUE
    }

    if (input$syst_institution == "" | input$syst_institution == "Please choose institution") {
      iv$add_rule("syst_institution", sv_required())
      iv$add_rule("syst_institution", sv_not_equal("Please choose institution", message_fmt = "Not a valid institution."))
      showNotification("Institution of systemic therapy is missing or invalid.")
      flag <- TRUE
    }

    if (flag == FALSE) {
      systemic_therapy_id <-  paste(input$pid, input$syst_start, input$syst_end, sep = "_")

      systemic_therapy <- data.frame(
        pid = as.character(input$pid), # pk with systemic_therapy_cycle_id
        systemic_therapy_id = as.character(systemic_therapy_id),
        syst_reason = as.factor(input$syst_reason),
        syst_cycles_planned = as.numeric(input$syst_cycles_planned),
        syst_institution = as.factor(input$syst_institution), # fk-constraint from institution: institution_name
        syst_start = convert_null_date(input$syst_start),
        syst_end = convert_null_date(input$syst_end),
        syst_line = as.numeric(input$syst_line),
        syst_bone_protocol = as.factor(input$syst_bone_protocol),
        syst_softtissue_protocol = as.factor(input$syst_softtissue_protocol),
        syst_reason_discontinuation = as.factor(input$syst_reason_discontinuation),
        syst_rct = as.factor(input$syst_rct),
        syst_clinical_trial = as.factor(input$syst_clinical_trial),
        syst_comment = as.character(input$syst_comment),
        oncologist = as.character(input$syst_oncologist)
      )

      nr_rows_before <- nrow(dat_systemic_therapy())

      rows_upsert(x = get_dm()$systemic_therapy,
                  y = systemic_therapy,
                  by = c("pid", "systemic_therapy_id"),
                  copy = TRUE,
                  in_place = TRUE)

      if (input$syst_hyperthermia == "yes: chemotherapy-hyperthermia") {

        newtab_hyperthermia <- tibble(
          ht_id = as.character(systemic_therapy_id),
          pid = as.character(input$pid),
          ht_combination = as.factor(input$syst_hyperthermia), # pk ht_combination and ht_start
          ht_type = as.factor(input$syst_hyperthermia_type),
          ht_indication = as.factor(input$syst_hyperthermia_indication),
          ht_start = convert_null_date(input$syst_hyperthermia_start),
          ht_end = convert_null_date(input$syst_hyperthermia_end),
          ht_sessions = as.numeric(input$syst_hyperthermia_sessions),
          ht_schedule = as.character(input$syst_hyperthermia_schedule),
          ht_board_indication = as.factor(input$syst_hyperthermia_board)
        )

        rows_upsert(x = get_dm()$hyperthermia,
                    y = newtab_hyperthermia,
                    by = c("pid", "ht_combination", "ht_start"),
                    copy = TRUE,
                    in_place = TRUE)
      }

      dat_systemic_therapy(
        get_dm()$systemic_therapy %>%
          filter(pid == !!input$pid) %>%
          collect()
      )

      nr_rows_after <- nrow(dat_systemic_therapy())

      if (nr_rows_before == nr_rows_after) {
        DT::dataTableProxy("syst_table") %>%
          DT::replaceData(data = dat_systemic_therapy() %>% select(pid, syst_start, syst_end)) %>%
          DT::selectRows(input$syst_table_rows_selected)
      } else {
        DT::dataTableProxy("syst_table") %>%
          DT::replaceData(data = dat_systemic_therapy() %>% select(pid, syst_start, syst_end)) %>%
          DT::selectRows(nr_rows_after)
      }

      showNotification("Data were submitted successfully.")
    }
  })

  syst_drug <- reactiveVal(get_systemic_drug() %>% slice(0))
  syst_tox <- reactiveVal(get_systemic_toxicity() %>% slice(0))

  observeEvent(req(input$syst_table_cell_clicked), {

    tmp <- dat_systemic_therapy()
    tmp_ht <- get_dm()$hyperthermia %>%
      filter(pid == !!input$pid) %>%
      collect()

    systemic_therapy_id <- tmp %>% slice(input$syst_table_rows_selected) %>% pull(systemic_therapy_id)

    if (length(systemic_therapy_id) != 0) {
      sel <- tmp %>% filter(.env$systemic_therapy_id == .data$systemic_therapy_id)
      sel_ht <- tmp_ht %>% filter(.data$ht_id == .env$systemic_therapy_id)
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
      list(sess = session, fun = "updateSelectizeInput", id = "syst_reason", val = pull(sel, syst_reason)),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_bone_protocol", val = pull(sel, syst_bone_protocol)),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_softtissue_protocol", val = pull(sel, syst_softtissue_protocol)),
      list(sess = session, fun = "updateSelectInput", id = "syst_oncologist", val = pull(sel, oncologist)),
      list(sess = session, fun = "updateSelectInput", id = "syst_institution", val = pull(sel, syst_institution)),
      list(sess = session, fun = "updateSelectInput", id = "syst_reason_discontinuation", val = pull(sel, syst_reason_discontinuation)),
      list(sess = session, fun = "updateSelectInput", id = "syst_cycles_planned", val = pull(sel, syst_cycles_planned)),
      list(sess = session, fun = "updateNumericInput", id = "syst_line", val = pull(sel, syst_line)),
      list(sess = session, fun = "updateSelectInput", id = "syst_rct", val = pull(sel, syst_rct)),
      list(sess = session, fun = "updateTextAreaInput", id = "syst_comment", val = pull(sel, syst_comment)),
      list(sess = session, fun = "updateSelectizeInput", id = "syst_clinical_trial", val = pull(sel, syst_clinical_trial)),
      list(sess = session, fun = "updateAirDateInput", id = "syst_start", val = pull(sel, syst_start)),
      list(sess = session, fun = "updateAirDateInput", id = "syst_end", val = pull(sel, syst_end)),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia", val = ht_combination),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_indication", val = pull(sel_ht, ht_indication)),
      list(sess = session, fun = "updateAirDateInput", id = "syst_hyperthermia_start", val = pull(sel_ht, ht_start)),
      list(sess = session, fun = "updateAirDateInput", id = "syst_hyperthermia_end", val = pull(sel_ht, ht_end)),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_type", val = pull(sel_ht, ht_type)),
      list(sess = session, fun = "updateNumericInput", id = "syst_hyperthermia_sessions", val = pull(sel_ht, ht_sessions)),
      list(sess = session, fun = "updateTextInput", id = "syst_hyperthermia_schedule", val = pull(sel_ht, ht_schedule)),
      list(sess = session, fun = "updateSelectInput", id = "syst_hyperthermia_board", val = pull(sel_ht, ht_board_indication))
    )

    for (x in cfg) {
      do.call(update_field, x)
    }

    ## Drug ##
  my_systemic_therapy_id <- dat_systemic_therapy() %>%
    slice(input$syst_table_rows_selected) %>%
    pull(systemic_therapy_id)

  dat <- get_systemic_drug()
  if(isTruthy(my_systemic_therapy_id)) {
    dat <- dat[dat$systemic_therapy_id == my_systemic_therapy_id, ]
  } else {
    dat <- dat %>% slice(0)
  }
  rownames(dat) <- NULL

  syst_drug(dat)

  ## Toxicity ##

  df <- get_systemic_toxicity()
  if(isTruthy(my_systemic_therapy_id)) {
    df <- df[df$systemic_therapy_id == my_systemic_therapy_id,
             c("systemic_therapy_id", "toxicity_name", "toxicity_date", "toxicity_grade")]
  } else {
    df <- df %>% slice(0)
  }
  rownames(df) <- NULL

  syst_tox(df)

  })

  dtedit(
    input, output, "syst_drug", syst_drug,
    cols = names(dat),
    fields = build_modal_fields(dat, edit_cols, types = NULL, args = args),
    values = NULL,
    insert = function(new, dat) {
      my_systemic_therapy_id <- dat_systemic_therapy() %>%
        slice(input$syst_table_rows_selected) %>%
        pull(systemic_therapy_id)
      if(!isTruthy(my_systemic_therapy_id)) {
        my_systemic_therapy_id <-  paste(input$pid, input$syst_start, input$syst_end, sep = "_")
      }
      newis <- cbind(systemic_therapy_id = my_systemic_therapy_id, new)
      newis$frequency <- as.numeric(newis$frequency)
      newis$dose <- as.numeric(newis$dose)
      rows_insert(x = get_dm()$systemic_drug,
                  y = newis,
                  by = c("systemic_therapy_id", "drug"),
                  conflict = "ignore",
                  copy = TRUE,
                  in_place = TRUE)
      rbind(dat, newis)
    },
    delete = function(row, dat) {
      old <- syst_drug()
      hit <- which(old$systemic_therapy_id == dat$systemic_therapy_id[row] &
                     old$drug == dat$drug[row])
      stopifnot(length(hit) == 1L)
      rows_delete(x = get_dm()$systemic_drug,
                  y = dat[row,],
                  by = c("systemic_therapy_id", "drug"),
                  copy = TRUE,
                  in_place = TRUE,
                  unmatched = "ignore")
      dat[-row, ]
    },
    update = function(row, new, dat) {
      old <- syst_drug()
      hit <- which(old$systemic_therapy_id == dat$systemic_therapy_id[row] &
                     old$drug == dat$drug[row])
      stopifnot(length(hit) == 1L)
      newis <- cbind(systemic_therapy_id = old$systemic_therapy_id[hit], new)
      newis$frequency <- as.numeric(newis$frequency)
      newis$dose <- as.numeric(newis$dose)
      dat[row, ] <- newis
      rows_update(x = get_dm()$systemic_drug,
                  y = newis,
                  by = c("systemic_therapy_id", "drug"),
                  unmatched = "ignore",
                  copy = TRUE,
                  in_place = TRUE)
      dat
    }
  )

  dtedit(
    input, output, "syst_tox", syst_tox,
    cols = c("systemic_therapy_id", "toxicity_name", "toxicity_grade", "toxicity_date"),
    fields = build_modal_fields(df, edit_cols_tox, types = NULL, args = args_tox),
    values = NULL,
    insert = function(new, dat) {
      my_systemic_therapy_id <- dat_systemic_therapy() %>%
        slice(input$syst_table_rows_selected) %>%
        pull(systemic_therapy_id)
      if(!isTruthy(my_systemic_therapy_id)) {
        my_systemic_therapy_id <-  paste(input$pid, input$syst_start, input$syst_end, sep = "_")
      }
      newis <- cbind(systemic_therapy_id = my_systemic_therapy_id, new)
      rows_insert(x = get_dm()$toxicity,
                  y = newis,
                  by = c("systemic_therapy_id", "toxicity_name", "toxicity_date"),
                  conflict = "ignore",
                  copy = TRUE,
                  in_place = TRUE)
      rbind(dat, newis)
    },
    delete = function(row, dat) {
      old <- syst_tox()
      hit <- which(old$systemic_therapy_id == dat$systemic_therapy_id[row] &
                     old$toxicity_name == dat$toxicity_name[row])
      stopifnot(length(hit) == 1L)
      rows_delete(x = get_dm()$toxicity,
                  y = dat[row,],
                  by = c("systemic_therapy_id", "toxicity_name", "toxicity_date"),
                  copy = TRUE,
                  in_place = TRUE,
                  unmatched = "ignore")
      dat[-row, ]
    },
    update = function(row, new, dat) {
      old <- syst_tox()
      hit <- which(old$systemic_therapy_id == dat$systemic_therapy_id[row] &
                     old$toxicity_name == dat$toxicity_name[row])
      stopifnot(length(hit) == 1L)
      newis <- cbind(systemic_therapy_id = old$systemic_therapy_id[hit], new)
      newis <- newis[,c("systemic_therapy_id","toxicity_name", "toxicity_date", "toxicity_grade")]
      dat[row, ] <- newis
      rows_update(x = get_dm()$toxicity,
                  y = newis,
                  by = c("systemic_therapy_id", "toxicity_name", "toxicity_date"),
                  unmatched = "ignore",
                  copy = TRUE,
                  in_place = TRUE)
      dat
    }
  )
}
