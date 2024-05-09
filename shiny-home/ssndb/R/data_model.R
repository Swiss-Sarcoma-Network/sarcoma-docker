#' Print data model as list or as dm object
#' @description
#' Specifies and prints data model as a list of dataframes or as a dm object
#'
#' @param type specifies whether to print as "list" or as "dm"
#'
#' @return returns data model as a list of dataframes (when type = "list") or as a dm object (when type = "dm")
#'
#' @author Philip Heesen, \email{philip.heesen@@uzh.ch}, Nicolas Bennett, \email{nicolas@@cynkra.com}
#'
#' @keywords data, model
#'
#' @importFrom dm dm
#' @importFrom dm dm_add_pk
#' @importFrom dm dm_add_fk
#' @importFrom dm dm_add_uk
#'
#' @export

data_model <- function(type){
  personal_clinical <- data.frame(
    pid = character(), # pk
    institution = factor(), # fk-constraint from institution: institution_name
    last_name = character(),
    first_name = character(),
    date_birth = structure(numeric(), class = "Date"),
    gender = factor(),
    street = character(),
    house_nr = character(),
    post_code = numeric(),
    city = character(),
    country = character(),
    phone_number = character(),
    email = character(),
    insurance_name = character(), # fk-constraint from insurance: insurance_name
    insurance_class = factor(),
    insurance_number = character(),
    ahv = character(),
    consent = logical(),
    gp_name = character(),
    gp_email = character(),
    referral_diagnosis = character(),
    anatomic_region = factor(), # fk-constraint from anatomic_region: anatomic_region_name
    anatomic_side = factor(),
    clinical_history = character(),
    ecog_initial = integer(),
    last_contact_date = structure(numeric(), class = "Date"),
    last_status = factor(),
    death_reason = factor(),
    followup_physician = character()
  )

  additional_tumor <- data.frame(
    pid = character(), # pk
    addtumor_anatomic_side = factor(),
    addtumor_anatomic_region = factor(), # fk-constraint from anatomic_region: anatomic_region_name
    addtumor_clinical_history = character()
  )

  institution <- data.frame(
    institution_name = character() # pk
  )

  insurance <- data.frame(
    insurance_name = character() # pk
  )

  anatomic_region <- data.frame(
    group = character(),
    region = character(),
    sub = character(),
    anatomic_region_name = character() # pk
  )

  cancer_syndrome <- data.frame(
    pid = character(), # compound pk with cancer_syndrome_name
    cancer_syndrome_name = character(),
    value = character(),
    default = logical()
  )

  other_diagnosis <- data.frame(
    pid = character(), # compound pk with other_diagnosis_name
    other_diagnosis_name = character(),
    default = logical()
  )

  sarcoma_board <- data.frame(
    pid = character(), # compound pk with sb_date
    sb_question = character(),
    sb_suggestion = character(),
    fast_track = factor(),
    sb_date = structure(numeric(), class = "Date"), # fk-constraint from sarcoma_board_date: sb_date
    sb_reason = factor(),
    sb_current_situation = factor(),
    sb_whoops_date = structure(numeric(), class = "Date"),
    sb_whoops_institution = factor(),
    sb_followup_status = factor(),
    sb_prior_therapy = factor(),
    sb_followup_reason = factor(),
    sb_recurrence_date = structure(numeric(), class = "Date"),
    sb_recurrence_dates = character(),
    ajcc_t = factor(),
    ajcc_n = factor(),
    ajcc_m = factor(),
    ajcc_initial = factor(),
    ecog_sb = integer(),
    decision_sux = factor(),
    decision_sux_comment = character(),
    decision_rt = factor(),
    decision_rt_comment = character(),
    decision_syst = factor(),
    decision_syst_comment = character(),
    decision_fup = factor(),
    decision_fup_comment = character(),
    decision_diagnostics = factor(),
    decision_diagnostics_comment = character(),
    decision_palliative = factor(),
    decision_palliative_comment = character(),
    sb_summary = character(),
    sb_details = character(),
    sb_presenting_physician = factor(),
    sb_last_decision_executed = factor()
  )

  sarcoma_board_date <- data.frame( # Init
    sb_date = structure(numeric(), class = "Date") # pk
  )

  sarcoma_board_admin <- data.frame(
    sarcoma_board_admin_id = integer(), # pk
    sb_date = structure(numeric(), class = "Date"), # fk-constraint from sarcoma_board_date: sb_date
    sb_participants = factor(),
    sb_presenting_physician = logical() # Indicator which one is the presenting physician
  )

  radiology <- data.frame(
    pid = character(), # compund pk mit rad_date & rad_type
    rad_date = structure(numeric(), class = "Date"),
    rad_timing = factor(),
    rad_type = factor(),
    rad_exam = factor(),
    size_a = numeric(),
    size_b = numeric(),
    size_c = numeric(),
    fascia = factor(),
    metastasis = factor(),
    metastasis_number = numeric(), ## do we need this?
    metastasis_location = character(), ## do we need this?
    metastasis_initial = factor(), ## do we need this?
    recist = factor(),
    choi = factor(),
    percist = factor(),
    irecist = factor(),
    rad_report = blob(),
    rad_report_text = character()
  )

  metastasis <- data.frame(
    pid = character(), # pk with rad_date and met_location
    rad_date = structure(numeric(), class = "Date"),
    rad_type = factor(),
    met_number = numeric(),
    met_location = factor()
  )

  pathology <- data.frame(
    pid = character(), # compound pk with pat_type & pat_date
    pat_type = factor(),
    pat_type_biopsy = factor(),
    pathologist = character(),
    pat_date = structure(numeric(), class = "Date"),
    pat_date_registrate = structure(numeric(), class = "Date"),
    pat_date_report = structure(numeric(), class = "Date"),
    pat_date_report_final = structure(numeric(), class = "Date"),
    pat_reference = factor(),
    pat_date_report_reference = structure(numeric(), class = "Date"),
    pat_review_result = factor(),
    pat_priortx = factor(),
    mib = factor(),
    mitoses = factor(),
    grade = factor(),
    diagnosis_name = factor(), # fk-constraint from diagnosis_who: diagnosis_name
    pat_report = blob(),
    pat_margin = factor(),
    necrosis = factor(),
    distance_margin = numeric(),
    biological_barrier = factor(),
    ihc = factor(),
    ihc_result = factor(),
    fish = factor(),
    fish_result = factor(),
    rna = factor(),
    rna_result = factor(),
    dna = factor(),
    dna_result = factor()
  )

  diagnosis_who <- data.frame(
    group = character(),
    subgroup = character(),
    diagnosis_name = character() # pk
  )

  user <- data.frame(
    user_id = integer(), # pk
    last_name = character(),
    first_name = character(),
    email = character(),
    institution = character(),
    discipline = factor(),
    access = factor(),
    reference_from = structure(numeric(), class = "Date"),
    reference_to = structure(numeric(), class = "Date")
  )

  surgery <- data.frame(
    pid = character(), #compound-pk with sux_date
    sux_date = structure(numeric(), class = "Date"),
    sux_institution = factor(), #fk-constraint from institution: institution_name
    sux_indication = factor(),
    sux_indication_details = character(),
    sux_side = factor(),
    sux_anatomic_region = factor(), # fk-constraint from anatomic_region: anatomic_region_name
    sux_size = numeric(),
    sux_margin = factor()
  )

  surgery_disciplines <- data.frame(
    pid = character(), # compound uk with sux_date and discipline
    sux_date = structure(numeric(), class = "Date"),
    discipline = character()
  )

  resection <- data.frame(
    pid = character(), # compound pk with sux_date and resection_name
    sux_date = structure(numeric(), class = "Date"),
    resection_name = factor() # fk-constraint from resection_name: resection_name
  )

  resection_name <- data.frame(
    group = character(),
    sub = character(),
    resection_name = character() # pk
  )

  amputation <- data.frame(
    pid = character(), # compound pk with sux_date and amputation_name
    sux_date = structure(numeric(), class = "Date"),
    amputation_name = character() # fk-constraint from amputation_name: amputation_name
  )

  amputation_name <- data.frame(
    group = character(),
    amputation_name = character() # pk
  )

  hemipelvectomy <- data.frame(
    pid = character(), # compound pk with sux_date and amputation_name
    sux_date = structure(numeric(), class = "Date"),
    hemipelvectomy_name = character() # fk-constraint from amputation_name: amputation_name
  )


  hemipelvectomy_name <- data.frame(
    group = character(),
    hemipelvectomy_name = character() # pk
  )

  reconstruction <- data.frame(
    pid = character(), # compound pk with sux_date and reconstruction_name
    sux_date = structure(numeric(), class = "Date"),
    reconstruction_name = factor() # fk-constraint from reconstruction_name: reconstruction_name
  )

  reconstruction_name <- data.frame(
    group = character(),
    sub = character(),
    reconstruction_name = character() # pk
  )

  radiotherapy <- data.frame(
    pid = character(), # compound pk with rt_type and rt_start
    rt_id = character(),
    rt_indication = factor(),
    rt_type = factor(),
    rt_date_referral = structure(numeric(), class = "Date"),
    rt_date_first_consult = structure(numeric(), class = "Date"),
    rt_start = structure(numeric(), class = "Date"),
    rt_end = structure(numeric(), class = "Date"),
    rt_institution = factor(), # fk-constraint from institution: institution_name
    rt_total_dose = numeric(),
    rt_fractions = numeric(),
    rt_ptv = numeric(),
    rt_gtv = numeric(),
    rt_previous_area = factor(),
    rt_lymphedema = factor(),
    radiation_oncologist = character(),
    rt_comment = character(),
    rt_plan = blob()
  )

  additional_therapy <- data.frame(
    pid = character(),  # compound pk with addtx_start and addtx_end
    addtx_therapy_type = factor(), # fk-constraint from additional_therapy_type: additional_therapy_type
    addtx_start = structure(numeric(), class = "Date"),
    addtx_end = structure(numeric(), class = "Date"),
    addtx_hyperthermia_type = factor(),
    addtx_sessions = numeric(),
    addtx_duration = numeric(),
    addtx_comment = character()
  )

  additional_therapy_type <- data.frame(
    additional_therapy_type = character() # pk
  )

  systemic_therapy <- data.frame(
    pid = character(), # pk with systemic_therapy_id
    systemic_therapy_id = character(),# fk-constraint from systemic_therapy_cycle: systemic_therapy_id
    # systemic_therapy_id = paste(pid, syst_start, syst_end, sep = "_")
    syst_reason = factor(),
    syst_cycles_planned = numeric(),
    syst_institution = factor(), # fk-constraint from institution: institution_name
    syst_start = structure(numeric(), class = "Date"),
    syst_end = structure(numeric(), class = "Date"),
    syst_line = numeric(),
    syst_bone_protocol = factor(),
    syst_softtissue_protocol = factor(),
    syst_reason_discontinuation = factor(),
    syst_rct = factor(),
    syst_clinical_trial = factor(),
    syst_comment = character(),
    oncologist = character()
  )

  toxicity <- data.frame( # pk systemic_therapy_cycle_id and toxicity_name and toxicity_date
    systemic_therapy_id = character(), # fk-constraint from systemic_therapy: systemic_therapy_id
    toxicity_name = character(), # fk-constraint from toxicity_name: toxicity_name
    toxicity_grade = factor(),
    toxicity_type = factor(),
    toxicity_date = structure(numeric(), class = "Date")
  )

  toxicity_name <- data.frame(
    toxicity_name = character(), # pk
    toxicity_type = factor(),
    default = logical()
  )

  systemic_drug <- data.frame( # pk systemic_therapy_id and drug
    systemic_therapy_id = character(), # fk-constraint from systemic_therapy: systemic_therapy_id
    drug = factor(), #fk-constraint from drug: drug_name
    dose = numeric(),
    dose_unit = factor(),
    frequency = numeric(),
    frequency_unit = factor(),
    route = factor(),
    administration_day = character()
  )

  drug <- data.frame(
    drug_group = character(),
    drug_name = character(), # pk
    default = logical()
  )

  hyperthermia <- data.frame(
    ht_id = character(),
    pid = character(),
    ht_combination = factor(), # pk ht_combination and ht_start
    ht_type = factor(),
    ht_indication = factor(),
    ht_start = structure(numeric(), class = "Date"),
    ht_end = structure(numeric(), class = "Date"),
    ht_sessions = numeric(),
    ht_schedule = character(),
    ht_board_indication = factor()
  )

  dat <- list(
  personal_clinical = personal_clinical,
  additional_tumor = additional_tumor,
  institution = institution,
  insurance = insurance,
  anatomic_region = anatomic_region,
  cancer_syndrome = cancer_syndrome,
  other_diagnosis = other_diagnosis,
  sarcoma_board = sarcoma_board,
  sarcoma_board_date = sarcoma_board_date,
  sarcoma_board_admin = sarcoma_board_admin,
  radiology = radiology,
  metastasis = metastasis,
  pathology = pathology,
  user = user,
  diagnosis_who = diagnosis_who,
  surgery = surgery,
  surgery_disciplines = surgery_disciplines,
  resection = resection,
  resection_name = resection_name,
  amputation = amputation,
  amputation_name = amputation_name,
  hemipelvectomy = hemipelvectomy,
  hemipelvectomy_name = hemipelvectomy_name,
  reconstruction = reconstruction,
  reconstruction_name = reconstruction_name,
  radiotherapy = radiotherapy,
  additional_therapy = additional_therapy,
  additional_therapy_type = additional_therapy_type,
  systemic_therapy = systemic_therapy,
  toxicity = toxicity,
  toxicity_name = toxicity_name,
  systemic_drug = systemic_drug,
  drug = drug,
  hyperthermia = hyperthermia
  )

  ######Setting up dm ######

  db <- dm(personal_clinical,
           additional_tumor,
           institution,
           insurance,
           anatomic_region,
           cancer_syndrome,
           other_diagnosis,
           sarcoma_board,
           sarcoma_board_date,
           sarcoma_board_admin,
           radiology,
           metastasis,
           pathology,
           user,
           diagnosis_who,
           surgery,
           surgery_disciplines,
           resection,
           resection_name,
           amputation,
           amputation_name,
           hemipelvectomy,
           hemipelvectomy_name,
           reconstruction,
           reconstruction_name,
           radiotherapy,
           additional_therapy,
           additional_therapy_type,
           systemic_therapy,
           toxicity,
           toxicity_name,
           systemic_drug,
           drug,
           hyperthermia
  )

  dm <- db |>
    dm_add_pk(table = personal_clinical, columns = pid) |>
    dm_add_pk(table = additional_tumor, columns = pid) |>
    dm_add_pk(table = institution, columns = institution_name) |>
    dm_add_pk(table = insurance, columns = insurance_name) |>
    dm_add_pk(table = anatomic_region, columns = anatomic_region_name) |>
    dm_add_pk(table = cancer_syndrome, columns = c(pid, cancer_syndrome_name)) |>
    dm_add_pk(table = other_diagnosis, columns = c(pid, other_diagnosis_name)) |>
    dm_add_pk(table = sarcoma_board, columns = c(pid, sb_date)) |>
    dm_add_pk(table = sarcoma_board_date, columns = sb_date) |>
    dm_add_pk(table = sarcoma_board_admin, columns = sarcoma_board_admin_id) |>
    dm_add_pk(table = radiology, columns = c(pid, rad_date, rad_type)) |>
    dm_add_pk(table = metastasis, columns = c(pid, rad_date, met_location)) |>
    dm_add_pk(table = pathology, columns = c(pid, pat_type, pat_date)) |>
    dm_add_pk(table = user, columns = user_id) |>
    dm_add_pk(table = diagnosis_who, columns = diagnosis_name) |>
    dm_add_pk(table = surgery, columns = c(pid, sux_date)) |>
    dm_add_pk(table = surgery_disciplines, columns = c(pid, sux_date, discipline)) |>
    dm_add_pk(table = resection, columns = c(pid, sux_date, resection_name)) |>
    dm_add_pk(table = resection_name, columns = resection_name) |>
    dm_add_pk(table = amputation, columns = c(pid, sux_date, amputation_name)) |>
    dm_add_pk(table = amputation_name, columns = amputation_name) |>
    dm_add_pk(table = hemipelvectomy_name, columns = hemipelvectomy_name) |>
    dm_add_pk(table = hemipelvectomy, columns = c(pid, sux_date, hemipelvectomy_name)) |>
    dm_add_pk(table = reconstruction, columns = c(pid, sux_date, reconstruction_name)) |>
    dm_add_pk(table = reconstruction_name, columns = reconstruction_name) |>
    dm_add_pk(table = radiotherapy, columns = c(pid, rt_type, rt_start)) |>
    dm_add_pk(table = additional_therapy, columns = c(pid, addtx_start, addtx_end)) |>
    dm_add_pk(table = additional_therapy_type, columns = additional_therapy_type) |>
    dm_add_pk(table = systemic_therapy, columns = c(pid, systemic_therapy_id)) |>
    dm_add_pk(table = toxicity, columns = c(systemic_therapy_id, toxicity_name, toxicity_date)) |>
    dm_add_pk(table = toxicity_name, columns = toxicity_name) |>
    dm_add_pk(table = systemic_drug, columns = c(systemic_therapy_id, drug)) |>
    dm_add_pk(table = drug, columns = drug_name) |>
    dm_add_pk(table = hyperthermia, columns = c(pid, ht_combination, ht_start)) |>
    # dm_add_fk(table = personal_clinical, columns = insurance_name,
    #           ref_table = insurance, ref_columns = insurance_name,
    #           check = TRUE) |>
    # dm_add_fk(table = personal_clinical, columns = institution,
    #           ref_table = institution, ref_columns = institution_name,
    #           check = TRUE) |>
    dm_add_fk(table = personal_clinical, columns = anatomic_region,
              ref_table = anatomic_region, ref_columns = anatomic_region_name,
              check = TRUE) |>
    dm_add_fk(table = additional_tumor, columns = addtumor_anatomic_region,
              ref_table = anatomic_region, ref_columns = anatomic_region_name,
              check = TRUE) |>
    dm_add_fk(table = sarcoma_board, columns = sb_date,
              ref_table = sarcoma_board_date, ref_columns = sb_date,
              check = TRUE) |>
    dm_add_fk(table = sarcoma_board_admin, columns = sb_date,
              ref_table = sarcoma_board_date, ref_columns = sb_date,
              check = TRUE) |>
    dm_add_fk(table = pathology, columns = diagnosis_name,
              ref_table = diagnosis_who, ref_columns = diagnosis_name,
              check = TRUE) |>
    dm_add_fk(table = surgery, columns = sux_anatomic_region,
              ref_table = anatomic_region, ref_columns = anatomic_region_name,
              check = TRUE) |>
    # dm_add_fk(table = surgery, columns = sux_institution,
    #           ref_table = institution, ref_columns = institution_name,
    #           check = TRUE) |>
    dm_add_fk(table = resection, columns = resection_name,
              ref_table = resection_name, ref_columns = resection_name,
              check = TRUE) |>
    dm_add_fk(table = amputation, columns = amputation_name,
              ref_table = amputation_name, ref_columns = amputation_name,
              check = TRUE) |>
    dm_add_fk(table = reconstruction, columns = reconstruction_name,
              ref_table = reconstruction_name, ref_columns = reconstruction_name,
              check = TRUE) |>
    dm_add_fk(table = hemipelvectomy, columns = hemipelvectomy_name,
              ref_table = hemipelvectomy_name, ref_columns = hemipelvectomy_name,
              check = TRUE) |>
    # dm_add_fk(table = radiotherapy, columns = rt_institution,
    #           ref_table = institution, ref_columns = institution_name,
    #           check = TRUE) |>
    dm_add_fk(table = additional_therapy, columns = addtx_therapy_type,
              ref_table = additional_therapy_type, ref_columns = additional_therapy_type,
              check = TRUE)
    # dm_add_fk(table = systemic_therapy, columns = syst_institution,
    #           ref_table = institution, ref_columns = institution_name,
    #           check = TRUE) |>
    # dm_add_fk(table = toxicity, columns = toxicity_name,
    #           ref_table = toxicity_name, ref_columns = toxicity_name,
    #           check = TRUE) |>
    # dm_add_fk(table = systemic_drug, columns = drug,
    #           ref_table = drug, ref_columns = drug_name,
    #           check = TRUE)

  if(type == "list"){
    dat
  }
  else {dm}

}
