
radiology <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Radiology summary",
                  class = "text-bg-secondary"),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("rad_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a radiology entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "rad_table_add",
                 label = "Add radiology exam",
                 icon = icon("plus")
    ),
    shinydashboard:: box(
      title = strong("Radiology exam"),
      id = "rad_RadiologyExam",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(3,
               airDatepickerInput(inputId = "rad_date",
                         label = "Date of radiology exam",
                         value = NA)

        ),
        column(3,
               selectInput(inputId = "rad_timing",
                              label = "Timing of imaging",
                              choices = c("",
                                          "Initial imaging",
                                          "Follow-up imaging"))
        ),
        column(3,
               selectInput(inputId = "rad_type",
                              label = "Type of imaging",
                              choices = c("",
                                          "Local imaging",
                                          "Systemic imaging"))
        ),
        column(3,
               selectizeInput(inputId = "rad_exam",
                              label = "Type of radiology exam",
                              choices = c("",
                                          "conventional X-Ray",
                                          "MRI",
                                          "CT scan",
                                          "Ultrasound (US)",
                                          "PET-CT",
                                          "PET-MRI",
                                          "Scintigraphy",
                                          "Other"),
                              options = list(create = TRUE))
        )
      )),
    shinydashboard:: box(
      title = strong("Details about the lesion"),
      id = "Radio_Lesion",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(3,
               numericInput(inputId = "rad_sizeA",
                            label = "Size A [mm] (largest dimension)",
                            value = "")),
        column(3,
               numericInput(inputId = "rad_sizeB",
                            label = "Size B [mm]",
                            value = "")),
        column(3,
               numericInput(inputId = "rad_sizeC",
                            label = "Size C [mm] (smallest dimension)",
                            value = "")),
        column(3,
               selectInput(inputId = "rad_fascia",
                           label = "Location of lesion in relation to fascia/bone",
                           choices = c("",
                                       "Epifascial",
                                       "Subfascial",
                                       "Bone"))
               )
      ),
      conditionalPanel(
        condition = "input.rad_type == 'Systemic imaging'",
        strong("Presence of metastasis"),
        fluidRow(
          column(3,
                 selectInput(inputId = "rad_metastasis",
                             label = "Are metastases visible in the imaging?",
                             choices = c("",
                                         "Yes",
                                         "No"))
          )),
          conditionalPanel(
            condition = "input.rad_metastasis == 'Yes'",
            fluidRow(
          column(3,
                 numericInput(inputId = "rad_metastasis_nr",
                              label = "How many metastases are visible in the imaging?",
                              value = "")
          ),
          column(3,
                 selectInput(inputId = "rad_metastasis_location",
                             label = "Where are the metastases located?",
                             choices = c("",
                                         "Intracranial",
                                         "Head",
                                         "Neck",
                                         "Lung",
                                         "Upper extremity",
                                         "Lower extremity",
                                         "Abdomen",
                                         "..."),
                             selected = "",
                             multiple = TRUE)
          ),
          column(3,
                 selectInput(inputId = "rad_metastasis_initial",
                             label = "Are these metastases at diagnosis?",
                             choices = c("",
                                         "Yes",
                                         "No")
                             )
                 )
        )
        )
      )),
    shinydashboard:: box(
      title = strong("Treatment response"),
      id = "rad_TreatmentResponse",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(3,
               selectInput(inputId = "rad_recist",
                           label = "Response according to RECIST 1.1",
                           choices = c("",
                                       "not-applicable",
                                       "complete remission (CR)",
                                       "partial remission (PR)",
                                       "stable disease (SD)",
                                       "progressive disease (PD)")),
               shinyWidgets:: prettySwitch(inputId = "Radiology_RecistDisplay",
                            label = "Display RECIST 1.1 criteria",
                            value = FALSE),
               htmlOutput(outputId = "Radiology_RecistDisplay_text")
        ),
        column(3,
               selectInput(inputId = "rad_choi",
                           label = "Response according to CHOI (use of TKI)",
                           choices = c("",
                                       "not-applicable",
                                       "complete response (CR)",
                                       "partial response (PR)",
                                       "stable disease (SD)",
                                       "progressive disease (PD)")),
               shinyWidgets:: prettySwitch(inputId = "Radiology_ChoiDisplay",
                            label = "Display CHOI criteria",
                            value = FALSE),
               htmlOutput(outputId = "Radiology_ChoiDisplay_text")
        ),
        column(3,
               selectInput(
                 inputId = "rad_irecist",
                 label = "Response according to iRECIST",
                 choices = c(
                   "",
                   "not-applicable",
                   "complete response (iCR)",
                   "partial response (iPR)",
                   "stable disease (iSD)",
                   "unconfirmed progressive (iUPD)",
                   "confirmed progression (iCPD)"
                   ))
               ),
        column(3,
      conditionalPanel(condition = "input.rad_exam=='PET-CT'",
                       selectInput(inputId = "rad_percist",
                                   label = "Response according to PET (PERCIST)",
                                   choices = c("",
                                               "not-applicable",
                                               "complete metabolic response (MCR)",
                                               "partial metabolic response (PMR)",
                                               "stable metabolic disease (SMD)",
                                               "progressive metabolic disease (PMD)")),
                       shinyWidgets:: prettySwitch(inputId = "Radiology_Percist",
                                    label = "Display PERCIST criteria",
                                    value = FALSE),
                       htmlOutput(outputId = "Radiology_Percist_text"),
      )
      )
      )
    ),
    shinydashboard:: box(
      title = strong("Radiology report"),
      id = "Radio_Report",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      textAreaInput(inputId = "rad_report_text",
                    label = "Radiology report as text (copy and paste here)",
                    value = ""),
      uiOutput("rad_report_download")
      # fileInput(inputId = "rad_report",
      #           label = "Upload radiology report",
      #           multiple = FALSE,
      #           accept = ".pdf"),
    ),
    #img(src='irecist.png', align = "right", width="800px"),
    actionButton(inputId = "rad_submit", label = "Save radiology data", class = "btn-warning"),
  )
}
