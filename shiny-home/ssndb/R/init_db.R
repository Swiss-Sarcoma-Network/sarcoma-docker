#' Initialize the database and load dummy data
#' @description
#' This function removes the current data from the database,
#' copies the data model to the database and adds tables that are reference tables of foreign key
#' constraints (tables: insurance, institution, user, toxicity_name, anatomic_region, sarcoma_board_date).
#' Moreover, dummy data (personal_clinical, cancer_syndrome, sarcoma_board, radiology, pathology, surgery,
#' amputation, resection, surgery_disciplines) can be uploaded onto the database.
#'
#' @param dummy_data logical whether dummy data should be uploaded to the database, defaults to FALSE
#'
#' @return None
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}
#' @keywords init, initialize
#' @importFrom readr read_csv cols
#' @export
#'

init_db <- function(dummy_data = TRUE){

  remove_dm(all = TRUE)

  dm:: copy_dm_to(dest = get_con(), dm = data_model(type = "dm"),
                  temporary = FALSE)

  load(data_path("tables.RData"))

  write_dm(data = list(insurance = insurance,
                       institution = institution,
                       user = user,
                       toxicity_name = toxicity_name,
                       anatomic_region = anatomic_region,
                       sarcoma_board_date = sarcoma_board_date,
                       diagnosis_who = diagnosis_who,
                       drug = drug,
                       resection_name = resection_name,
                       amputation_name = amputation_name,
                       hemipelvectomy_name = hemipelvectomy_name,
                       reconstruction_name = reconstruction_name)
  )

  if (dummy_data == TRUE){

    load(data_path("dummydata.RData"))

    write_dm(data = list(personal_clinical = dummydata_personal_clinical,
                         cancer_syndrome = dummydata_cancer_syndrome,
                         sarcoma_board = dummydata_sarcoma_board,
                         radiology = dummydata_radiology,
                         pathology = dummydata_pathology,
                         amputation = dummydata_amputation,
                         resection = dummydata_resection,
                         surgery = dummydata_surgery,
                         surgery_disciplines = dummydata_surgery_disciplines))

  } else{}
}
