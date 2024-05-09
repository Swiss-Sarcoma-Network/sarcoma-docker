
sarcoma_board <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Sarcoma board summary",
                  class = "text-bg-secondary",),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("sb_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a sarcoma board entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "sb_table_add",
                 label = "Add SB",
                 icon = icon("plus")
                 ),
    shinydashboard:: box(
      title = strong("General sarcoma board information"),
      id = "SB_GeneralSB",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(4,
               airDatepickerInput(inputId = "sb_date",
                                  label = "Date of sarcoma board (SB) presentation",
                                  value = NA)
        ),
        column(4,
               selectInput(inputId = "sb_reason",
                           label = "Reason for sarcoma board presentation",
                           choices=c("",
                                     "First time presentation (no prior therapy, no WHOOPS, but incl. biopsy)",
                                     "Unplanned excision (Whoops-procedure)",
                                     "Follow-up presentation")
               )
        ),
          column(4,
                 user_input(inputId = "sb_presenting_physician",
                            label = "Presenting physician",
                            user_discipline = NULL)
          )
      ),
      conditionalPanel(condition = "input.sb_reason == 'First time presentation (no prior therapy, incl. biopsy or WHOOPS)'",
                       fluidRow(
                         column(4,
                                selectInput(inputId = "sb_current_situation",
                                            label = "What is the current situation?",
                                            choices = c("",
                                                        "No previous therapy was done",
                                                        "Locally advanced tumor, incl. pathological fractures",
                                                        "Exophytic growth")
                                )
                         )
                       )
      ),
      conditionalPanel(condition = "input.sb_reason=='Unplanned excision (Whoops-procedure)'",
                       fluidRow(
                         column(4,
                                airDatepickerInput(inputId = "sb_whoops_date",
                                                   label = "Date of unplanned excision (Whoops-procedure)",
                                                   value = NA,
                                                   clearButton = TRUE)
                         ),
                         column(4,
                                institution_input(inputId = "sb_whoops_institution",
                                                  label = "In which institution was the Whoops surgery done?")
                         )
                       )
      ),
      conditionalPanel(condition = "input.sb_reason == 'Follow-up presentation'",
                       fluidRow(
                         column(4,
                                selectInput(inputId = "sb_followup_status",
                                            label = "Specify current status",
                                            choices = c("",
                                                        "Partial therapy for primary tumor (to be continued by SSN)",
                                                        "Completed therapy for primary tumor",
                                                        "Other")
                                )
                         ),
                         column(4,
                                selectInput(inputId = "sb_prior_therapy",
                                            label = "What treatment was done before first time presentation to SSN?",
                                            choices = c("",
                                                        "None",
                                                        "Surgery",
                                                        "Radiotherapy",
                                                        "Systemic therapy",
                                                        "Surgery + Radiotherapy",
                                                        "Surgery + Chemotherapy",
                                                        "Radiotherapy + Chemotherapy",
                                                        "Surgery + Chemotherapy + Radiotherapy"
                                            )
                                )
                         ),
                         column(4,
                                selectInput(inputId = "sb_followup_reason",
                                            label = "What is the reason for this follow-up presentation?",
                                            choices = c("",
                                                        "In context of primary treatment",
                                                        "First local recurrence",
                                                        "In context of treatment for first local recurrence",
                                                        "First systemic recurrence",
                                                        "In context of first systemic recurrence",
                                                        "Second or more local/systemic recurrences",
                                                        "Important follow-up information of general interest")
                                )
                         )
                       )
      ),
      conditionalPanel(condition = "input.sb_followup_reason == 'First local recurrence'|
                                                          input.sb_followup_reason == 'In context of treatment for first local recurrence'|
                                                          input.sb_followup_reason == 'First systemic recurrence'|
                                                          input.sb_followup_reason == 'In context of first systemic recurrence'",
                       fluidRow(
                         column(4,
                                airDatepickerInput(inputId = "sb_recurrence_date",
                                                   label = "What was the date of first local or systemic recurrence",
                                                   value = NA,
                                                   clearButton = TRUE)
                         )
                       )
      ),
      conditionalPanel(condition = "input.sb_followup_reason=='Second or more local/systemic recurrences'",
                       fluidRow(
                         column(4,
                                textAreaInput(inputId = "sb_recurrence_dates",
                                              label = "Please list the dates of all local or systemic recurrences to date",
                                              value = "")
                         ))
      )
    ),
    shinydashboard:: box(
           title = strong("Sarcoma Board questions"),
           id = "SB_Questions",
           collapsible = TRUE,
           collapsed = TRUE,
           closable = FALSE,
           width = 12,
           fluidRow(
             column(6,
           textAreaInput(inputId = "sb_question",
                         label = "Question to the Sarcoma Board",
                         value = "")
           ),
           column(6,
                         selectInput(inputId = "sb_last_decision_executed",
                                     label = "Was the last SB decision executed?",
                                     choices = c("",
                                                 "No prior sarcoma board",
                                                 "Yes",
                                                 "No, due to physician's decision",
                                                 "No, due to patient's wish"))
                         )
           ),
           fluidRow(
             column(6,
               textAreaInput(inputId = "sb_suggestion",
                             label = "Suggestion on how to proceed",
                             value = "")
               )
           )
         ),
    # shinydashboard:: box(
    #        title = strong("Current TNM"),
    #        id = "SB_TNM",
    #        collapsible = TRUE,
    #        collapsed = TRUE,
    #        closable = FALSE,
    #        width = 12,
    #        fluidRow(
    #          column(4,
    #                 selectInput(inputId = "sb_ajcc_t",
    #                             label = "T from current AJCC/TNM stage",
    #                             choices = c("",
    #                                         "T1",
    #                                         "T1a",
    #                                         "T1b",
    #                                         "T2",
    #                                         "T2a",
    #                                         "T2b",
    #                                         "T3",
    #                                         "T3a",
    #                                         "T3b",
    #                                         "T4")
    #                             )
    #                 ),
    #          column(4,
    #                 selectInput(inputId = "sb_ajcc_n",
    #                             label = "N from current AJCC/TNM stage",
    #                             choices = c("",
    #                                         "N0",
    #                                         "N1")
    #                             )
    #                 ),
    #          column(4,
    #                 selectInput(inputId = "sb_ajcc_m",
    #                             label = "M from current AJC/TNM stage",
    #                             choices = c("",
    #                                         "M0",
    #                                         "M1")
    #                             )
    #                 )
    #          ),
    #        fluidRow(
    #          column(4,
    #        selectInput(inputId = "sb_ajcc_initial",
    #                    label = "Is this the AJCC/TNM stage from time of diagnosis?",
    #                    choices = c("",
    #                                "Yes",
    #                                "No")
    #                    )
    #      ))),
    shinydashboard:: box(
           title = strong("Current performance status"),
           id = "SB_PerformanceStatus",
           collapsible = TRUE,
           collapsed = TRUE,
           closable = FALSE,
           width = 12,
           fluidRow(
             column(4,
                    selectInput(inputId = "ecog_sb",   ## Include date when PROM was filled in
                                label = "Current ECOG",
                                choices = c("",
                                            "0",
                                            "1",
                                            "2",
                                            "3",
                                            "4",
                                            "5")
                                )
             ),
             column(4,
                    shinyWidgets:: prettySwitch(inputId = "sb_ecog_criteria_display",
                                                label = "Display ECOG criteria",
                                                value = FALSE),
                    htmlOutput(outputId = "sb_ecog_criteria"))
           )
           ),
    shinydashboard:: box(
           title = strong("Sarcoma Board protocol"),
           id = "SB_Protocol",
           collapsible = TRUE,
           collapsed = TRUE,
           closable = FALSE,
           width = 12,
           fluidRow(
             column(4,
                    selectInput(inputId = "sb_decision_sux",
                                label = "Decision regarding surgery",
                                choices = c("",
                                            "Yes",
                                            "Yes, interventional radiology",
                                            "No",
                                            "Undecided")
                                ),
                    shinyWidgets:: materialSwitch(inputId = "SB_DecisionSurgery_Comment",
                                                  label = "Add a comment"),
                    conditionalPanel(condition = "input.SB_DecisionSurgery_Comment==true",
                                     textAreaInput(inputId = "sb_decision_sux_comment",
                                                   label = "Comment to decision regarding surgery",
                                                   value = "")
                                     )
                    ),
             column(4,
                    selectInput(inputId = "sb_decision_rt",
                                label = "Decision regarding radiotherapy",
                                choices = c("",
                                            "Yes",
                                            "No",
                                            "Undecided")
                                ),
                    shinyWidgets:: materialSwitch(inputId = "SB_DecisionRadiotherapy_Comment",
                                                  label = "Add a comment"),
                    conditionalPanel(condition = "input.SB_DecisionRadiotherapy_Comment==true",
                                     textAreaInput(inputId = "sb_decision_rt_comment",
                                                   label = "Comment to decision regarding radiotherapy",
                                                   value = "")
                                     )
                    ),
             column(4,
                    selectInput(inputId = "sb_decision_syst",
                                label = "Decision regarding systemic therapy",
                                choices = c("",
                                            "Yes",
                                            "No",
                                            "Undecided")
                                ),
                    shinyWidgets:: materialSwitch(inputId = "SB_DecisionSystemicTx_Comment",
                                                  label = "Add a comment"),
                    conditionalPanel(condition = "input.SB_DecisionSystemicTx_Comment==true",
                                     textAreaInput(inputId = "sb_decision_syst_comment",
                                                   label = "Comment to decision regarding systemic therapy",
                                                   value = "")
                                     )
                    )
             ),
             fluidRow(
             column(4,
                    selectInput(inputId = "sb_decision_fup",
                                label = "Decision regarding FollowUp monitoring",
                                choices = c("",
                                            "Yes",
                                            "No",
                                            "Undecided")
                                ),
                    shinyWidgets:: materialSwitch(inputId = "SB_DecisionFollowUp_Comment",
                                                  label = "Add a comment"),
                    conditionalPanel(condition = "input.SB_DecisionFollowUp_Comment==true",
                                     textAreaInput(inputId = "sb_decision_fup_comment",
                                                   label = "Comment to decision regarding Follow-Up monitoring",
                                                   value = "")
                                     )
                    ),
             column(4,
               selectInput(inputId = "sb_decision_diagnostics",
                           label = "Further diagnostics required",
                           choices = c("",
                                       "Yes",
                                       "No",
                                       "Undecided")),
               shinyWidgets:: materialSwitch(inputId = "SB_DecisionDiagnostics_Comment",
                                             label = "Add a comment"),
               conditionalPanel(condition = "input.SB_DecisionDiagnostics_Comment==true",
                                textAreaInput(inputId = "sb_decision_diagnostics_comment",
                                              label = "Comment to further diagnostics required",
                                              value = "",
                                              width = "300px")
                                )
               ),
             column(4,
                    selectInput(inputId = "sb_decision_palliative",
                                label = "Palliative care",
                                choices = c("Yes",
                                            "No",
                                            "Undecided"),
                                selected = "No"),
                    shinyWidgets:: materialSwitch(inputId = "SB_DecisionPalliative_Comment",
                                                  label = "Add a comment"),
                    conditionalPanel(condition = "input.SB_DecisionPalliative_Comment == true",
                                     textAreaInput(inputId = "sb_decision_palliative_comment",
                                                   label = "Comment to palliative care",
                                                   value = "",
                                                   width = "300px")
                    )
             )
           ),
           textAreaInput(inputId = "sb_summary",
                         label = "Summary of Sarcoma Board decision",
                         value = "",
                         width = "930px",
                         height = "180px"),
           textAreaInput(inputId = "sb_details",
                         label = "Further details regarding Sarcoma Board (incl. organisational matters)",
                         value = "",
                         width = "930px",
                         height = "180px"),
           fluidRow(
           column(4,
                  selectInput(inputId = "sb_fast_track",
                              label = "Fast track?",
                              choices = c("",
                                          "Yes",
                                          "No"))
                  )
           )
           ),
    actionButton(inputId = "sb_submit", label = "Save data", class = "btn-warning")
  )
}
