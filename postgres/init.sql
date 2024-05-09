CREATE SCHEMA IF NOT exists demo;
CREATE TABLE IF NOT exists demo.demo (
    id integer PRIMARY KEY,
    name text
);

TRUNCATE TABLE demo.demo;

INSERT INTO demo.demo VALUES (1, 'Bugs Bunny');
INSERT INTO demo.demo VALUES (2, 'Duffy Duck');
INSERT INTO demo.demo VALUES (3, 'Mighty Mouse');

CREATE SCHEMA IF NOT EXISTS "ssndb";

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."additional_therapy"
(
    "pid"                     TEXT NOT NULL,
    "addtx_therapy_type"      TEXT,
    "addtx_start"             DATE NOT NULL,
    "addtx_end"               DATE NOT NULL,
    "addtx_hyperthermia_type" TEXT,
    "addtx_sessions"          DOUBLE PRECISION,
    "addtx_duration"          DOUBLE PRECISION,
    "addtx_comment"           TEXT,

    CONSTRAINT "additional_therapy_pkey" PRIMARY KEY ("pid", "addtx_start", "addtx_end")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."additional_therapy_type"
(
    "additional_therapy_type" TEXT NOT NULL,

    CONSTRAINT "additional_therapy_type_pkey" PRIMARY KEY ("additional_therapy_type")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."additional_tumor"
(
    "pid"                       TEXT NOT NULL,
    "addtumor_anatomic_side"    TEXT,
    "addtumor_anatomic_region"  TEXT,
    "addtumor_clinical_history" TEXT,

    CONSTRAINT "additional_tumor_pkey" PRIMARY KEY ("pid")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."amputation"
(
    "pid"             TEXT NOT NULL,
    "sux_date"        DATE NOT NULL,
    "amputation_name" TEXT NOT NULL,

    CONSTRAINT "amputation_pkey" PRIMARY KEY ("pid", "sux_date", "amputation_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."amputation_name"
(
    "group"           TEXT,
    "amputation_name" TEXT NOT NULL,

    CONSTRAINT "amputation_name_pkey" PRIMARY KEY ("amputation_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."anatomic_region"
(
    "group"                TEXT,
    "region"               TEXT,
    "sub"                  TEXT,
    "anatomic_region_name" TEXT NOT NULL,

    CONSTRAINT "anatomic_region_pkey" PRIMARY KEY ("anatomic_region_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."cancer_syndrome"
(
    "pid"                  TEXT NOT NULL,
    "cancer_syndrome_name" TEXT NOT NULL,
    "value"                TEXT,
    "default"              BOOLEAN,

    CONSTRAINT "cancer_syndrome_pkey" PRIMARY KEY ("pid", "cancer_syndrome_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."diagnosis_who"
(
    "group"          TEXT,
    "subgroup"       TEXT,
    "diagnosis_name" TEXT NOT NULL,

    CONSTRAINT "diagnosis_who_pkey" PRIMARY KEY ("diagnosis_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."drug"
(
    "drug_group" TEXT,
    "drug_name"  TEXT NOT NULL,
    "default"    BOOLEAN,

    CONSTRAINT "drug_pkey" PRIMARY KEY ("drug_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."hemipelvectomy"
(
    "pid"                 TEXT NOT NULL,
    "sux_date"            DATE NOT NULL,
    "hemipelvectomy_name" TEXT NOT NULL,

    CONSTRAINT "hemipelvectomy_pkey" PRIMARY KEY ("pid", "sux_date", "hemipelvectomy_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."hemipelvectomy_name"
(
    "group"               TEXT,
    "hemipelvectomy_name" TEXT NOT NULL,

    CONSTRAINT "hemipelvectomy_name_pkey" PRIMARY KEY ("hemipelvectomy_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."hyperthermia"
(
    "ht_id"               TEXT,
    "pid"                 TEXT NOT NULL,
    "ht_combination"      TEXT NOT NULL,
    "ht_type"             TEXT,
    "ht_indication"       TEXT,
    "ht_start"            DATE NOT NULL,
    "ht_end"              DATE,
    "ht_sessions"         DOUBLE PRECISION,
    "ht_schedule"         TEXT,
    "ht_board_indication" TEXT,

    CONSTRAINT "hyperthermia_pkey" PRIMARY KEY ("pid", "ht_combination", "ht_start")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."institution"
(
    "institution_name" TEXT NOT NULL,

    CONSTRAINT "institution_pkey" PRIMARY KEY ("institution_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."insurance"
(
    "insurance_name" TEXT NOT NULL,

    CONSTRAINT "insurance_pkey" PRIMARY KEY ("insurance_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."metastasis"
(
    "pid"          TEXT NOT NULL,
    "rad_date"     DATE NOT NULL,
    "rad_type"     TEXT,
    "met_number"   DOUBLE PRECISION,
    "met_location" TEXT NOT NULL,

    CONSTRAINT "metastasis_pkey" PRIMARY KEY ("pid", "rad_date", "met_location")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."other_diagnosis"
(
    "pid"                  TEXT NOT NULL,
    "other_diagnosis_name" TEXT NOT NULL,
    "default"              BOOLEAN,

    CONSTRAINT "other_diagnosis_pkey" PRIMARY KEY ("pid", "other_diagnosis_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."pathology"
(
    "pid"                       TEXT NOT NULL,
    "pat_type"                  TEXT NOT NULL,
    "pat_type_biopsy"           TEXT,
    "pathologist"               TEXT,
    "pat_date"                  DATE NOT NULL,
    "pat_date_registrate"       DATE,
    "pat_date_report"           DATE,
    "pat_date_report_final"     DATE,
    "pat_reference"             TEXT,
    "pat_date_report_reference" DATE,
    "pat_review_result"         TEXT,
    "pat_priortx"               TEXT,
    "mib"                       TEXT,
    "mitoses"                   TEXT,
    "grade"                     TEXT,
    "diagnosis_name"            TEXT,
    "pat_report"                BYTEA,
    "pat_margin"                TEXT,
    "necrosis"                  TEXT,
    "distance_margin"           DOUBLE PRECISION,
    "biological_barrier"        TEXT,
    "ihc"                       TEXT,
    "ihc_result"                TEXT,
    "fish"                      TEXT,
    "fish_result"               TEXT,
    "rna"                       TEXT,
    "rna_result"                TEXT,
    "dna"                       TEXT,
    "dna_result"                TEXT,

    CONSTRAINT "pathology_pkey" PRIMARY KEY ("pid", "pat_type", "pat_date")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."personal_clinical"
(
    "pid"                TEXT NOT NULL,
    "institution"        TEXT,
    "last_name"          TEXT,
    "first_name"         TEXT,
    "date_birth"         DATE,
    "gender"             TEXT,
    "street"             TEXT,
    "house_nr"           TEXT,
    "post_code"          DOUBLE PRECISION,
    "city"               TEXT,
    "country"            TEXT,
    "phone_number"       TEXT,
    "email"              TEXT,
    "insurance_name"     TEXT,
    "insurance_class"    TEXT,
    "insurance_number"   TEXT,
    "ahv"                TEXT,
    "consent"            BOOLEAN,
    "gp_name"            TEXT,
    "gp_email"           TEXT,
    "referral_diagnosis" TEXT,
    "anatomic_region"    TEXT,
    "anatomic_side"      TEXT,
    "clinical_history"   TEXT,
    "ecog_initial"       INTEGER,
    "last_contact_date"  DATE,
    "last_status"        TEXT,
    "death_reason"       TEXT,
    "followup_physician" TEXT,

    CONSTRAINT "personal_clinical_pkey" PRIMARY KEY ("pid")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."radiology"
(
    "pid"                 TEXT NOT NULL,
    "rad_date"            DATE NOT NULL,
    "rad_timing"          TEXT,
    "rad_type"            TEXT NOT NULL,
    "rad_exam"            TEXT,
    "size_a"              DOUBLE PRECISION,
    "size_b"              DOUBLE PRECISION,
    "size_c"              DOUBLE PRECISION,
    "fascia"              TEXT,
    "metastasis"          TEXT,
    "metastasis_number"   DOUBLE PRECISION,
    "metastasis_location" TEXT,
    "metastasis_initial"  TEXT,
    "recist"              TEXT,
    "choi"                TEXT,
    "percist"             TEXT,
    "irecist"             TEXT,
    "rad_report"          BYTEA,
    "rad_report_text"     TEXT,

    CONSTRAINT "radiology_pkey" PRIMARY KEY ("pid", "rad_date", "rad_type")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."radiotherapy"
(
    "pid"                   TEXT NOT NULL,
    "rt_id"                 TEXT,
    "rt_indication"         TEXT,
    "rt_type"               TEXT NOT NULL,
    "rt_date_referral"      DATE,
    "rt_date_first_consult" DATE,
    "rt_start"              DATE NOT NULL,
    "rt_end"                DATE,
    "rt_institution"        TEXT,
    "rt_total_dose"         DOUBLE PRECISION,
    "rt_fractions"          DOUBLE PRECISION,
    "rt_ptv"                DOUBLE PRECISION,
    "rt_gtv"                DOUBLE PRECISION,
    "rt_previous_area"      TEXT,
    "rt_lymphedema"         TEXT,
    "radiation_oncologist"  TEXT,
    "rt_comment"            TEXT,
    "rt_plan"               BYTEA,

    CONSTRAINT "radiotherapy_pkey" PRIMARY KEY ("pid", "rt_type", "rt_start")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."reconstruction"
(
    "pid"                 TEXT NOT NULL,
    "sux_date"            DATE NOT NULL,
    "reconstruction_name" TEXT NOT NULL,

    CONSTRAINT "reconstruction_pkey" PRIMARY KEY ("pid", "sux_date", "reconstruction_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."reconstruction_name"
(
    "group"               TEXT,
    "sub"                 TEXT,
    "reconstruction_name" TEXT NOT NULL,

    CONSTRAINT "reconstruction_name_pkey" PRIMARY KEY ("reconstruction_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."resection"
(
    "pid"            TEXT NOT NULL,
    "sux_date"       DATE NOT NULL,
    "resection_name" TEXT NOT NULL,

    CONSTRAINT "resection_pkey" PRIMARY KEY ("pid", "sux_date", "resection_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."resection_name"
(
    "group"          TEXT,
    "sub"            TEXT,
    "resection_name" TEXT NOT NULL,

    CONSTRAINT "resection_name_pkey" PRIMARY KEY ("resection_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."sarcoma_board"
(
    "pid"                          TEXT NOT NULL,
    "sb_question"                  TEXT,
    "sb_suggestion"                TEXT,
    "fast_track"                   TEXT,
    "sb_date"                      DATE NOT NULL,
    "sb_reason"                    TEXT,
    "sb_current_situation"         TEXT,
    "sb_whoops_date"               DATE,
    "sb_whoops_institution"        TEXT,
    "sb_followup_status"           TEXT,
    "sb_prior_therapy"             TEXT,
    "sb_followup_reason"           TEXT,
    "sb_recurrence_date"           DATE,
    "sb_recurrence_dates"          TEXT,
    "ajcc_t"                       TEXT,
    "ajcc_n"                       TEXT,
    "ajcc_m"                       TEXT,
    "ajcc_initial"                 TEXT,
    "ecog_sb"                      INTEGER,
    "decision_sux"                 TEXT,
    "decision_sux_comment"         TEXT,
    "decision_rt"                  TEXT,
    "decision_rt_comment"          TEXT,
    "decision_syst"                TEXT,
    "decision_syst_comment"        TEXT,
    "decision_fup"                 TEXT,
    "decision_fup_comment"         TEXT,
    "decision_diagnostics"         TEXT,
    "decision_diagnostics_comment" TEXT,
    "decision_palliative"          TEXT,
    "decision_palliative_comment"  TEXT,
    "sb_summary"                   TEXT,
    "sb_details"                   TEXT,
    "sb_presenting_physician"      TEXT,
    "sb_last_decision_executed"    TEXT,

    CONSTRAINT "sarcoma_board_pkey" PRIMARY KEY ("pid", "sb_date")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."sarcoma_board_admin"
(
    "sarcoma_board_admin_id"  INTEGER NOT NULL,
    "sb_date"                 DATE,
    "sb_participants"         TEXT,
    "sb_presenting_physician" BOOLEAN,

    CONSTRAINT "sarcoma_board_admin_pkey" PRIMARY KEY ("sarcoma_board_admin_id")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."sarcoma_board_date"
(
    "sb_date" DATE NOT NULL,

    CONSTRAINT "sarcoma_board_date_pkey" PRIMARY KEY ("sb_date")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."surgery"
(
    "pid"                    TEXT NOT NULL,
    "sux_date"               DATE NOT NULL,
    "sux_institution"        TEXT,
    "sux_indication"         TEXT,
    "sux_indication_details" TEXT,
    "sux_side"               TEXT,
    "sux_anatomic_region"    TEXT,
    "sux_size"               DOUBLE PRECISION,
    "sux_margin"             TEXT,

    CONSTRAINT "surgery_pkey" PRIMARY KEY ("pid", "sux_date")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."surgery_disciplines"
(
    "pid"        TEXT NOT NULL,
    "sux_date"   DATE NOT NULL,
    "discipline" TEXT NOT NULL,

    CONSTRAINT "surgery_disciplines_pkey" PRIMARY KEY ("pid", "sux_date", "discipline")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."systemic_drug"
(
    "systemic_therapy_id" TEXT NOT NULL,
    "drug"                TEXT NOT NULL,
    "dose"                DOUBLE PRECISION,
    "dose_unit"           TEXT,
    "frequency"           DOUBLE PRECISION,
    "frequency_unit"      TEXT,
    "route"               TEXT,
    "administration_day"  TEXT,

    CONSTRAINT "systemic_drug_pkey" PRIMARY KEY ("systemic_therapy_id", "drug")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."systemic_therapy"
(
    "pid"                         TEXT NOT NULL,
    "systemic_therapy_id"         TEXT NOT NULL,
    "syst_reason"                 TEXT,
    "syst_cycles_planned"         DOUBLE PRECISION,
    "syst_institution"            TEXT,
    "syst_start"                  DATE,
    "syst_end"                    DATE,
    "syst_line"                   DOUBLE PRECISION,
    "syst_bone_protocol"          TEXT,
    "syst_softtissue_protocol"    TEXT,
    "syst_reason_discontinuation" TEXT,
    "syst_rct"                    TEXT,
    "syst_clinical_trial"         TEXT,
    "syst_comment"                TEXT,
    "oncologist"                  TEXT,

    CONSTRAINT "systemic_therapy_pkey" PRIMARY KEY ("pid", "systemic_therapy_id")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."toxicity"
(
    "systemic_therapy_id" TEXT NOT NULL,
    "toxicity_name"       TEXT NOT NULL,
    "toxicity_grade"      TEXT,
    "toxicity_type"       TEXT,
    "toxicity_date"       DATE NOT NULL,

    CONSTRAINT "toxicity_pkey" PRIMARY KEY ("systemic_therapy_id", "toxicity_name", "toxicity_date")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."toxicity_name"
(
    "toxicity_name" TEXT NOT NULL,
    "toxicity_type" TEXT,
    "default"       BOOLEAN,

    CONSTRAINT "toxicity_name_pkey" PRIMARY KEY ("toxicity_name")
    );

-- CreateTable
CREATE TABLE IF NOT EXISTS "ssndb"."user"
(
    "user_id"        INTEGER NOT NULL,
    "last_name"      TEXT,
    "first_name"     TEXT,
    "email"          TEXT,
    "institution"    TEXT,
    "discipline"     TEXT,
    "access"         TEXT,
    "reference_from" DATE,
    "reference_to"   DATE,

    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id")
    );

-- CreateIndex
CREATE INDEX IF NOT EXISTS "additional_therapy__addtx_therapy_type" ON "ssndb"."additional_therapy" ("addtx_therapy_type");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "additional_tumor__addtumor_anatomic_region" ON "ssndb"."additional_tumor" ("addtumor_anatomic_region");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "amputation__amputation_name" ON "ssndb"."amputation" ("amputation_name");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "hemipelvectomy__hemipelvectomy_name" ON "ssndb"."hemipelvectomy" ("hemipelvectomy_name");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "pathology__diagnosis_name" ON "ssndb"."pathology" ("diagnosis_name");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "personal_clinical__anatomic_region" ON "ssndb"."personal_clinical" ("anatomic_region");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "reconstruction__reconstruction_name" ON "ssndb"."reconstruction" ("reconstruction_name");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "resection__resection_name" ON "ssndb"."resection" ("resection_name");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "sarcoma_board__sb_date" ON "ssndb"."sarcoma_board" ("sb_date");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "sarcoma_board_admin__sb_date" ON "ssndb"."sarcoma_board_admin" ("sb_date");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "surgery__sux_anatomic_region" ON "ssndb"."surgery" ("sux_anatomic_region");

-- Drop and add constraints for "additional_therapy"
ALTER TABLE "ssndb"."additional_therapy" DROP CONSTRAINT IF EXISTS "additional_therapy_addtx_therapy_type_fkey";
ALTER TABLE "ssndb"."additional_therapy"
    ADD CONSTRAINT "additional_therapy_addtx_therapy_type_fkey" FOREIGN KEY ("addtx_therapy_type") REFERENCES "ssndb"."additional_therapy_type" ("additional_therapy_type") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "additional_tumor"
ALTER TABLE "ssndb"."additional_tumor" DROP CONSTRAINT IF EXISTS "additional_tumor_addtumor_anatomic_region_fkey";
ALTER TABLE "ssndb"."additional_tumor"
    ADD CONSTRAINT "additional_tumor_addtumor_anatomic_region_fkey" FOREIGN KEY ("addtumor_anatomic_region") REFERENCES "ssndb"."anatomic_region" ("anatomic_region_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "amputation"
ALTER TABLE "ssndb"."amputation" DROP CONSTRAINT IF EXISTS "amputation_amputation_name_fkey";
ALTER TABLE "ssndb"."amputation"
    ADD CONSTRAINT "amputation_amputation_name_fkey" FOREIGN KEY ("amputation_name") REFERENCES "ssndb"."amputation_name" ("amputation_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "hemipelvectomy"
ALTER TABLE "ssndb"."hemipelvectomy" DROP CONSTRAINT IF EXISTS "hemipelvectomy_hemipelvectomy_name_fkey";
ALTER TABLE "ssndb"."hemipelvectomy"
    ADD CONSTRAINT "hemipelvectomy_hemipelvectomy_name_fkey" FOREIGN KEY ("hemipelvectomy_name") REFERENCES "ssndb"."hemipelvectomy_name" ("hemipelvectomy_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "pathology"
ALTER TABLE "ssndb"."pathology" DROP CONSTRAINT IF EXISTS "pathology_diagnosis_name_fkey";
ALTER TABLE "ssndb"."pathology"
    ADD CONSTRAINT "pathology_diagnosis_name_fkey" FOREIGN KEY ("diagnosis_name") REFERENCES "ssndb"."diagnosis_who" ("diagnosis_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "personal_clinical"
ALTER TABLE "ssndb"."personal_clinical" DROP CONSTRAINT IF EXISTS "personal_clinical_anatomic_region_fkey";
ALTER TABLE "ssndb"."personal_clinical"
    ADD CONSTRAINT "personal_clinical_anatomic_region_fkey" FOREIGN KEY ("anatomic_region") REFERENCES "ssndb"."anatomic_region" ("anatomic_region_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "reconstruction"
ALTER TABLE "ssndb"."reconstruction" DROP CONSTRAINT IF EXISTS "reconstruction_reconstruction_name_fkey";
ALTER TABLE "ssndb"."reconstruction"
    ADD CONSTRAINT "reconstruction_reconstruction_name_fkey" FOREIGN KEY ("reconstruction_name") REFERENCES "ssndb"."reconstruction_name" ("reconstruction_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "resection"
ALTER TABLE "ssndb"."resection" DROP CONSTRAINT IF EXISTS "resection_resection_name_fkey";
ALTER TABLE "ssndb"."resection"
    ADD CONSTRAINT "resection_resection_name_fkey" FOREIGN KEY ("resection_name") REFERENCES "ssndb"."resection_name" ("resection_name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "sarcoma_board"
ALTER TABLE "ssndb"."sarcoma_board" DROP CONSTRAINT IF EXISTS "sarcoma_board_sb_date_fkey";
ALTER TABLE "ssndb"."sarcoma_board"
    ADD CONSTRAINT "sarcoma_board_sb_date_fkey" FOREIGN KEY ("sb_date") REFERENCES "ssndb"."sarcoma_board_date" ("sb_date") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "sarcoma_board_admin"
ALTER TABLE "ssndb"."sarcoma_board_admin" DROP CONSTRAINT IF EXISTS "sarcoma_board_admin_sb_date_fkey";
ALTER TABLE "ssndb"."sarcoma_board_admin"
    ADD CONSTRAINT "sarcoma_board_admin_sb_date_fkey" FOREIGN KEY ("sb_date") REFERENCES "ssndb"."sarcoma_board_date" ("sb_date") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Drop and add constraints for "surgery"
ALTER TABLE "ssndb"."surgery" DROP CONSTRAINT IF EXISTS "surgery_sux_anatomic_region_fkey";
ALTER TABLE "ssndb"."surgery"
    ADD CONSTRAINT "surgery_sux_anatomic_region_fkey" FOREIGN KEY ("sux_anatomic_region") REFERENCES "ssndb"."anatomic_region" ("anatomic_region_name") ON DELETE NO ACTION ON UPDATE NO ACTION;


-- ---------------------------------------------------------------------------------------------
-- Sample Data
-- ---------------------------------------------------------------------------------------------
-- Sample SQL data inserts for the given Prisma schema

-- Additional Therapy Type
INSERT INTO "ssndb"."additional_therapy_type" ("additional_therapy_type")
VALUES ('Chemotherapy'),
       ('Radiation'),
       ('Surgery'),
       ('Immunotherapy'),
       ('Targeted Therapy');

-- Additional Therapy
INSERT INTO "ssndb"."additional_therapy" ("pid", "addtx_therapy_type", "addtx_start", "addtx_end", "addtx_hyperthermia_type",
                                          "addtx_sessions", "addtx_duration", "addtx_comment")
VALUES ('P001', 'Chemotherapy', '2023-04-01', '2023-04-21', NULL, 6, 120, 'Initial therapy started.'),
       ('P002', 'Radiation', '2023-04-02', '2023-04-22', NULL, 6, 30, 'Follow-up after first session.'),
       ('P003', 'Surgery', '2023-04-03', '2023-04-23', NULL, 1, 240, 'Postoperative care required.'),
       ('P004', 'Immunotherapy', '2023-04-04', '2023-04-24', NULL, 8, 45, 'Monitoring immune response.'),
       ('P005', 'Targeted Therapy', '2023-04-05', '2023-04-25', NULL, 10, 50,
        'Assessing targeted delivery efficiency.');

INSERT INTO "ssndb"."anatomic_region" ("anatomic_region_name")
VALUES ('Lung'),
       ('Breast'),
       ('Brain'),
       ('Colon'),
       ('Skin');


-- Additional Tumor
INSERT INTO "ssndb"."additional_tumor" ("pid", "addtumor_anatomic_side", "addtumor_anatomic_region", "addtumor_clinical_history")
VALUES ('P001', 'Left', 'Lung', 'History of smoking'),
       ('P002', 'Right', 'Breast', 'No significant family history'),
       ('P003', 'Left', 'Brain', 'Previous treatments failed'),
       ('P004', 'Right', 'Colon', 'High-risk patient'),
       ('P005', 'Left', 'Skin', 'Recurring melanoma');

-- Amputation Name
INSERT INTO "ssndb"."amputation_name" ("amputation_name")
VALUES ('Leg'),
       ('Arm'),
       ('Foot'),
       ('Hand'),
       ('Finger')
    ON CONFLICT (amputation_name) DO NOTHING;

-- Amputation
INSERT INTO "ssndb"."amputation" ("pid", "sux_date", "amputation_name")
VALUES ('P001', '2023-04-06', 'Leg'),
       ('P002', '2023-04-07', 'Arm'),
       ('P003', '2023-04-08', 'Foot'),
       ('P004', '2023-04-09', 'Hand'),
       ('P005', '2023-04-10', 'Finger');


-- Anatomic Region
INSERT INTO "ssndb"."anatomic_region" ("anatomic_region_name", "group", "region", "sub")
VALUES ('Head', 'A', 'Upper', 'Cranial'),
       ('Chest', 'B', 'Middle', 'Thoracic'),
       ('Abdomen', 'C', 'Lower', 'Gastrointestinal'),
       ('Leg', 'D', 'Lower', 'Limb'),
       ('Arm', 'E', 'Upper', 'Limb');

-- Cancer Syndrome
INSERT INTO "ssndb"."cancer_syndrome" ("pid", "cancer_syndrome_name", "value", "default")
VALUES ('P001', 'Li-Fraumeni', 'Positive', TRUE),
       ('P002', 'BRCA', 'Negative', FALSE),
       ('P003', 'Hereditary Nonpolyposis', 'Positive', TRUE),
       ('P004', 'Von Hippel-Lindau', 'Negative', FALSE),
       ('P005', 'Peutz-Jeghers', 'Positive', TRUE);

-- Diagnosis WHO
INSERT INTO "ssndb"."diagnosis_who" ("group", "subgroup", "diagnosis_name")
VALUES ('Oncology', 'Cancer', 'Breast Cancer'),
       ('Oncology', 'Cancer', 'Lung Cancer'),
       ('Oncology', 'Cancer', 'Prostate Cancer'),
       ('Oncology', 'Cancer', 'Colorectal Cancer'),
       ('Oncology', 'Cancer', 'Melanoma');

-- Drug
INSERT INTO "ssndb"."drug" ("drug_group", "drug_name", "default")
VALUES ('Chemotherapy', 'Doxorubicin', FALSE),
       ('Immunotherapy', 'Pembrolizumab', TRUE),
       ('Targeted Therapy', 'Trastuzumab', FALSE),
       ('Hormone Therapy', 'Tamoxifen', TRUE),
       ('Chemotherapy', 'Cisplatin', FALSE);

-- Hemipelvectomy Name
INSERT INTO "ssndb"."hemipelvectomy_name" ("hemipelvectomy_name")
VALUES ('Partial'),
       ('Total'),
       ('Extended'),
       ('Complete'),
       ('Subtotal');

-- Hemipelvectomy
INSERT INTO "ssndb"."hemipelvectomy" ("pid", "sux_date", "hemipelvectomy_name")
VALUES ('P001', '2023-04-11', 'Partial'),
       ('P002', '2023-04-12', 'Total'),
       ('P003', '2023-04-13', 'Extended'),
       ('P004', '2023-04-14', 'Complete'),
       ('P005', '2023-04-15', 'Subtotal');

-- Hyperthermia
INSERT INTO "ssndb"."hyperthermia" ("ht_id", "pid", "ht_combination", "ht_type", "ht_indication", "ht_start", "ht_end",
                                    "ht_sessions", "ht_schedule", "ht_board_indication")
VALUES ('HT001', 'P001', 'Comb1', 'Local', 'Cancer treatment', '2023-04-16', '2023-05-16', 5, 'Weekly',
        'Board approved'),
       ('HT002', 'P002', 'Comb2', 'Regional', 'Pain relief', '2023-04-17', '2023-05-17', 5, 'Weekly', 'Board approved'),
       ('HT003', 'P003', 'Comb3', 'Whole-body', 'Immunomodulation', '2023-04-18', '2023-05-18', 5, 'Weekly',
        'Board approved'),
       ('HT004', 'P004', 'Comb4', 'Local', 'Reduce tumor size', '2023-04-19', '2023-05-19', 5, 'Weekly',
        'Board approved'),
       ('HT005', 'P005', 'Comb5', 'Regional', 'Preoperative treatment', '2023-04-20', '2023-05-20', 5, 'Weekly',
        'Board approved');

-- Institution
INSERT INTO "ssndb"."institution" ("institution_name")
VALUES ('City Hospital'),
       ('Regional Medical Center'),
       ('University Clinic'),
       ('Specialized Cancer Center'),
       ('Community Health Center');
