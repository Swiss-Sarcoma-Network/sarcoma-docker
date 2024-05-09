clinical <- function() {
  tagList(
    shinydashboard:: box(
      title = strong("Diagnosis"),
      id = "Clinical_Diagnosis",
      collapsible = TRUE,
      # collapsed = TRUE, # when set to TRUE, updateTreeview() does not work
      closable = FALSE,
      width = 12,
      textAreaInput(inputId = "clinical_referral_diagnosis",
                    label = "Main referral diagnosis",
                    width = "900px",
                    height = "200px"),
      fluidRow(
        column(4,
               tree_ui(
                 input_id = "clinical_anatomic_region",
                 label = "anatomic region"
               )
        ),
        column(4,
               selectInput(inputId = "clinical_anatomic_side",
                           label = "Anatomic side of lesion",
                           choices = c("",
                                       "Right",
                                       "Left",
                                       "Midline"))
        )
      ),
      ########################################################### @Nicolas
      selectInput(inputId = "clinical_cancer_syndrome",
                  label = "Known (cancer) syndrome or previous cancer",
                  choices = c("No",
                                 "Previous cancer",
                                 "Neurofibromatosis Type 1",
                                 "Neurofibromatosis Type 2",
                                 "Gardner syndrome",
                                 "Li Fraumeni syndrome",
                                 "Retinoblastoma syndrome",
                                 "Immunodepressed due to HIV",
                                 "Immunodepressed due to other reason",
                                 "Ollier syndrome",
                                 "Maffucci syndrome",
                                 "Paget disease",
                                 "Multiple osteochondromas",
                                 "McCune Albright syndrome",
                                 "Rothmund-Thomson syndrome",
                                 "Werner syndrome", "Cherubism",
                                 "familial gastrointestinal stromal tumor (GIST)",
                                 "Stratakis-Carney triad",
                                 "Other malignancy in family",
                                 "Other"),
                  selected = "No"),
      conditionalPanel(condition = "input.clinical_cancer_syndrome == 'Previous cancer'",
                       textAreaInput(inputId = "clinical_previous_cancer",
                                     label = "Previous cancer:", value = "")
      ),
      conditionalPanel(condition = "input.clinical_cancer_syndrome == 'Other'",
                       textInput(inputId = "clinical_cancer_syndrome_other",
                                 label = "Other cancer syndrome:", value = "")
      )
    ),
    shinydashboard:: box(
      title = strong("Other medical history"),
      id = "slinical_medical_history",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      textAreaInput(inputId = "clinical_other_diagnosis",
                    label = "Other diagnoses",
                    width = "900px"),
      textAreaInput(inputId = "clinical_history",
                    label = "Patient history (clinics, therapy up to now...)",
                    width = "900px")),
    shinydashboard:: box(
      title = strong("Performance status at time of diagnosis"),
      id = "clinical_performance_index",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(6,
               selectInput(inputId = "clinical_ecog",
                           label = "ECOG at diagnosis",
                           choices = c("",
                                       "0",
                                       "1",
                                       "2",
                                       "3",
                                       "4",
                                       "5"))
        ),
        column(6,
               shinyWidgets:: prettySwitch(inputId = "clinical_ecog_criteria_display",
                                           label = "Display ECOG criteria",
                                           value = TRUE),
               htmlOutput(outputId = "clinical_ecog_criteria")
        )
      )
    ),
    shinydashboard:: box(
      title = strong("Follow-Up"),
      id = "clinical_fup",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(6,
               airDatepickerInput(inputId = "clinical_last_contact_date",
                                  label = "Date of last patient contact",
                                  value = NA,
                                  clearButton = TRUE)
        ),
        column(6,
               selectInput(inputId = "clinical_last_status",
                           label = "Status at last patient contact",
                           choices = c("",
                                       "No evidence of disease (NED)",
                                       "Alive with disease (AWD)",
                                       "Dead of disease (DOD)",
                                       "Dead of other reason (DOR)",
                                       "Not applicable because no Sarcoma"))
        )),
      conditionalPanel(
        condition = "input.clinical_last_status=='Dead of other reason (DOR)'",
        fluidRow(
          column(6,
                 selectInput(inputId = "clinical_death_reason",
                             label = "Reason of death",
                             choices = c("",
                                         "Of other cancer",
                                         "Of treatment complication",
                                         "Of medical reason independent from cancer",
                                         "Unknown"))
          )
        )
      ),
      fluidRow(
        column(6,
          user_input(inputId = "clinical_followup_physician",
                     label = "Who conducted the follow-up?",
                     user_discipline = NULL)
        )
      )
    ),
    shinyWidgets:: materialSwitch(inputId = "add_additional_tumor",
                                  label = "Add additional/parallel tumor",
                                  value = FALSE,
                                  status = "primary"),
    conditionalPanel(condition = "input.add_additional_tumor==true",
                     fluidRow(
                       column(6,
                              selectInput(inputId = "clinical_anatomic_side2",
                                          label = "Additional tumor: Anatomic side of lesion",
                                          choices = c("",
                                                      "Right",
                                                      "Left",
                                                      "Midline"),
                              )),
                       column(6,
                              tree_ui(
                                input_id = "clinical_anatomic_region2",
                                label = "Additional tumor: Anatomic region"
                              )
                            )
                       ),
                     textAreaInput(inputId = "clinical_clinical_history2",
                                   label = "Clinical history for additional tumor",
                                   value = "",
                                   width = "900px")
    ),
    br(),
    actionButton(inputId = "clinical_submit", label = "Save data", class = "btn-warning")
    )
  }
