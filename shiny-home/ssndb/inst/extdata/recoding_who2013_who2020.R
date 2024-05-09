### Recoding WHO 2013 -> 2020 ###

##### WHO 2013 #####
diagnosis_who <- data.frame(
  group = c(
    "Not yet established",
    rep("soft tissue", 124),
    rep("bone", 52),
    rep("tumor syndromes", 11),
    rep("non-neoplastic / tumor simulator", 1),
    rep("metastasis", 13),
    rep("lymphoma / myeloma / leukemia", 3),
    rep("sequelae of treatment", 7)
  ),
  subgroup = c( "Not yet established",
                ### soft tissue
                rep("adipocytic tumors", 16),
                rep("fibroblastic / myofibroblastic tumors", 37),
                rep("so called fibrohistiocytic tumors", 4),
                rep("smooth muscle tumors", 2),
                rep("pericytic (perivascular) tumors", 3),
                rep("skeletal muscle tumors", 5),
                rep("vascular tumors of soft tissue", 12),
                rep("condro-osseous tumors", 4),
                rep("nerve sheath tumor", 16),
                rep("tumors of uncertain differentiation", 23),
                rep("undifferentiated / unclassified sarcoma", 2),
                ### bone
                rep("chondrogenic tumors", 13),
                rep("osteogenic tumors", 11),
                rep("fibrogenic tumors", 2),
                rep("fibrohistiocytic tumors", 2),
                rep("ewing sarcoma", 1),
                rep("osteoclastic giant cell rich tumors", 3),
                rep("notochordal tumors", 2),
                rep("vascular tumors", 4),
                rep("myogenic, lipogenic & epithelial tumors", 5),
                rep("tumors of undefined neoplastic nature", 8),
                rep("undifferentiated high-grade pleomorphic sarcoma", 1),
                ### tumor syndromes
                rep("tumor syndromes", 11),
                ### non-neoplastic / tumor simulator
                rep("non-neoplastic / tumor simulator", 1),
                ### metastasis
                rep("metastasis", 13),
                ### lymphoma / myeloma / leukemia
                rep("lymphoma / myeloma / leukemia", 3),
                ### sequelae of treatment
                rep("St. post implantation of tumor prosthesis", 6),
                rep("other sequelae of treatment", 1)
  ),
  diagnosis_name = c(
    "99 not yet established",
    ### adipocytic tumors
    "2.1.1. lipoma",
    "2.1.2. lipomatosis",
    "2.1.3. lipomatosis of nerve",
    "2.1.4. lipoblastoma / lipoblastomatosis",
    "2.1.5. angiolipoma",
    "2.1.6. myolipoma",
    "2.1.7. chondroid lipoma",
    "2.1.8. extra-renal angiomyolipoma",
    "2.1.9. extra‐adrenal myelolipoma",
    "2.1.10. spindle cell / pleomorphic lipoma",
    "2.1.11. hibernoma",
    "2.2.1. atypical lipomatous tumor / well differentiated liposarcoma",
    "2.3.1. dedifferentiated liposarcoma",
    "2.3.2. myxoid liposarcoma",
    "2.3.3. pleomorphic liposarcoma",
    "2.3.4. liposarcoma NOS",
    ### fibroblastic / myofibroblastic tumors
    "3.1.1. nodular fasciitis",
    "3.1.2. proliferative fasciitis",
    "3.1.3. proliferative myositis",
    "3.1.4. myositis ossificans",
    "3.1.5. fibro‐osseous pseudotumor of digits",
    "3.1.6. ischemic fasciitis",
    "3.1.7. elastofibroma",
    "3.1.8. fibrous hamartoma of infancy",
    "3.1.9. fibromatosis colli",
    "3.1.10. juvenile hyaline fibromatosis",
    "3.1.11. inclusion body fibromatosis",
    "3.1.12. fibroma of tendon sheath",
    "3.1.13. desmoplastic fibroblastoma",
    "3.1.14. mammary-type myofibroblastoma",
    "3.1.15. calcifying aponeurotic fibroma",
    "3.1.16. angiomyofibroblastoma",
    "3.1.17. cellular angiofibroma",
    "3.1.18. Nuchal-type fibroma",
    "3.1.19. Gardner fibroma",
    "3.1.20. calcifying fibrous tumor",
    "3.2.1. palmar/plantar fibromatosis",
    "3.2.2. desmoid‐type fibromatosis",
    "3.2.3. lipofibromatosis",
    "3.2.4. giant cell fibroblastoma",
    "3.2.5. dermatofibrosarcoma protuberans",
    "3.2.6. fibrosarcomatous dermatofibrosarcoma protuberans",
    "3.2.7. pigmented dermatofibrosarcoma protuberans",
    "3.2.8. solitary fibrous tumor",
    "3.2.9. solitary fibrous tumor, malignant",
    "3.2.10. inflammatory myofibroblastic sarcoma",
    "3.2.11. low-grade myofibroblastic sarcma",
    "3.2.12. myxoinflammatory fibroblastic sarcoma",
    "3.2.13. infantile fibrosarcoma",
    "3.3.1. adult fibrosarcoma",
    "3.3.2. myxofibrosarcoma",
    "3.3.3. low‐grade fibromyxoid sarcoma (Evans tumor)",
    "3.3.4. sclerosing epithelioid fibrosarcoma",
    ### so called fibrohistiocytic tumors
    "4.1.1. deep benign fibrous histiocytoma",
    "4.2.1. tenosynovial giant cell tumor",
    "4.2.2. plexiform fibrohistiocytic tumor",
    "4.2.3. giant cell tumor of soft tissues",
    ### smooth muscle tumors
    "5.1.1. deep leiomyoma",
    "5.3.1. leiomyosarcoma (excluding skin)",
    ### pericytic (perivascular) tumors
    "6.1.1. angioleiomyoma",
    "6.2.1. glomus tumor and variants",
    "6.2.2. myopericytoma",
    ### skeletal muscle tumors
    "7.1.1. rhabdomyoma",
    "7.3.1. embryonal rhabdomyosarcoma",
    "7.3.2. alveolar rhabdomyosarcoma",
    "7.3.3. pleomorphic rhabdomyosarcoma",
    "7.3.4. spindle cell / sclerosing rhabdomyosarcoma",
    ### vascular tumors of soft tissue
    "8.1.1. hemangioma",
    "8.1.2. epithelioid hemangioma",
    "8.1.3. angiomatosis",
    "8.1.4. lymphangioma",
    "8.2.1. kaposiform hemangioendothelioma",
    "8.2.2. retiform hemangioendothelioma",
    "8.2.3. papillary intralymphatic angioendothelioma",
    "8.2.4. composite hemangioendothelioma",
    "8.2.5. pseudomyogenic (epithelioid sarcoma‐like) hemangioendothelioma",
    "8.2.6. kaposi sarcoma",
    "8.3.1. epithelioid hemangioendothelioma",
    "8.3.2. angiosarcoma of soft tissues",
    ### condro-osseous tumors
    "9.1.1. soft tissue chondroma",
    "9.3.1. extraskeletal mesenchymal chondrosarcoma",
    "9.3.2. extraskeletal osteosarcoma",
    "10.3.3. gist",
    ### nerve sheath tumor
    "11.1.1. schwannoma (including variants)",
    "11.1.2. melanotic schwannoma",
    "11.1.3. neurofibroma (incl. variants)",
    "11.1.4. perineurioma",
    "11.1.5. granular cell tumor",
    "11.1.6. dermal nerve sheath tumor",
    "11.1.7. solitary circumscribed neuroma",
    "11.1.8. ectopic meningioma",
    "11.1.9. nasal glial heterotopia",
    "11.1.10. benign triton tumor",
    "11.1.11. hybrid nerve sheath tumors",
    "11.3.1. malignant peripheral nerve sheath tumor",
    "11.3.2. epithelioid malignant peripheral nerve sheath tumor",
    "11.3.3. malignant triton tumor",
    "11.3.4. malignant granular cell tumor",
    "11.3.5. ectomesenchymoma",
    ### tumors of uncertain differentiation
    "12.1.1. acral fibromyxoma",
    "12.1.2. intramuscular myxoma (incl. variants)",
    "12.1.3. juxtra-articular myxoma",
    "12.1.4. deep (‘aggressive‘) angiomyxoma", ### need to recode because ' is " in Adjumed
    "12.1.5. pleomorphic hyalinizing angietctaic tumor",
    "12.1.6. ectropic hamartomatous thymoma",
    "12.2.1. hemosiderotic fibrolipomatous tumor",
    "12.2.2. atypical fibroxanthoma",
    "12.2.3. angiomatoid fibrous histiocytoma",
    "12.2.4. ossifying fibromyxoid tumor",
    "12.2.5. mixed tumor NOS",
    "12.2.6. myoepithelioma",
    "12.2.7. phosphaturic mesenchymal tumor",
    "12.3.1. synovial sarcoma",
    "12.3.2. epithelioid sarcoma",
    "12.3.3. alveolar soft-part sarcoma",
    "12.3.4. clear cell sarcoma of soft tissue",
    "12.3.5. extraskeletal myxoid chondrosarcoma",
    "12.3.6. extraskeletal ewing sarcoma",
    "12.3.7. desmoplastic small round cell tumor",
    "12.3.8. extra-renal rhabdoid tumor",
    "12.3.9. neoplasms with perivascular epithelioid differentiation (PEComa)",
    "12.3.10. intimal sarcoma",
    ### undifferentiated / unclassified sarcoma
    "13.2.1. dermal undifferentiated sarcoma",
    "13.3.1. undifferentiated / unclassified sarcoma",
    ## chondrogenic tumors
    "15.1.1. osteochondroma",
    "15.1.2. chondroma",
    "15.1.3. osteochondromyxoma",
    "15.1.4. subungual exostosis",
    "15.1.5. bizarre parosteal osteochondromatous proliferation",
    "15.1.6. synovial chondromatosis",
    "15.2.1. chondromyxoid fibroma",
    "15.2.2. atypical chondromatous tumors / chondrosarcoma grade I",
    "15.2.3. chondroblastoma",
    "15.3.1. chondrosarcoma grade II, grade III",
    "15.3.2. dedifferentiated chondrosarcoma",
    "15.3.3. mesenchymal chondrosarcoma",
    "15.3.4. clear cell chondrosarcoma",
    ### osteogenic tumors
    "16.1.1. osteoma",
    "16.1.2. osteoid osteoma",
    "16.2.1. osteoblastoma",
    "16.3.1. low-grade central osteosarcoma",
    "16.3.2. conventional osteosarcoma",
    "16.3.3. teleangiectatic osteosarcoma",
    "16.3.4. small cell osteosarcoma",
    "16.3.5. secondary osteosarcoma",
    "16.3.6. parosteal osteosarcoma",
    "16.3.7. periosteal osteosarcoma",
    "16.3.8. high-grade surface osteosarcoma",
    ### fibrogenic tumors
    "17.2.1. desmoplastic fibroma of bone",
    "17.3.1. fibrosarcoma of bone",
    ### fibrohistiocytic tumors
    "18.1.1. benign fibrous histiocytoma",
    "18.1.2. non‐ossifying fibroma",
    ### ewing sarcoma
    "19.3.1. ewing sarcoma",
    ### osteoclastic giant cell rich tumors
    "21.1.1. giant cell lesion of the small bones",
    "21.2.1. giant cell tumor of bone",
    "21.3.1. malignancy in giant cell tumor of bone",
    ### notochordal tumors
    "22.1.1. benign notochordal tumor",
    "22.3.1. chordoma",
    ### vascular tumors
    "23.1.1. hemangioma",
    "23.2.1. epithelioid hemangioma",
    "23.3.1. epithelioid hemangioendothelioma",
    "23.3.2. angiosarcoma",
    ### myogenic, lipogenic & epithelial tumors
    "24.1.1. leiomyoma of bone",
    "24.1.2. lipoma of bone",
    "24.3.1. leiomyosarcoma of bone",
    "24.3.2. liposarcoma of bone",
    "24.3.3. adamantinoma",
    ### tumors of undefined neoplastic nature
    "25.1.1. simple bone cyst",
    "25.1.2. fibrous dysplasia",
    "25.1.3. osteofibrous dysplasia",
    "25.1.4. chondromesenchymal hamartoma",
    "25.1.5. Rosai-Dorfman disease",
    "25.2.1. aneurysmal bone cyst",
    "25.2.2. Langerhans cell histiocytosis",
    "25.2.3. Erdheim-Chester disease",
    ### undifferentiated high-grade pleomorphic sarcoma
    "26.3.1. undifferentiated high grade pleomorphic sarcoma of bone",
    ### tumor syndromes
    "27.0.1. Beckwith-Wiedemann syndrome",
    "27.0.2. cherubism",
    "27.0.3. enchondromatosis: Ollier",
    "27.0.4. enchondromatosis: Maffucci",
    "27.0.5. Li-Fraumeni syndrome",
    "27.0.6. McCune Albright syndrome",
    "27.0.7. multiple osteochondromas",
    "27.0.8. neurofibromatosis type 1",
    "27.0.9. retinoblastoma syndrome",
    "27.0.10. Rothmund-Thomson syndrome",
    "27.0.11. Werner syndrome",
    ### non-neoplastic / tumor simulator
    "0 non-neoplastic / tumor simulator", # please define in next field!!
    ### metastasis
    "M.1. lung",
    "M.2. breast",
    "M.3. prostate",
    "M.4. kidney",
    "M.5. thyroid",
    "M.6. melanoma",
    "M.7. colon / lower GI",
    "M.8. upper GI",
    "M.9. hepato-biliary-pancreas",
    "M.10. cervix / endometrium",
    "M.11. parotis",
    "M.12. CUP",
    "M.13. other metastasis (please specify in next field)", # reocde & please define in next field!!
    ### lymphoma / myeloma / leukemia
    "BL.0 lymphoma",
    "BL.1 myeloma",
    "BL.2 leukemia", # recode to leukemia
    ### St. post implantation of tumor prosthesis
    "recE.1 type 1: mechanical failure - soft tissue failure",
    "recE.2 type 2: mechanical failure - aseptic loosening",
    "recE.3 type 3: mechanical failure - structural failure",
    "recE.4 type 4: non-mechanical failure - infection",
    "recE.5 type 5: non-mechanical failure - tumor",
    "recE.6 type 6: pediatric failures - all types",
    ### other sequelae of treatment
    "recE.7 other sequelae of treatment" # please define in next field!!
  )
)

## Recoding of adipocytic tumors
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "2.1.1. lipoma" ~ "1.1.1. lipoma",
  "2.1.2. lipomatosis" ~ "1.1.2. lipomatosis",
  "2.1.3. lipomatosis of nerve" ~ "1.1.3. lipomatosis of nerve",
  "2.1.4. lipoblastoma / lipoblastomatosis" ~ "1.1.4. lipoblastoma / lipoblastomatosis",
  "2.1.5. angiolipoma" ~ "1.1.5. angiolipoma",
  "2.1.6. myolipoma" ~ "1.1.6. myolipoma of soft tissue",
  "2.1.7. chondroid lipoma" ~ "1.1.7. chondroid lipoma",
  "2.1.8. extra-renal angiomyolipoma" ~ "11.2.2. angiomatoid fibrous histiocytoma (AFH)", # BRUNO???
  "2.1.9. extra‐adrenal myelolipoma" ~ "1.1.1. lipoma", # BRUNO???
  "2.1.10. spindle cell / pleomorphic lipoma" ~ "1.1.8. spindle cell lipoma and pleomorphic lipoma",
  "2.1.11. hibernoma" ~ "1.1.9. hibernoma",
  "2.2.1. atypical lipomatous tumor / well differentiated liposarcoma" ~ "1.2.1. atypical lipomatous tumor / well differentiated liposarcoma (ALT)",
  "2.3.1. dedifferentiated liposarcoma" ~ "1.3.1. dedifferentiated liposarcoma (DDLS)",
  "2.3.2. myxoid liposarcoma" ~ "1.3.2. myxoid liposarcoma (MLS)",
  "2.3.3. pleomorphic liposarcoma" ~ "1.3.3. pleomorphic liposarcoma (PLS)",
  "2.3.4. liposarcoma NOS" ~ "WHO 2013 - 2.3.4. liposarcoma NOS" # BRUNO???
  )

# add_row "1.1.10. atyplical spindle cell / pleomorphic lipomatous tumor (ASPLT)"
# add "1.3.4. myxoid pleomorphic liposarcoma (MPLS)"

##### Recoding of fibroblastic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "3.1.1. nodular fasciitis" ~ "2.1.1. nodular fasciitis",
  "3.1.2. proliferative fasciitis" ~ "2.1.2. proliferative fasciitis",
  "3.1.3. proliferative myositis" ~ "2.1.3. proliferative myositis",
  "3.1.4. myositis ossificans" ~ "2.1.4. myositis ossificans (MO)",
  "3.1.5. fibro‐osseous pseudotumor of digits" ~ "2.1.5. fibro‐osseous pseudotumor of digits",
  "3.1.6. ischemic fasciitis" ~ "2.1.6. ischemic fasciitis",
  "3.1.7. elastofibroma" ~ "2.1.7. elastofibroma",
  "3.1.8. fibrous hamartoma of infancy" ~ "2.1.8. fibrous hamartoma of infancy",
  "3.1.9. fibromatosis colli" ~ "2.1.9. fibromatosis colli",
  "3.1.10. juvenile hyaline fibromatosis" ~ "2.1.10. juvenile hyaline fibromatosis",
  "3.1.11. inclusion body fibromatosis" ~ "2.1.11. inclusion body fibromatosis",
  "3.1.12. fibroma of tendon sheath" ~ "2.1.12. fibroma of tendon sheath",
  "3.1.13. desmoplastic fibroblastoma" ~ "2.1.13. desmoplastic fibroblastoma",
  "3.1.14. mammary-type myofibroblastoma" ~ "2.1.14. myofibroblastoma",
  "3.1.15. calcifying aponeurotic fibroma" ~ "2.1.15. calcifying aponeurotic fibroma",
  "3.1.16. angiomyofibroblastoma" ~ "2.1.17. angiomyofibroblastoma",
  "3.1.17. cellular angiofibroma" ~ "2.1.18. cellular angiofibroma",
  "3.1.18. Nuchal-type fibroma" ~ "2.1.20. nuchal-type fibroma",
  "3.1.19. Gardner fibroma" ~ "2.1.22. Gardner fibroma",
  "3.1.20. calcifying fibrous tumor" ~ "2.1.13. desmoplastic fibroblastoma", # Bruno???
  "3.2.1. palmar/plantar fibromatosis" ~ "2.2.1. palmar/plantar fibromatosis",
  "3.2.2. desmoid‐type fibromatosis" ~ "2.2.2. desmoid fibromatosis",
  "3.2.3. lipofibromatosis" ~ "2.2.3. lipofibromatosis",
  "3.2.4. giant cell fibroblastoma" ~ "2.2.4. giant cell fibroblastoma (GCFB)",
  "3.2.5. dermatofibrosarcoma protuberans" ~ "2.2.5. dermatofibrosarcoma protuberans (DFSP)",
  "3.2.6. fibrosarcomatous dermatofibrosarcoma protuberans" ~ "2.2.5. dermatofibrosarcoma protuberans (DFSP)",
  "3.2.7. pigmented dermatofibrosarcoma protuberans" ~ "2.2.5. dermatofibrosarcoma protuberans (DFSP)",
  "3.2.8. solitary fibrous tumor" ~ "2.2.6. solitary fibrous tumor (SFT)",
  "3.2.9. solitary fibrous tumor, malignant" ~ "2.2.6. solitary fibrous tumor (SFT)", # Bruno???
  "3.2.10. inflammatory myofibroblastic sarcoma" ~ "2.2.7. inflammatory myofibroblastic sarcoma (IMT)",
  "3.2.11. low-grade myofibroblastic sarcoma" ~ "2.2.8. low-grade myofibroblastic sarcoma (LGMFB)",
  "3.2.12. myxoinflammatory fibroblastic sarcoma" ~ "2.2.10. myxoinflammatory fibroblastic sarcoma (MIFB)",
  "3.2.13. infantile fibrosarcoma" ~ "2.2.11. infantile fibrosarcoma (IFS)",
  "3.3.1. adult fibrosarcoma" ~ "2.3.1. adult fibrosarcoma",
  "3.3.2. myxofibrosarcoma" ~ "2.3.2. myxofibrosarcoma (MFS)",
  "3.3.3. low‐grade fibromyxoid sarcoma (Evans tumor)" ~ "2.3.3. low‐grade fibromyxoid sarcoma (LGFMS; Evans)",
  "3.3.4. sclerosing epithelioid fibrosarcoma" ~ "2.3.4. sclerosing epithelioid fibrosarcoma (SEFS)"
  )

# add: "2.1.16. EWSR1-SMAD3-positive fibroblastic tumor"
# add: "2.1.19. angiofibroma of soft-tissue"
# add: "2.1.21. acral fibromyxoma"
# add: "2.2.9. superficial CD34-positive fibroblastic tumor"

##### Recoding of so-called fibrohistiocytic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "4.1.1. deep benign fibrous histiocytoma" ~ "3.1.1. deep fibrous histiocytoma (DFH)",
  "4.2.1. tenosynovial giant cell tumor" ~ "3.2.1. tenosynovial giant cell tumor (PVNS/TGCT)",
  "4.2.2. plexiform fibrohistiocytic tumor" ~ "3.2.2. plexiform fibrohistiocytic tumor",
  "4.2.3. giant cell tumor of soft tissues" ~ "3.2.3. giant cell tumor of soft tissues"
  )

##### Recoding smooth muscle tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "5.1.1. deep leiomyoma" ~ "6.1.1. leiomyoma",
  "5.3.1. leiomyosarcoma (excluding skin)" ~ "6.3.2. leiomyosarcoma (LMS)"
  )
# add: "6.2.1. EBV-associated smooth muscle tumor"
# add: "6.3.1. inflammatory leiomyosarcoma"

##### Recoding pericytic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "6.1.1. angioleiomyoma" ~ "5.1.1. angioleiomyoma",
  "6.2.1. glomus tumor and variants" ~ "5.2.1. glomus tumor",
  "6.2.2. myopericytoma" ~ "5.2.2. myopericytoma, including myofibroma"
  )

##### Recoding skeletal muscle tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "7.3.1. embryonal rhabdomyosarcoma" ~ "7.3.1. embryonal rhabdomyosarcoma (eRMS)",
  "7.3.2. alveolar rhabdomyosarcoma" ~ "7.3.2. alveolar rhabdomyosarcoma (aRMS)",
  "7.3.3. pleomorphic rhabdomyosarcoma" ~ "7.3.3. pleomorphic rhabdomyosarcoma (pRMS)",
  "7.3.4. spindle cell / sclerosing rhabdomyosarcoma" ~ "7.3.4. spindle cell / sclerosing rhabdomyosarcoma (ssRMS)",
  "11.3.5. ectomesenchymoma" ~ "7.3.5. ectomesenchymoma"
  )

##### Recoding vascular tumors of soft-tissue #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "8.1.1. hemangioma" ~ "4.1.1. synovial haemangioma", # Bruno???
  "8.1.2. epithelioid hemangioma" ~ "4.1.6. epithelioid haemangioma",
  "8.1.3. angiomatosis" ~ "4.1.1. synovial haemangioma",
  "8.1.4. lymphangioma" ~ "4.1.7. lymphangioma and lymphangiomatosis",
  "8.2.1. kaposiform hemangioendothelioma" ~ "4.2.1. tufted angioma and kaposiform haemangioendothelioma",
  "8.2.2. retiform hemangioendothelioma" ~ "4.2.2. retiform haemangioendothelioma",
  "8.2.3. papillary intralymphatic angioendothelioma" ~ "4.2.3. papillary intralymphatic angioendothelioma",
  "8.2.4. composite hemangioendothelioma" ~ "4.2.4. composite haemangioendothelioma",
  "8.2.5. pseudomyogenic (epithelioid sarcoma‐like) hemangioendothelioma" ~ "4.2.5. pseudomyogenic haemangioendothelioma (PMHE)",
  "8.2.6. kaposi sarcoma" ~ "4.2.6. kaposi sarcoma",
  "8.3.1. epithelioid hemangioendothelioma" ~ "4.3.1. epithelioid haemangioendothelioma (EHE)",
  "8.3.2. angiosarcoma of soft tissues" ~ "8.3.2. angiosarcoma"
  )

# add: "4.1.2. intramuscular angioma"
# add: "4.1.3. arteriovenous malformation / hemangioma"
# add: "4.1.4. venous hemangioma"
# add: "4.1.5. anastomosing hemangioma"

##### Recoding chondro-osseous tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "9.3.1. extraskeletal mesenchymal chondrosarcoma" ~ "13.3.5. mesenchymal chondrosarcoma (mCHS)",
  "9.3.2. extraskeletal osteosarcoma" ~ "9.3.1. extraskeletal osteosarcoma (eOGS)",
  "10.3.3. gist" ~ "8.3.1. gastrointestinal stromal tumour (GIST)"
  )

##### Recoding nerve sheath tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "11.1.1. schwannoma (including variants)" ~ "10.1.1. schwannoma",
  "11.1.2. melanotic schwannoma" ~ "10.3.2. malignant melanotic nerve sheath tumor",
  "11.1.3. neurofibroma (incl. variants)" ~ "10.1.2. neurofibroma",
  "11.1.4. perineurioma" ~ "10.1.3. perineurioma",
  "11.1.5. granular cell tumor" ~ "10.1.4. granular cell tumor",
  "11.1.6. dermal nerve sheath tumor" ~ "10.1.5. dermal nerve sheath tumor",
  "11.1.7. solitary circumscribed neuroma" ~ "10.1.6. solitary circumscribed neuroma",
  "11.1.8. ectopic meningioma" ~ "10.1.7. ectopic meningioma and meningothelial hamartoma",
  "11.1.9. nasal glial heterotopia" ~ "WHO 2013 - 11.1.9. nasal glial heterotopia",
  "11.1.10. benign triton tumor" ~ "10.1.8. benign triton tumor",
  "11.1.11. hybrid nerve sheath tumors" ~ "10.1.9. hybrid nerve sheath tumors",
  "11.3.1. malignant peripheral nerve sheath tumor" ~ "10.3.1. malignant peripheral nerve sheath tumor (MPNST)",
  "11.3.2. epithelioid malignant peripheral nerve sheath tumor" ~ "10.3.2. malignant melanotic nerve sheath tumor"
  )

##### Recoding tumors of uncertain differentiations #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "12.1.1. acral fibromyxoma" ~ "2.1.21. acral fibromyxoma", # new in fibroblastic tumors!
  "12.1.2. intramuscular myxoma (incl. variants)" ~ "11.1.1. intramuscular myxoma",
  "12.1.3. juxtra-articular myxoma" ~ "11.1.2. juxtra-articular myxoma",
  "12.1.4. deep (‘aggressive‘) angiomyxoma" ~ "11.1.3. deep (‘aggressive‘) angiomyxoma",
  "12.1.5. pleomorphic hyalinizing angietctaic tumor" ~ "11.2.5. pleomorphic hyalinizing angietctatic tumour of soft parts (PHAT)",
  "12.1.6. ectropic hamartomatous thymoma" ~ "", # ???
  "12.2.1. hemosiderotic fibrolipomatous tumor" ~ "11.2.6. hemosiderotic fibrolipomatous tumour (HSFLT)",
  "12.2.2. atypical fibroxanthoma" ~ "11.2.1. atypical fibroxanthoma",
  "12.2.3. angiomatoid fibrous histiocytoma" ~ "11.2.2. angiomatoid fibrous histiocytoma (AFH)",
  "12.2.4. ossifying fibromyxoid tumor" ~ "11.2.3. ossifying fibromyxoid tumor",
  "12.2.5. mixed tumor NOS" ~ "11.2.4. myoepithelioma, myoepithelial carcinoma, and mixed tumor",
  "12.2.6. myoepithelioma" ~ "11.2.4. myoepithelioma, myoepithelial carcinoma, and mixed tumor",
  "12.2.7. phosphaturic mesenchymal tumor" ~ "11.2.7. phosphaturic mesenchymal tumor (PMT)",
  "12.3.1. synovial sarcoma" ~ "11.3.2. synovial sarcoma (SS)",
  "12.3.2. epithelioid sarcoma" ~ "11.3.3. epithelioid sarcoma (ES)",
  "12.3.3. alveolar soft-part sarcoma" ~ "11.3.4. alveolar soft-part sarcoma (ASPS)",
  "12.3.4. clear cell sarcoma of soft tissue" ~ "11.3.5. clear cell sarcoma of soft tissue (CSS)",
  "12.3.5. extraskeletal myxoid chondrosarcoma" ~ "11.3.6. extraskeletal myxoid chondrosarcoma",
  "12.3.6. extraskeletal ewing sarcoma" ~ "12.3.1. ewing sarcoma (EWS)",
  "12.3.7. desmoplastic small round cell tumor" ~ "11.3.7. desmoplastic small round cell tumor (DSRCT)",
  "12.3.8. extra-renal rhabdoid tumor" ~ "11.3.8. extra-renal rhabdoid tumor",
  "12.3.9. neoplasms with perivascular epithelioid differentiation (PEComa)" ~ "11.3.9. PEComa",
  "12.3.10. intimal sarcoma" ~ "11.3.10. intimal sarcoma (IS)"
  )

  # add "11.3.1. NTRK-rearranged spindle cell neoplasm"

##### Recoding undifferentiated / unclassified sarcoma #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "13.2.1. dermal undifferentiated sarcoma" ~ "",
  "13.3.1. undifferentiated / unclassified sarcoma" ~ "11.3.11. undifferentiated sarcoma (UPS)"
  )

##### Recoding chondrogenic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "15.1.1. osteochondroma" ~ "13.1.5. osteochondroma",
  "15.1.2. chondroma" ~ "13.1.4. enchondroma",
  "15.1.3. osteochondromyxoma" ~ "13.1.8. osteochondromyxoma",
  "15.1.4. subungual exostosis" ~ "13.1.1. subungual exostosis",
  "15.1.5. bizarre parosteal osteochondromatous proliferation" ~ "13.1.2. bizarre parosteal osteochondromatous proliferation (BPOP)",
  "15.1.6. synovial chondromatosis" ~ "13.2.1. synovial chondromatosis",
  "15.2.1. chondromyxoid fibroma" ~ "13.1.7. chondromyxoid fibroma",
  "15.2.2. atypical chondromatous tumors / chondrosarcoma grade I" ~ "13.2.2. central atypical cartilaginous tumour / chondrosarcoma, grade I (sACT)",
  "15.2.3. chondroblastoma" ~ "13.1.6. chondroblastoma",
  "15.3.1. chondrosarcoma grade II, grade III" ~ "15.3.1. central chondrosarcoma, grades II and III",
  "15.3.2. dedifferentiated chondrosarcoma" ~ "13.3.6. dedifferentiated chondrosarcoma (dCHS)",
  "15.3.3. mesenchymal chondrosarcoma" ~ "13.3.5. mesenchymal chondrosarcoma (mCHS)",
  "15.3.4. clear cell chondrosarcoma" ~ "13.3.4. clear cell chondrosarcoma (ccCHS)"
  )

##### Recoding osteogenic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "16.1.1. osteoma" ~ "14.1.1. osteoma",
  "16.1.2. osteoid osteoma" ~ "14.1.2. osteoid osteoma (OO)",
  "16.2.1. osteoblastoma" ~ "14.2.1. osteoblastoma",
  "16.3.1. low-grade central osteosarcoma" ~ "14.3.1. low-grade central osteosarcoma (LOGS)",
  "16.3.2. conventional osteosarcoma" ~ "14.3.2. osteosarcoma (OGS)",
  "16.3.3. teleangiectatic osteosarcoma" ~ "14.3.2. osteosarcoma (OGS)",
  "16.3.4. small cell osteosarcoma" ~ "14.3.2. osteosarcoma (OGS)",
  "16.3.5. secondary osteosarcoma" ~ "14.3.6. secondary osteosarcoma (sOGS)",
  "16.3.6. parosteal osteosarcoma" ~ "14.3.3. parosteal osteosarcoma (parOGS)",
  "16.3.7. periosteal osteosarcoma" ~ "14.3.4. periosteal osteosarcoma (perOGS)",
  "16.3.8. high-grade surface osteosarcoma" ~ "14.3.5. high-grade surface osteosarcoma (hgsOGS)"
  )

##### Recoding fibrogenic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "17.2.1. desmoplastic fibroma of bone" ~ "15.2.1. desmoplastic fibroma of bone (DFB)",
  "17.3.1. fibrosarcoma of bone" ~ "15.3.1. fibrosarcoma of bone"
  )

##### Recoding fibrohistiocytic tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "18.1.1. benign fibrous histiocytoma" ~ "17.2.1. giant cell tumor of bone",
  "18.1.2. non‐ossifying fibroma" ~ "17.1.2. non‐ossifying fibroma (NOF)"
  )

##### Recoding ewing sarcoma #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "19.3.1. ewing sarcoma" ~ "12.3.1. ewing sarcoma (EWS)"
  )

##### Recoding vascular tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "23.1.1. hemangioma" ~ "16.1.1. haemangioma of bone",
  "23.2.1. epithelioid hemangioma" ~ "16.2.1. epithelioid haemangioma of bone",
  "23.3.1. epithelioid hemangioendothelioma" ~ "16.3.1. epithelioid haemangioendothelioma of bone",
  "23.3.2. angiosarcoma" ~ "16.3.2. angiosarcoma of bone"
  )

##### Recoding osteoclastic giant cell rich tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "21.1.1. giant cell lesion of the small bones" ~ "17.1.1. aneurysmal bone cyst (ABC)",
  "21.2.1. giant cell tumor of bone" ~ "17.2.1. giant cell tumor of bone (GCT)",
  "21.3.1. malignancy in giant cell tumor of bone" ~ "17.2.1. giant cell tumor of bone (GCT)"
    )

##### Recoding notochordal tumors #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "22.1.1. benign notochordal tumor" ~ "18.1.1. benign notochordal tumor",
  "22.3.1. chordoma" ~ "18.3.1. conventional chordoma"
)

##### Recoding myogenic, lipogenic & epithelial tumor #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "24.1.1. leiomyoma of bone" ~ "WHO 2013 - 24.1.1. leiomyoma of bone", # Bruno???
  "24.1.2. lipoma of bone" ~ "19.1.4. lipoma and hibernoma of bone",
  "24.3.1. leiomyosarcoma of bone" ~ "19.3.4. leiomyosarcoma of bone",
  "24.3.2. liposarcoma of bone" ~ "WHO 2013 - 24.3.2. liposarcoma of bone", # Bruno???
  "24.3.3. adamantinoma" ~ "19.3.1. adamantinoma of long bones"
  )

##### Recoding tumors of undefined neoplastic nature #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "25.1.1. simple bone cyst" ~ "19.3.3. simple bone cyst (UBC)",
  "25.1.2. fibrous dysplasia" ~ "19.1.3. fibrous dysplasia (FD)",
  "25.1.3. osteofibrous dysplasia" ~ "19.1.2. osteofibrous dysplasia (OD)",
  "25.1.4. chondromesenchymal hamartoma" ~ "19.1.1. chondromesenchymal hamartoma of chest wall",
  "25.1.5. Rosai-Dorfman disease" ~ "B.7. Rosai-Dorfman disease",
  "25.2.1. aneurysmal bone cyst" ~ "17.1.1. aneurysmal bone cyst (ABC)",
  "25.2.2. Langerhans cell histiocytosis" ~ "B.5. Langerhans cell histiocytosis",
  "25.2.3. Erdheim-Chester disease" ~ "B.6. Erdheim-Chester disease"
  )

##### Recoding undifferentiated high-grade pleomorphic sarcoma #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "26.3.1. undifferentiated high grade pleomorphic sarcoma of bone" ~ "19.3.5. undifferentiated pleomorphic sarcoma (bUPS)"
  )

##### Recoding tumor syndromes #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "27.0.1. Beckwith-Wiedemann syndrome" ~ "WHO 2013 - 27.0.1. Beckwith-Wiedemann syndrome",
  "27.0.2. cherubism" ~ "WHO 2013 - 27.0.2. cherubism",
  "27.0.3. enchondromatosis: Ollier" ~ "GS.1. enchondromatosis: Ollier",
  "27.0.4. enchondromatosis: Maffucci" ~ "GS.2. enchondromatosis: Maffucci",
  "27.0.5. Li-Fraumeni syndrome" ~ "GS.3. Li-Fraumeni syndrome",
  "27.0.6. McCune Albright syndrome" ~ "GS.4. McCune Albright syndrome",
  "27.0.7. multiple osteochondromas" ~ "GS.5. multiple osteochondromas",
  "27.0.8. neurofibromatosis type 1" ~ "GS.6. neurofibromatosis type 1",
  "27.0.9. retinoblastoma syndrome" - "WHO 2013 - 27.0.9. retinoblastoma syndrome",
  "27.0.10. Rothmund-Thomson syndrome" ~ "GS.7. Rothmund-Thomson syndrome",
  "27.0.11. Werner syndrome" ~ "GS.8. Werner syndrome"
  )

##### Recoding metastasis #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "M.1. lung" ~ "M.1. bone metastases: lung (adenocarcinoma)",
  "M.2. breast" ~ "M.2. bone metastases: breast",
  "M.3. prostate" ~ "M.3. bone metastases: prostate",
  "M.4. kidney" ~ "M.4. bone metastases: kidney (renal cell carcinoma)",
  "M.5. thyroid" ~ "M.5. bone metastases: thyroid",
  "M.6. melanoma" ~ "M.8. bone metastases: melanoma",
  "M.7. colon / lower GI" ~ "M.9. bone metastases: colon / lower GI",
  "M.8. upper GI" ~ "M.10. bone metastases: upper GI",
  "M.9. hepato-biliary-pancreas" ~ "M.11. bone metastases: hepato-biliary-pancreas",
  "M.10. cervix / endometrium" ~ "M.12. bone metastases: cervix / endometrium",
  "M.11. parotis" ~ "M.13. bone metastases: parotis",
  "M.12. CUP" ~ "M.14. bone metastases: CUP",
  "M.13. other metastasis (please specify in next field)" ~ "M.13. bone metastases: other metastasis (please specify in next field)"
  )

##### Recoding lymphoma / myeloma / leukemia #####
dplyr::case_match(
  diagnosis_who$diagnosis_name,
  .default = diagnosis_who$diagnosis_name,
  "BL.0 lymphoma" ~ "B.3. primary non-/hodgkin lymphoma of bone",
  "BL.1 myeloma" ~ "B.2. multiple myeloma",
  "BL.2 leukemia" ~ "B.4. leukemia"
  )

