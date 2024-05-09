surgery <- function() {
  tagList(
    card(
      max_height = 400,
      card_header("Surgery summary",
                  class = "text-bg-secondary"),
      card_body(
        height = "auto",
        fillable = FALSE,
        class = "text-bg-secondary",
        DT::dataTableOutput("sux_table")
      ),
      card_footer(
        icon("pen-to-square"),
        "To edit a surgery entry, click the respective row in the table",
        class = "text-bg-secondary"
      )
    ),
    actionButton(inputId = "sux_table_add",
                 label = "Add Surgery",
                 icon = icon("plus")
    ),
    fluidRow(
      column(4,
             airDatepickerInput(inputId = "sux_date",
                       label = "Date of surgery",
                       value = NA)
      ),
      column(4,
             institution_input(inputId = "sux_institution",
                               label = "Institution")
      ),
      column(4,
             selectInput(inputId = "sux_indication",
                         label = "Indication for surgery",
                         choices = c("",
                                     "1st surgery for this reason",
                                     "1st surgery after whoops",
                                     "Pathological fracture",
                                     "1st revision surgery",
                                     "2nd or more revision surgery",
                                     "1st surgery for local recurrence",
                                     "2nd or more surgery for local recurrence",
                                     "1st surgery for metastasis",
                                     "2nd or more surgery for metastasis",
                                     "Other reason"))
      )
    ),
    conditionalPanel(condition = "input.sux_indication=='1st revision surgery'",
                     textInput(inputId = "sux_1strevision",
                               label = "Please specify '1st revision surgery'",
                               value = "")
    ),
    conditionalPanel(condition = "input.sux_indication=='2nd or more revision surgery'",
                     textInput(inputId = "sux_2ndrevision",
                               label = "Please specify '2nd or more revision surgery'",
                               value = "")
    ),
    conditionalPanel(condition = "input.sux_indication=='other reason'",
                     textInput(inputId = "sux_other_reason",
                               label = "Please specify 'Other reason'",
                               value = "")
    ),
    fluidRow(
      column(4,
             selectInput(inputId = "sux_side",
                         label = "Side of surgery",
                         choices = c("",
                                     "Right",
                                     "Left",
                                     "Midline"))
      ),
      column(4,
             numericInput(inputId = "sux_size",
                          label = "Greatest surgical tumor dimension [mm]",
                          value="")
      ),
      column(4,
             selectInput(
               inputId = "sux_spillage",
               label = "Was there tumor spillage?",
               choices = c("Yes", "No"),
               selected = "No")
      )
    ),
    fluidRow(
      column(4,
               tree_ui(
                 input_id = "sux_anatomic_region",
                 label = "anatomic region"
               )
      ),
      column(4,
             tree_ui(
               input_id = "sux_resection",
               label = "resection"
             )
      ),
      column(4,
             tree_ui(
               input_id = "sux_hemipelvectomy",
               label = "hemipelvectomy"
             )
      )
    ),
    fluidRow(
      column(4,
             tree_ui(
               input_id = "sux_reconstruction",
               label = "reconstruction"
             )

        ),
    column(4,
           tree_ui(
             input_id = "sux_amputation",
             label = "amputation"
           )
    )
      ),
    fluidRow(
      column(4,
             selectInput(inputId = "sux_margin",
                         label = "Surgeon's judgement of resected tumor margin",
                         choices = c("",
                                     "R0 - Wide margin",
                                     "R1a - Marginal margin (planned close, ultimative positive)",
                                     "R1b - Marginal margin (positive after tumor bed re-exicision)",
                                     "R1c - Marginal margin (inadvertent positive margin)",
                                     "R2 - Intralesional margin",
                                     "Not applicable because no sarcoma"))
      ),
      column(4,
             selectizeInput(inputId = "sux_disciplines",
                            label = "What disciplines took part in the surgery?",
                            choices = c("",
                                        "Sarcoma surgery",
                                        "Reconstructive surgery",
                                        "Visceral surgery",
                                        "Chest surgery",
                                        "Vascular surgery",
                                        "Orthopedics",
                                        "Trauma surgery",
                                        "Hand surgery",
                                        "Neurosurgery",
                                        "Spine surgery",
                                        "Urology",
                                        "Interventional radiology",
                                        "If other, please add here"),
                            options = list(create = TRUE),
                            multiple = TRUE)
      )
    ),
    actionButton(inputId = "sux_submit", label = "Save data", class = "btn-warning")
  )
}
