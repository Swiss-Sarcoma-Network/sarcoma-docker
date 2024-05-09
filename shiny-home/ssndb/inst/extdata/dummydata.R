dummydata_amputation <- data.frame(
  pid = c("A1", "A2", "A3"), #compound-pk with sux_date
  sux_date = c(as.Date("2023-01-12"), as.Date("2022-05-15"), as.Date("2023-01-18")),
  amputation_name = c("Not applicable", "resB.62 shoulder joint trans-articular", "Not applicable") # fk-constraint from amputation_name: amputation_name
)

dummydata_cancer_syndrome <- data.frame( ## cancer syndromes are filled in here ##
  pid = c("A1", "A2", "A3"), # compound pk with cancer_syndrome_name
  cancer_syndrome_name = c("Previous cancer", "Neurofibromatosis Type 1", "Other malignancy in family"),
  value = c("Prostata-CA, ED 2011", "", ""),
  default = rep(TRUE, 3)
)

dummydata_hemipelvectomy <- data.frame(
  pid = c("A1", "A2", "A3"), #compound-pk with sux_date
  sux_date = c(as.Date("2023-01-12"), as.Date("2022-05-15"), as.Date("2023-01-18")),
  amputation_name = c("Not applicable", "Not applicable", "resB.45 type IV - 3.1. complete spino-pelvic dissociation") # fk-constraint from hemipelvectomy_name: hemipelvectomy_name
)

dummydata_pathology <- data.frame(
  pid = c("A1", "A2", "A3"), # compound pk with pat_type & pat_date
  pat_type = c("Biopsy of the primary tumor", "Biopsy of local recurrence", "Resection of the primary tumor"),
  pat_type_biopsy = c("Fine needle/Cytology", "Core biopsy (imaging guided)", NA),
  pathologist = c("Beata Bode / Pathoinstitut Enge / pathology", "Peter Bode / Kantonsspital Winterthur (KSW) / pathology", "Philip Went / KSGR / pathology"),
  pat_date = c(as.Date("2023-01-10"), as.Date("2022-05-14"), as.Date("2023-01-17")),
  pat_date_registrate = c(as.Date("2023-01-10"), as.Date("2022-05-14"), as.Date("2023-01-17")),
  pat_date_report = c(as.Date("2023-01-17"), as.Date("2022-05-16"), as.Date("2023-01-24")),
  pat_date_report_final = c(as.Date("2023-01-17"), as.Date("2022-05-18"), as.Date("2023-01-24")),
  pat_reference = c("Yes", "No", "No"),
  pat_date_report_reference = c(as.Date("2023-01-18"), as.Date(NA), as.Date(NA)),
  pat_review_result = c("No discrepancy to primary pathology report", NA, NA),
  pat_priortx = c("No", "Radiotherapy & Chemotherapy", "No"),
  mib = c("11 - 20%", "21 - 30%", "31 - 40%"),
  mitoses = c("0 - 9 mitoses per 10 HPF", "10 - 19 mitoses per 10 HPF", "0 - 9 mitoses per 10 HPF"),
  grade = c("G1", "G2", "G3"),
  diagnosis_name = c("2.3.1. dedifferentiated liposarcoma", "5.3.1. leiomyosarcoma (excluding skin)", "10.3.3. gist"),
  pat_report = rep(NA, 3),
  pat_margin = c(rep(NA, 2), "R0 - Wide margin"),
  necrosis = c(rep(NA, 2), "31 - 40%"),
  distance_margin = c(NA, NA, 12),
  biological_barrier = c(NA, NA, "Periosteum"),
  ihc = c("Yes", "No", "Yes"),
  ihc_result = c("See report", "", "See report"),
  fish = c("Yes", "No", "Yes"),
  fish_result = c("Positive (see report)", "", "Negative (see report)"),
  rna = c("Yes", "No", "Yes"),
  rna_result = c("Positive (see report)", "", "Negative (see report)"),
  dna = c("Yes", "No", "Yes"),
  dna_result = c("Positive (see report)", "", "Negative (see report)")
)

dummydata_personal_clinical <- data.frame(
  pid = c("A1", "A2", "A3"),
  institution = c("Luzerner Kantonsspital (LUKS)",
                  "Kantonsspital Winterthur (KSW)",
                  "Stadtspital Waid und Triemli (SWT)"),
  last_name = c("Schmitt", "Mueller", "Maier"),
  first_name = c("Thomas", "Carla", "Ulrike"),
  date_birth = c(as.Date("1966-04-12"), as.Date("1970-11-03"), as.Date("1956-06-04")),
  gender = c("Male", "Female", "Female"),
  street = c("Angermaierstrasse", "Waldweg", "Schaffhauserstrasse"),
  house_nr = c("12", "1", "3 A"),
  post_code = c(8032, 8001, 8012),
  city = c("Zurich", "Luzern", "Zurich"),
  country = rep("Switzerland", 3),
  phone_number = c("0041797170678", "0041796783542", "0041797687254"),
  email = c("t.schmitt@gmail.com", "carla.mueller@mueller.ch", "ulrike.maier@swissonline.ch"),
  insurance_name = c("CSS", "Swica", "Assura"),
  insurance_class = c("general", "general", "private"),
  insurance_number = c("06432742", "032489237", "23516237"),
  ahv = c("hsad37482", "sahdak73", "A-hajs384"),
  consent = rep(TRUE, 3),
  gp_name = c("Gerrit Peitsch", "Alma Salwesi", "Gerd Müller"),
  gp_email = c("info@peitsch.ch", "a.salwesi@hausarzt-rueschlikon.ch", "info@drmueller.ch"),
  referral_diagnosis = c("Unklare Schwellung am distalen Oberschenkel rechts kurz oberhalb der Patella sowie Atemnot bei Anstrengung",
                         "Diffuse Muskelschmerzen sowie tastbarer Knoten paravertebral links Höhe T5",
                         "Unklare Raumforderung sichtbar auf Mamma-MRI"),
  anatomic_region = c("S12.5. regio femoris anterior distal",
                      "S9.1. regio thoracalis",
                      "D19.1. chest: sternal sternal"),
  anatomic_side = c("Right", "Left", "Midline"),
  clinical_history = c("Schmerzlose Schwellung erstmals bemerkt 1 Monat vor Erstvorstellung, B-Symptome werden verneint. Patient klagt über vermehrte Müdigkeit, sieht dies jedoch eher im Zusammenhang mit long-covid Syndrom",
                       "Erstkonsultation bei HA am 01.04.2022 mit diffusen Muskelschmerzen, rheumatologische und neurologische Abklärung folgend",
                       "Nach auffälliger Mammographie wurde ein MRI der Mamma veranlasst. Mamma unauffällig, jedoch Raumforderung in der Nähe des Sternums gefunden"
  ),
  ecog_initial = c(0, 1, 0),
  last_contact_date = c(as.Date("2023-02-01"), as.Date("2022-12-16"), as.Date("2023-02-20")),
  last_status = c("Alive with disease (AWD)", "Dead of disease (DOD)", "No evidence of disease (NED)"),
  #death_date = c(as.Date(NA), as.Date("2023-02-12"), as.Date(NA)),
  followup_physician = c("Bruno Fuchs", "Gabriela Studer", "Carlo Theus-Steinemann")
)

dummydata_radiology <- data.frame(
  pid = c("A1", "A2", "A3"), # compund pk mit rad_date & rad_type
  rad_date = c(as.Date("2023-01-05"), as.Date("2022-05-10"), as.Date("2023-01-10")),
  rad_timing = c("Initial imaging", "Follow-up imaging", "Initial imaging"),
  rad_type = c("Local imaging", "Systemic imaging", "Local imaging"),
  rad_exam = c("MRI", "PET-CT", "CT scan"),
  size_a = c(120, 80, 76),
  size_b = c(85, 50, 40),
  size_c = c(30, 40, 30),
  fascia = c(as.factor("Epifascial"), as.factor("Subfascial"), as.factor("Subfascial")),
  metastasis = c(NA, "Yes", NA),
  metastasis_number = c(NA, 3, NA),
  metastasis_location = c(NA, "Head", NA),
  metastasis_initial = c(NA, "Yes", NA),
  recist = rep("not-applicable", 3),
  choi = rep("not-applicable", 3),
  percist = rep("not-applicable", 3),
  irecist = rep("not-applicable", 3),
  rad_report = rep("", 3)
)

dummydata_resection <- data.frame(
  pid = c(rep("A1", 3), rep("A2", 3), rep("A3", 1)), # compound uk with sux_date and discipline
  sux_date = c(rep(as.Date("2023-01-12"), 3), rep(as.Date("2022-05-15"), 3), rep(as.Date("2023-01-18"), 1)),
  resection_name = c("resA.4 nerve dissection", "resA.2 muscle resection", "resA.7 vessel resection",
                     "resA.4 nerve dissection", "resA.10 tendon resection", "resA.7 vessel resection",
                     "Not applicable") # fk-constraint from resection_name: resection_name
)

dummydata_sarcoma_board <- data.frame( ## cancer syndromes are filled in here ##
  pid = c("A1", "A2", "A3"), # compound pk with cancer_syndrome_name
  sb_question = c("Therapy?", "Re-biopsy?", "Further dx required?"),
  sb_suggestion = c("Begin with neo-adjuvant RT.",
                    "Open biopsy",
                    "MRI with contrast-agent"),
  fast_track = c("Yes", "No", "No"),
  sb_date = c(as.Date("2022-12-27"), as.Date("2022-08-09"), as.Date("2023-01-03")),
  sb_reason = c("First time presentation (no prior therapy, no WHOOPS, but incl. biopsy)",
                "Follow-up presentation",
                "First time presentation (no prior therapy, no WHOOPS, but incl. biopsy)"),
  sb_current_situation = c("No previous therapy was done",
                           "Locally advanced tumor, incl. pathological fractures",
                           "Exophytic growth"),
  sb_whoops_date = rep(as.Date(NA), 3),
  sb_whoops_institution = rep("Not-applicable", 3),
  sb_followup_status = c("", "Completed therapy for primary tumor", ""),
  sb_prior_therapy = c("", "Surgery", ""),
  sb_followup_reason = c("", "First local recurrence", ""),
  sb_recurrence_date = c(as.Date(NA), as.Date("2022-03-10"), as.Date(NA)),
  sb_recurrence_dates = rep(as.Date(NA), 3),
  ajcc_t = c("T1", "T2", "T3"),
  ajcc_n = c("N0", "N1", "N0"),
  ajcc_m = c("M0", "M1", "M0"),
  ajcc_initial = c("Yes", "No", "Yes"),
  ecog_sb = c(0, 1, 2),
  decision_sux = c("No", "No", "No"),
  decision_sux_comment = rep("", 3),
  decision_rt = c("Yes", "No", "No"),
  decision_rt_comment = c("Neoadjuvant hypo-fractionated RT", "", ""),
  decision_syst = c("No", "No", "No"),
  decision_syst_comment = rep("", 3),
  decision_fup = c("No", "No", "No"),
  decision_fup_comment = rep("", 3),
  decision_diagnostics = c("No", "Yes", "Yes"),
  decision_diagnostics_comment = rep("", 3),
  sb_summary = c("Start with pre-operative hypofractionated RT", "US-guided Bx", "CT"),
  sb_details = c("None", "No", "Nothing"),
  sb_presenting_physician = c(
    "Bruno Fuchs / Luzerner Kantonsspital (LUKS) / sarcoma surgery",
    "Gabriela Studer / Luzerner Kantonsspital (LUKS) / radiation oncology",
    "Bruno Fuchs / Luzerner Kantonsspital (LUKS) / sarcoma surgery"),
  sb_last_decision_executed = c("Yes", "No, due to physician's decision", "No, due to patient's wish")
)

dummydata_surgery_disciplines <- data.frame(
  pid = c(rep("A1", 2), rep("A2", 3), rep("A3", 3)), # compound uk with sux_date and discipline
  sux_date = c(rep(as.Date("2023-01-12"), 2), rep(as.Date("2022-05-15"), 3), rep(as.Date("2023-01-18"), 3)),
  discipline = c("Sarcoma surgery",
                 "Reconstructive surgery",
                 "Visceral surgery",
                 "Chest surgery",
                 "Vascular surgery",
                 "Orthopedics",
                 "Trauma surgery",
                 "Hand surgery")
)

dummydata_surgery <- data.frame(
  pid = c("A1", "A2", "A3"), #compound-pk with sux_date
  sux_date = c(as.Date("2023-01-12"), as.Date("2022-05-15"), as.Date("2023-01-18")),
  sux_institution = c("Luzerner Kantonsspital (LUKS)", "Kantonsspital Winterthur (KSW) - Winterthur", "Universitaetsspital Zuerich (USZ)"), #fk-constraint from institution: institution_name
  sux_indication = c("1st surgery for this reason", "1st surgery after whoops", "1st surgery for this reason"),
  sux_indication_details = c(NA, NA, NA),
  sux_side = c("Right",
               "Left",
               "Midline"),
  sux_anatomic_region = c("D12.5.1 medial / adductor compartment: proximal", "D3.4. inferior to scapula", "B10.5. acetabulum / hip joint: intraarticular"), # fk-constraint from anatomic_region: anatomic_region_name
  sux_size = c(120, 90, 200),
  sux_margin = c("R0 - Wide margin", "R1a - Marginal margin (planned close, ultimative positive)", "R0 - Wide margin")
)

save(dummydata_amputation, dummydata_cancer_syndrome, dummydata_hemipelvectomy,
     dummydata_pathology, dummydata_personal_clinical, dummydata_radiology,
     dummydata_resection, dummydata_sarcoma_board, dummydata_surgery,
     dummydata_surgery_disciplines,
     file = here::here("inst/extdata/dummydata.RData"))
