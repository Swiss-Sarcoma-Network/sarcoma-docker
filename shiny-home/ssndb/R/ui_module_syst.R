systemic_therapy <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Systemic therapy summary",
                  class = "text-bg-secondary"),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("syst_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a systemic therapy entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "syst_table_add",
                 label = "Add systemic therapy",
                 icon = icon("plus")
    ),
    shinydashboard::box(title = strong("Administration"),
                         id = "syst_admin",
                         collapsible = TRUE,
                         collapsed = TRUE,
                         closable = FALSE,
                         width = 12,
                         fluidRow(
                           column(4,
                             selectizeInput(inputId = "syst_reason",
                                         label = "Reason for systemic therapy",
                                         choices = c(
                                           "",
                                           "curative intent: neoadjuvant",
                                           "curative intent: adjuvant",
                                           "additive/maintenance",
                                           "palliative",
                                           "other"),
                                         options = list(create = TRUE)
                                         )
                             ),
                         column(4,
                                numericInput(inputId = "syst_line",
                                             label = "Line of treatment",
                                             value = "")
                          ),
                         column(4,
                                selectInput(inputId = "syst_cycles_planned",
                                            label = "Number of cycles planned",
                                            choices = c("",
                                                        "1",
                                                        "2",
                                                        "3",
                                                        "4",
                                                        "5",
                                                        "until progression"))
                         )
                        ),
                         fluidRow(
                           column(4,
                                  selectizeInput(inputId = "syst_bone_protocol",
                                              label = "Protocol for bone tumor:",
                                              choices = c(
                                                "",
                                                "EURAMOS",
                                                "EUROBOSS",
                                                "EWING2008",
                                                "EuroEwing 2012 VIDE",
                                                "EuroEwing 2012 VDC/IE",
                                                "CWS",
                                                "other"),
                                              options = list(create = TRUE)
                                              )
                                  ),
                           column(4,
                                  selectizeInput(inputId = "syst_softtissue_protocol",
                                              label = "Protocol for soft tissue tumor:",
                                              choices = c("",
                                                          "CWS",
                                                          "PazoQol",
                                                          "Napage",
                                                          "other"),
                                              options = list(create = TRUE))
                                  )
                           ),
                        fluidRow(
                           column(4,
                                  user_input(inputId = "syst_oncologist", label = "Who is the medical oncologist?",
                                           user_discipline = "medical oncology")
                                  ),
                             column(4,
                                    institution_input(inputId= "syst_institution",
                                                      label = "Institution where Systemic Therapy was conducted")
                                    )
                             ),
                        fluidRow(
                             column(4,
                                    airDatepickerInput(inputId = "syst_start",
                                      label = "Start  of systemic cycle",
                                      value = NA)
                                    ),
                             column(4,
                                    airDatepickerInput(inputId = "syst_end",
                                      label = "End of systemic cycle",
                                      value = NA,
                                      clearButton = TRUE)
                                    )
                           ),
                           fluidRow(
                             column(4,
                               selectInput(inputId = "syst_reason_discontinuation",
                                 label = "Reason for discontinuation of systemic therapy",
                                 choices = c(
                                   "",
                                   "completed",
                                   "discontinued due to toxicity",
                                   "discontinued due to progressive disease",
                                   "discontinued due to patient's wish",
                                   "discontinued due to patient's death (unrelated to tumor)",
                                   "discontinued due to patient's death (related to tumor)")
                                 )
                             ),
                             column(4,
                                    selectInput(inputId = "syst_rct",
                                                label = "Was chemotherapy concomittant to radiotherapy (RCT)?",
                                                choices = c("",
                                                            "Yes",
                                                            "No"))
                             )
                            ),
                           fluidRow(
                             column(4,
                                    textAreaInput(inputId = "syst_comment",
                                                  label = "Comments",
                                                  value = "",
                                                  width = "900px")
                                    ),
                             column(4,
                                    selectizeInput(inputId = "syst_clinical_trial",
                                                label = "Inclusion in clinical trial",
                                                choices = c("",
                                                            "No",
                                                            "Yes: SSN outcome prediction",
                                                            "Yes: other (please specify here)"),
                                                options = list(create = TRUE))
                                    )
                             )
                           ),
    shinydashboard::box(title = strong("Drugs"),
                         id = "syst_drug_box",
                         collapsible = TRUE,
                         collapsed = TRUE,
                         closable = FALSE,
                         width = 12,
                         uiOutput("syst_drug")
    ),
    shinydashboard::box(title = strong("Toxicity"),
                         id = "syst_toxicity",
                         collapsible = TRUE,
                         collapsed = TRUE,
                         closable = FALSE,
                         width = 12,
                         uiOutput("syst_tox")
    ),
    shinydashboard:: box(
      title = strong("Hyperthermia"),
      id = "syst_hyperthermia_box",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(6,
               selectInput(inputId = "syst_hyperthermia",
                           label = "Use of hyperthermia?",
                           choices = c("no",
                                       #"Yes: Radiation-Hyperthermia",
                                       "yes: chemotherapy-hyperthermia"))
        )
      ),
      conditionalPanel(condition = "input.syst_hyperthermia =='yes: radiation-hyperthermia' |
                                    input.syst_hyperthermia =='yes: chemotherapy-hyperthermia'",
                       fluidRow(
                         column(6,
                                selectInput(inputId = "syst_hyperthermia_indication",
                                            label = "Indication of hyperthermia treatment",
                                            choices = c("",
                                                        "preoperative intent, previously irradiated",
                                                        "inoperable, previously irradiated",
                                                        "compression symptoms",
                                                        "palliative situation",
                                                        "other"))
                         )
                       ),
                       conditionalPanel(condition = "input.syst_hyperthermia_indication == 'other'",
                                        fluidRow(
                                          column(6,
                                                 textInput(inputId = "syst_hyperthermia_indication_other",
                                                           label = "Please specify 'other' indication",
                                                           value = "")
                                          )
                                        )
                       ),
                       fluidRow(
                         column(6,
                                airDatepickerInput(inputId = "syst_hyperthermia_start",
                                                   label = "Start of hyperthermia treatment",
                                                   value = NA,
                                                   clearButton = TRUE)
                         ),
                         column(6,
                                airDatepickerInput(inputId = "syst_hyperthermia_end",
                                                   label = "End of hyperthermia treatment",
                                                   value = NA,
                                                   clearButton = TRUE)
                         )
                       ),
                       fluidRow(
                         column(6,
                                selectInput(inputId = "syst_hyperthermia_type",
                                            label = "Type of hyperthermia",
                                            choices = c("", "superficial", "deep"))
                         ),
                         column(6,
                                numericInput(inputId = "syst_hyperthermia_sessions",
                                             label = "Number of hyperthermia therapy sessions",
                                             value = "")
                         )
                       ),
                       fluidRow(
                         column(6,
                                textInput(inputId = "syst_hyperthermia_schedule",
                                          label = "Hyperthermia schedule (e.g., 1x per week)",
                                          value = "")
                         ),
                         column(6,
                                selectInput(inputId = "syst_hyperthermia_board",
                                            label = "Swiss hyperthermia board accepted indication",
                                            choices = c("", "Yes", "No"))
                         )
                       )
      )
    ),
    actionButton("syst_submit", "Save data", class = "btn-warning")
  )
}
