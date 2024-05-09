
pathology <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Pathology summary",
                  class = "text-bg-secondary"),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("pat_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a pathology entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "pat_table_add",
                 label = "Add pathology",
                 icon = icon("plus")
    ),
    shinydashboard:: box(title = strong("Administration"),
                         id = "pat_admin",
                         collapsible = TRUE,
                         collapsed = TRUE,
                         closable = FALSE,
                         width = 12,
                         fluidRow(
                           column(4,
                                  selectInput(inputId = "pat_type",
                                              label = "Type of data entry",
                                              choices = c("",
                                                          "Biopsy of the primary tumor",
                                                          "Biopsy of local recurrence",
                                                          "Biopsy of metastases",
                                                          "Resection of the primary tumor",
                                                          "Resection of local recurrence",
                                                          "Resection of metastases"))
                           ),
                           column(4,
                                  user_input(inputId = "pat_pathologist",
                                           label = "Who is the responsible pathologist?",
                                           user_discipline = "pathology")
                                  ),
                           column(4,
                                  airDatepickerInput(inputId = "pat_date",
                                             label = "Date of biopsy/resection",
                                             value = NA)
                                  )),
                           fluidRow(
                             column(4,
                                  conditionalPanel(
                                    condition = "input.pat_type=='Biopsy of the primary tumor'|
                        input.pat_type=='Biopsy of local recurrence'|
                        input.pat_type=='Biopsy of metastases'",
                                    selectInput(inputId = "pat_type_biopsy",
                                                label = "Type of biopsy",
                                                choices = c("",
                                                            "Fine needle/Cytology",
                                                            "Core biopsy (imaging guided)",
                                                            "Open incisional: with suspicion of Sarcoma",
                                                            "Open incisional: without suspicion of Sarcoma",
                                                            "Excisional: with suspicion of Sarcoma",
                                                            "Excisional: without suspicion of Sarcoma",
                                                            "Unknown"))
                                  )
                           )
                         ),
                         fluidRow(
                           column(4,
                                  airDatepickerInput(inputId = "pat_date_registrate",
                                            label = "Date of registrate in the pathology institute",
                                            value = NA,
                                            clearButton = TRUE)
                           ),
                           column(4,
                                  airDatepickerInput(inputId = "pat_date_report",
                                            label = "Date of first written report",
                                            value = NA,
                                            clearButton = TRUE)
                           ),
                           column(4,
                                  airDatepickerInput(inputId = "pat_date_report_final",
                                            label = "Date of final report (if additional studies necessary)",
                                            value = NA,
                                            clearButton = TRUE)

                           )
                         ),
                         fluidRow(
                           column(4,
                                  selectInput(inputId = "pat_priortx",
                                              label = "Was therapy done before biopsy/resection?",
                                              choices = c("",
                                                          "No",
                                                          "Radiotherapy",
                                                          "Chemotherapy",
                                                          "Radiotherapy & Chemotherapy",
                                                          "Unknown"))
                           )
                         ),
                         conditionalPanel(
                           condition = "input.pat_pathologist=='Beata Bode'",
                           fluidRow(
                             column(6,
                                    selectInput(inputId = "pat_reference",
                                                label = "Was the specimen examined by a reference pathologist?",
                                                choices = c("Yes",
                                                            "No"))
                             ),
                             column(6,
                                    airDatepickerInput(inputId = "pat_date_report_reference",
                                              label = "Date of reference pathology report",
                                              value = NA,
                                              clearButton = TRUE)
                             )
                           ),
                           selectInput(inputId = "pat_review_result",
                                       label = "What was the result of the pathology review in comparison to the primary pathology report?",
                                       choices = c("",
                                                   "No discrepancy to primary pathology report",
                                                   "Minor discrepancy (not relevant for therapy, e.g. grading, variant etc.)",
                                                   "Major discrepancy (relevant for therapy, e.g.dignity, tumor type etc.)",
                                                   "Not applicable"))
                         )
    ),
    shinydashboard:: box(
      title = strong("Diagnostic"),
      id = "Patho_Diagnostic",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(4,
               tree_ui(
                 input_id = "pat_diagnosis",
                 label = "WHO 2013 diagnosis"
               )
        ),
        column(4,
               selectInput(inputId = "pat_grade",
                           label = "Grading (of biopsy/resection)",
                           choices = c("",
                                       "Not a sarcoma",
                                       "G1",
                                       "G2",
                                       "G3",
                                       "Benign",
                                       "Suspicious of malignancy",
                                       "Non-diagnostic"))
        ),
        column(4,
               conditionalPanel(
                 condition = "input.pat_type=='Resection of the primary tumor' |
                              input.pat_type=='Resection of local recurrence' |
                              input.pat_type=='Resection of metastases'",
                 selectInput(inputId = "pat_margin",
                             label = "Judgment of surgical margin",
                             choices = c("",
                                         "R0 - Wide margin",
                                         "R1a - Marginal margin (planned close, ultimative positive)",
                                         "R1b - Marginal margin (positive after tumor bed re-exicision)",
                                         "R1c - Marginal margin (inadvertent positive margin)",
                                         "R2 - Intralesional margin",
                                         "Curettage",
                                         "Not applicable because no sarcoma"))
               )
        )
      ),
      fluidRow(
        column(4,
               selectInput(inputId = "pat_mib",
                           label = "Proliferation index: Mib-1/Ki-67",
                           choices = c("",
                                       "<10%",
                                       "11 - 20%",
                                       "21 - 30%",
                                       "31 - 40%",
                                       "41 - 50%",
                                       "51 - 60%",
                                       "61 - 70%",
                                       "71 - 80%",
                                       "81 - 90%",
                                       ">90%",
                                       "In case of therapy before biopsy or necrosis: Not-applicable"))
        ),
        column(4,
               selectInput(inputId = "pat_mitoses",
                           label = "Mitoses per 10 high-power field (HPF)",
                           choices = c("",
                                       "0 - 9 mitoses per 10 HPF",
                                       "10 - 19 mitoses per 10 HPF",
                                       ">19 mitoses per 10 HPF"))
        )
      ),
      conditionalPanel(
        condition = "input.pat_type=='Resection of the primary tumor' |
                     input.pat_type=='Resection of local recurrence' |
                     input.pat_type=='Resection of metastases'",
        fluidRow(
          column(4,
                 selectInput(inputId = "pat_necrosis",
                             label = "Extent of necrosis",
                             choices = c("",
                                         "<10%",
                                         "11 - 20%",
                                         "21 - 30%",
                                         "31 - 40%",
                                         "41 - 50%",
                                         "51 - 60%",
                                         "61 - 70%",
                                         "71 - 80%",
                                         "81 - 90%",
                                         ">90%"))
          ),
          column(4,
                 numericInput(inputId = "pat_distance_margin",
                              label = "Closest distance to margin [mm]",
                              value = "")
          ),
          column(4,
                 selectInput(inputId = "pat_biological_barrier",
                             label = "Biological barrier to closest margin",
                             choices = c("", "None",
                                         "Fascia",
                                         "Adventitia",
                                         "Perineurium",
                                         "Periosteum",
                                         "Growth plate",
                                         "Other",
                                         "Non applicable"))
          )
        )
      ),
      fluidRow(
        column(3,
               selectInput(inputId = "pat_ihc", label = "Was IHC performed?",
                           choices = c("",
                                       "Yes",
                                       "No",
                                       "Not yet, but planned"))
        ),
        column(3,
               selectInput(inputId = "pat_fish", label = "Was FISH / RT-PCR performed?",
                           choices = c("",
                                       "Yes",
                                       "No",
                                       "Not yet, but planned"))
        ),
        column(3,
               selectInput(inputId = "pat_rna", label = "Was RNA sequencing performed?",
                           choices = c("",
                                       "Yes",
                                       "No",
                                       "Not yet, but planned"))
        ),
        column(3,
               selectInput(inputId = "pat_dna", label = "Was DNA sequencing performed?",
                           choices = c("",
                                       "Yes",
                                       "No",
                                       "Not yet, but planned"))
        )
      ),
      fluidRow(
        column(3,
               selectInput(inputId = "pat_ihc_result", label = "What was the IHC result?",
                           choices = c("",
                                       "See report",
                                       "In progress"))
        ),
        column(3,
               selectInput(inputId = "pat_fish_result", label = "What was the FISH/RT-PCR result?",
                           choices = c("",
                                       "Positive (see report)",
                                       "Negative (see report)",
                                       "Not-interpretable (see report)",
                                       "In progress"))
        ),
        column(3,
               selectInput(inputId = "pat_rna_result", label = "What was the RNA sequencing result?",
                           choices = c("",
                                       "Positive (see report)",
                                       "Negative (see report)",
                                       "Not-interpretable (see report)",
                                       "In progress"))
        ),
        column(3,
               selectInput(inputId = "pat_dna_result", label = "What was the DNA sequencing result?",
                           choices = c("",
                                       "Positive (see report)",
                                       "Negative (see report)",
                                       "Not-interpretable (see report)",
                                       "In progress"))
        )
      )
    ),
    shinydashboard:: box(
      title = strong("Pathology report"),
      id = "Patho_Report",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      # fileInput(inputId = "pat_report",
      #           label = "Upload pathology pdf report (one file only!)",
      #           multiple = FALSE,
      #           accept = ".pdf"),
      uiOutput("pat_report_download")
    ),
    actionButton(inputId = "pat_submit", label = "Save data", class = "btn-warning")
  )
}
