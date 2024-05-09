radiotherapy <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Radiotherapy summary",
                  class = "text-bg-secondary"
                  ),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("rt_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a radiotherapy entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "rt_table_add",
                 label = "Add radiotherapy",
                 icon = icon("plus")),
    shinydashboard:: box(
      title = strong("General radiotherapy information"),
      id = "rt_general",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
    fluidRow(
      column(6,
             selectInput(inputId = "rt_indication",
                         label = "Indication for radiotherapy",
                         choices = c("",
                                     "preoperative",
                                     "postoperative",
                                     "definitive",
                                     "pallative",
                                     "other"))
             ),
      column(6,
             selectInput(inputId = "rt_type",
                         label = "Type of radiotherapy",
                         choices = c("",
                                     "Intensity modulated radiotherapy (IMRT)",
                                     "volumetric arc VMAT",
                                     "conventional 3D",
                                     "stereotactic radiotherapy",
                                     "proton therapy",
                                     "intraoperative (Linac)",
                                     "intraoperative brachytherapy",
                                     "brachytherapy"))
             )
      ),
    fluidRow(
      column(6,
             airDatepickerInput(inputId = "rt_date_referral",
                       label = "Date of referral / referral letter",
                       value = NA,
                       clearButton = TRUE)
      ),
      column(6,
             airDatepickerInput(inputId = "rt_date_first_consult",
                       label = "Date of 1st contact / consultation for Radiotherapy",
                       value = NA,
                       clearButton = TRUE)
      )
    ),
    fluidRow(
      column(6,
             airDatepickerInput(inputId = "rt_start",
                       label = "When was radiotherapy started?",
                       value = NA)
      ),
      column(6,
             airDatepickerInput(inputId = "rt_end",
                       label = "When did radiotherapy end?",
                       value = NA,
                       clearButton = TRUE)
      )
    ),
    fluidRow(
      column(6,
             institution_input(inputId = "rt_institution",
                               label = "Institution where Radiotherapy was conducted?")
    ),
    column(6,
           user_input(inputId = "radiation_oncologist", label = "Who is the radiation oncologist?",
                    user_discipline = "radiation oncology")
           ))
    ),
    shinydashboard:: box(
      title = strong("Dose & volumes"),
      id = "rt_dose",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
    fluidRow(
      column(6,
             numericInput(inputId = "rt_total_dose",
                          label = "What was the total dose used in Radiotherapy? [Gy]",
                          value = "")),
      column(6,
             numericInput(inputId = "rt_fractions",
                          label = "How many number of fractions were given?",
                          value = "")
      )
    ),
    fluidRow(
      column(6,
             numericInput(inputId = "rt_ptv",
                          label = "What was the PTV volume [cm3]?",
                          value = "")
      ),
      column(6,
             numericInput(inputId = "rt_gtv",
                          label = "What was the GTV volume [cm3]?",
                          value = "")
      )),
    fluidRow(
      column(6,
             selectInput(inputId = "rt_previous_area",
                         label = "Is the tumor located in a previously radiated location?",
                         choices = c("",
                                     "Yes",
                                     "No"))),
      column(6,
             selectInput(inputId = "rt_lymphedema",
                         label = "Is the tumor located in a location with pre-existing lymph edema?",
                         choices = c("",
                                     "Yes",
                                     "No"))
      )),
    textAreaInput(inputId = "rt_comment",
                  label = "Comments about radiotherapy",
                  value = "",
                  width = "800px")
    ),
    shinydashboard:: box(
      title = strong("Radiotherapy plan / colorwash"),
      id = "rt_plan_box",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      # fileInput(inputId = "rt_plan",
      #           label = "Upload radiotherapy plan / colorwash",
      #           multiple = FALSE,
      #           accept = ".pdf"),
      uiOutput("rt_plan_download")
    ),
    shinydashboard:: box(
      title = strong("Hyperthermia"),
      id = "rt_hyperthermia_box",
      collapsible = TRUE,
      collapsed = TRUE,
      closable = FALSE,
      width = 12,
      fluidRow(
        column(6,
    selectInput(inputId = "rt_hyperthermia",
                label = "Use of hyperthermia?",
                choices = c("no",
                            #"Yes: Chemotherapy-Hyperthermia",
                            "yes: radiation-hyperthermia"))
      )
    ),
    conditionalPanel(condition = "input.rt_hyperthermia =='yes: radiation-hyperthermia' |
                                  input.rt_hyperthermia =='yes: chemotherapy-hyperthermia'",
                     fluidRow(
                       column(6,
                              selectInput(inputId = "rt_hyperthermia_indication",
                                          label = "Indication of hyperthermia treatment",
                                          choices = c("",
                                                      "preoperative intent, previously irradiated",
                                                      "inoperable, previously irradiated",
                                                      "compression symptoms",
                                                      "palliative situation",
                                                      "other"))
                              )
                       ),
                       conditionalPanel(condition = "input.rt_hyperthermia_indication == 'other'",
                                        fluidRow(
                                          column(6,
                                                textInput(inputId = "rt_hyperthermia_indication_other",
                                                          label = "Please specify 'other' indication",
                                                          value = "")
                                                )
                                          )
                                        ),
                     fluidRow(
                       column(6,
                              airDatepickerInput(inputId = "rt_hyperthermia_start",
                                        label = "Start of hyperthermia treatment",
                                        value = NA,
                                        clearButton = TRUE)
                       ),
                       column(6,
                              airDatepickerInput(inputId = "rt_hyperthermia_end",
                                        label = "End of hyperthermia treatment",
                                        value = NA,
                                        clearButton = TRUE)
                       )
                     ),
                     fluidRow(
                       column(6,
                              selectInput(inputId = "rt_hyperthermia_type",
                                          label = "Type of hyperthermia",
                                          choices = c("" ,"superficial", "deep"))
                              ),
                       column(6,
                              numericInput(inputId = "rt_hyperthermia_sessions",
                                           label = "Number of hyperthermia therapy sessions",
                                           value = "")
                              )
                       ),
                     fluidRow(
                       column(6,
                              textInput(inputId = "rt_hyperthermia_schedule",
                                        label = "Hyperthermia schedule (e.g., 1x per week)",
                                        value = "")
                              ),
                       column(6,
                              selectInput(inputId = "rt_hyperthermia_board",
                                          label = "Swiss hyperthermia board accepted indication",
                                          choices = c("", "Yes", "No"))
                       )
                     )
          )
      ),
    actionButton(inputId = "rt_submit", label = "Save data", class = "btn-warning")
  )
}
