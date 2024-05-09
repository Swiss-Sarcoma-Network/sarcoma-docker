#' UI for the tab "Personal data"
#' @description
#' User-interface for the tab "Personal data" which is added to ui.R
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords personal, ui
#'
#' @export

personal <- function() {
  tagList(
    shinyjs::useShinyjs(),
    fluidRow(
      column(6,
             actionButton(
               inputId = "personal_add",
               label = "Add new patient",
               class = "btn-warning"),
             textInput(
               inputId = "personal_pid_new",
               label = labelMandatory("PID for new patient"))
      )
    ),
    fluidRow(
      column(6,
             checkboxInput(
               inputId = "personal_consent",
               label = "Did the patient give informed consent?",
               value = FALSE)
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_ahv",
               label = "AHV number",
               value = "")
      ),
      column(6,
             institution_input(
               inputId = "personal_institution",
               label = "Institution")
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_last_name",
               label = "Last name",
               value = "")
      ),
      column(6,
             textInput(
               inputId = "personal_first_name",
               label = "First name",
               value = "")
      )
    ),
    fluidRow(
      column(6,
             airDatepickerInput(
               inputId = "personal_date_birth",
               label = "Date of birth",
               value = NA,
               clearButton = TRUE)
      ),
      column(6,
             selectInput(
               inputId = "personal_gender",
               label = "Gender",
               choices = c("",
                           "Male",
                           "Female"))
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_street",
               label = "Address: Street",
               value = "")
      ),
      column(6,
             textInput(inputId = "personal_house_nr",
                       label = "House number",
                       value = "")
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_post_code",
               label = "Post code",
               value = "")
      ),
      column(6,
             textInput(
               inputId = "personal_city",
               label = "City",
               value = "")
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_country",
               label = "Country",
               value = "Switzerland")
      ),
      column(6,
             textInput(
               inputId = "personal_phone_number",
               label = "Phone number (incl. country code)",
               value = "0041")
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_email",
               label = "E-Mail address of the patient",
               value = "")
      ),
      column(6,
             selectizeInput(
               inputId = "personal_insurance_name",
               label = "Insurance company",
               choices = get_column(table = "insurance", column = "insurance_name"),
               options = list(create=TRUE))
      )
    ),
    fluidRow(
      column(6,
             selectInput(
               inputId = "personal_insurance_class",
               label = "Insurance class",
               choices = c("",
                           "general",
                           "half-private",
                           "private",
                           "self-paying"))
      ),
      column(6,
             textInput(
               inputId = "personal_insurance_number",
               label = "Insurance number",
               value = "")
      )
    ),
    fluidRow(
      column(6,
             textInput(
               inputId = "personal_gp_name",
               label = "Name of general practitioner",
               value = "")
      ),
      column(6,
             textInput(
               inputId = "personal_gp_email",
               label = "E-Mail address of general practitioner",
               value = "")
      )
    ),
    actionButton(
      inputId = "personal_submit",
      label = "Save data",
      class = "btn-warning")
  )
}
