anatomic_region <- data.frame(
  group = c(
    "Not (yet) determined",
    rep("bone", 88),
    rep("superficial soft-tissue", 55),
    rep("deep soft-tissue", 119)
  ),
  region = c(NA,
             ### Bone
              rep("face/head/neck", 4),
              rep("upper extremity", 39),
              rep("torso (incl. chest, excl. sacrum)", 6),
              rep("pelvis (incl. sacrum)", 7),
              rep("lower extremity", 32),
             ### Superficial soft-tissue
              rep("face/head/neck", 5),
              rep("upper extremity", 19),
              rep("torso (incl. chest, excl. sacrum)", 4),
              rep("pelvis (incl. sacrum)", 4),
              rep("lower extremity", 18),
              rep("abdomen", 3),
              rep("chest (incl. mamma)", 2),
             ### Deep soft-tissue
              rep("face/head/neck", 4),
              rep("upper extremity", 42),
              rep("torso, paravertebral (incl. spine)", 5),
              rep("pelvis", 11),
              rep("lower extremity", 44),
              rep("abdomen", 4),
              rep("chest (subfascial masses, excl. mamma", 9)
  ),
  sub = c(NA,
          "B1 face, head, neck",
          "B1.1 face",
          "B1.2 head",
          "B1.3 neck",
          rep("clavicle", 3),
          rep("scapula", 5),
          rep("humerus", 7),
          rep("elbow joint", 2),
          rep("radius", 7),
          rep("ulna", 7),
          rep("radius & ulna", 2),
          rep("wrist joint", 2),
          rep("hand", 4),
          "B9.1. cervical spine",
          "B.9.2. thoracic spine",
          "B.9.3. lumbar spine",
          "B.9.5. ribs",
          "B.9.6. torso combinations",
          "B.9.7. sternum",
          "B10.1. ilium",
          "B10.2. ischium",
          "B10.3. pubis",
          "B10.4. pelvis combinations",
          "B10.5. acetabulum / hip joint: intraarticular",
          "B10.6. acetabulum / hip joint: extraatricular",
          "B10.7. sarcum",
          rep("femur", 7),
          rep("knee joint", 3),
          rep("tibia", 6),
          rep("fibula", 7),
          rep("tibia & fibula combinations", 2),
          rep("ankle joint", 3),
          rep("foot", 4),
          ### Superficial soft-tissue
          "S1 face",
          "S2 head",
          "S3 anterior neck",
          "S4 posterior neck",
          "S4.4 combinations of face, head, neck",
          rep("clavicle", 3),
          rep("scapula", 5),
          rep("upper arm / humerus", 3),
          rep("elbow joint", 2),
          rep("forearm", 3),
          rep("hand / wrist", 3),
          "S9.1. regio thoracalis",
          "S9.2. regio lumbalis",
          "S9.3. regio sacralis",
          "S9.4. regio analis",
          "S10.1. regio glutealis",
          "S10.2. regio pubica",
          "S10.3. regio urogenitalis / perinealis / analis",
          "S11.1. regio inguinalis",
          rep("thigh / femur", 9),
          rep("knee joint", 2),
          rep("lower leg", 2),
          rep("foot", 5),
          "S17.1. regio hypochondrica",
          "S17.2. regio umbilicalis",
          "S17.3. regio abdominalis lateralis",
          "S18.1. regio presternalis",
          "S18.2. regio pectoralis / mamma",
          ### Deep soft-tissue:
          "D1 face",
          "D2 head",
          "D3 anterior neck",
          "D4 posterior neck",
          rep("clavicle / brachial plexus", 2),
          rep("scapula / axilla / shoulder", 6),
          rep("shoulder joint", 2),
          rep("upper arm / humerus", 12),
          rep("elbow joint", 2),
          rep("forearm", 12),
          rep("wrist joint", 2),
          rep("hand", 4),
          "D9.1. cervical spine",
          "D9.2. thoracic spine / para-scapular region",
          "D9.3. lumbar spune / lumbar region",
          "D9.4. sacrum",
          "D9.5. combinations (incl. ilium)",
          rep("extrapelvic", 3),
          rep("intrapelvic (retroperitoneal)", 4),
          rep("both intra- and extrapelvic", 4),
          rep("hip joint", 2),
          rep("thigh / femur", 16),
          rep("knee joint", 4),
          rep("lower leg", 16),
          rep("ankle joint", 2),
          rep("foot", 4),
          rep("abdominal wall", 2),
          rep("intraabdominal", 2),
          rep("chest wall", 4),
          rep("intrathoracic", 5)
  ),
  anatomic_region_name = c(
    rep(NA, 1),
    rep(NA, 4),
    "B2 clavicle",
    "B2.1 medial clavicle",
    "B2.2 lateral clavicle",
    "B3.1.A partial intraarticular scapula",
    "B3.1.B partial extraarticular scapula",
    "B3.2.A complete intraarticular scapula",
    "B3.2.B complete extraarticular scapula",
    "B3.3 acromion (from base of scapular spine to AC-joint)",
    "B4.1. intraarticular proximal humerus",
    "B4.2. extraarticular proximal humerus",
    "B4.3. diaphyeal humerus",
    "B4.4. intraarticular distal humerus",
    "B4.5. extraarticular distal humerus",
    "B4.6. intraarticular humerus combinations",
    "B4.7. extraarticular humerus combinations",
    "B5.1. intraarticular elbow joint",
    "B5.2. extraarticular elbow joint",
    "B6.1. intraarticular radius proximal",
    "B6.2. extraarticular radius proximal",
    "B6.3. radius diaphyseal",
    "B6.4. intraarticular radius distal",
    "B6.5. extraarticular radius distal",
    "B6.6. intraarticular radius combinations",
    "B6.7. extraarticular radius combinations",
    "B6.8. intraarticular ulna proximal",
    "B6.9. extraarticular ulna proximal",
    "B6.10. ulna diaphyseal",
    "B6.11. intraarticular ulna distal",
    "B6.12. extraarticular ulna distal",
    "B6.13. intraarticular ulna combinations",
    "B6.14. extraarticular ulna combinations",
    "B6.15. intraarticular radius and ulna combinations",
    "B6.16. extraarticular radius and ulna combinations",
    "B7.1. intraarticular wrist joint",
    "B7.2. extraatricular wrist joint",
    "B8.1. carpal",
    "B8.2. matecarpal",
    "B8.3. digits",
    "B8.4. hand combinations",
    rep(NA, 6),
    rep(NA, 7),
    "B12.1. intraarticular proximal femur",
    "B12.2. extraarticular proximal femur",
    "B12.3. diaphyseal femur",
    "B12.4. intraarticular distal femur",
    "B12.5. extraatricular distal femur",
    "B12.6. intraarticular femur combinations",
    "B12.7. extraarticular femur combinations",
    "B13.1. patella intraarticular",
    "B13.2. patella extraatricular",
    "B13.3. combinations of patella intraartiuclar and patella extraatricular",
    "B14.1. intraarticular tibia proximal",
    "B14.2. extraatricular tibia proximal",
    "B14.3. tibia diaphyeal",
    "B14.4. intraarticular tibia distal",
    "B14.5. extraatricular tibia distal",
    "B14.6. tibia combinations",
    "B14.7. intraarticular fibula proximal",
    "B14.8. extraarticular fibula proximal",
    "B14.9. fibula diaphyseal",
    "B14.10. intraarticular fibula distal",
    "B14.11. extraatricular fibula distal",
    "B14.12. intraarticular fibula combinations",
    "B14.13. extraatricular fibula combinations",
    "B14.14. intraarticular tibia and fibula combinations",
    "B14.15. extraatricular tibia and fibula combinations",
    "B15.1. intraarticular ankle joint",
    "B15.2. extraarticular ankle joint",
    "B15.2.1. combinations of intraarticular ankle joint and extraarticular ankle joint",
    "B16.1. hindfoot",
    "B16.2. forefoot",
    "B16.3. digits",
    "B16.4. foot combinations",
    rep(NA, 5),
    "S7 clavicle region",
    "S7.1. medial clavicle",
    "S7.2. lateral clavicle",
    "S3.1. regio subscapularis",
    "S3.2. regio scapularis",
    "S3.3. regio infrascapularis",
    "S3.4. regio deltoidea",
    "S3.5. regio axillaris",
    "S4.1. regio brachialis anterior",
    "S4.2. regio brachialis posterior",
    "S4.3. combinations of regio brachialis anterior and regio brachialis posterior",
    "S5.1. regio cubitalis anterior",
    "S5.2. regio cubitalis posterior",
    "S6.1. regio antebrachii anterior",
    "S6.2. regio antebrachii posterior",
    "S6.3. combinations of regio antebrachii anterior and regio antebrachii posterior",
    "S8.1. dorsum manus",
    "S8.2. palma manus",
    "S8.3. digits",
    rep(NA, 4),
    rep(NA, 4),
    "S12.1. regio femoris anterior proximal",
    "S12.3. regio femoris anterior diaphyseal",
    "S12.5. regio femoris anterior distal",
    "S12.2. regio femoris posterior proximal",
    "S12.4. regio femoris posterior diaphyseal",
    "S12.6. regio femoris posterior distal",
    "S12.2.1. combinations of regio femoris anterior proximal and regio femoris posterior proximal",
    "S12.4.1. combinations of regio femoris anterior diaphyseal and regio femoris posterior diaphyseal",
    "S12.7. distal femur combinations",
    "S13.1. regio genus anterior",
    "S13.2. regio genus posterior",
    "S14.1. regio cruralis anterior",
    "S14.2. regio cruralis posterior",
    "S15.1. regio calcanea",
    "S16.1. dorsum pedis",
    "S16.2. planta pedis",
    "S16.3. digits",
    "S16.4. foot combinations",
    rep(NA, 3),
    rep(NA, 2),
    rep(NA, 4),
    "D2.1. clavicle",
    "D2.2. brachial plexus",
    "D3.1. deltoid region",
    "D3.2. superior shoulder",
    "D3.3. dorsal to scapula",
    "D3.4. inferior to scapula",
    "D3.5. axilla (base / lateral)",
    "D3.6. axilla-scapulo-thoracic-chest-wall (medial / deep)",
    "D17.1. intraarticular shoulder joint",
    "D17.2. extraarticular shoulder joint",
    "D4.1.1 anterior / flexor compartment: proximal",
    "D4.1.2 anterior / flexor compartment: diaphyseal",
    "D4.1.3 anterior / flexor compartment: distal",
    "D4.1.4 anterior / flexor compartment: combinations",
    "D4.2.1 posterior / extensor compartment: proximal",
    "D4.2.2 posterior / extensor compartment: diaphyseal",
    "D4.2.3 posterior / extensor compartment: distal",
    "D4.2.4 posterior / extensor compartment: combinations",
    "D4.3.1 compartment combinations: proximal",
    "D4.3.2 compartment combinations: diaphyseal",
    "D4.3.3 compartment combinations: distal",
    "D4.3.4 compartment combinations: combinations",
    "D5.1. intraarticular elbow joint",
    "D5.2. extraarticular elbow joint",
    "D6.1.1 anterior / flexor compartment: proximal",
    "D6.1.2 anterior / flexor compartment: diaphyseal",
    "D6.1.3 anterior / flexor compartment: distal",
    "D6.1.4 anterior / flexor compartment: combinations",
    "D6.2.1 posterior / extensor compartment: proximal",
    "D6.2.2 posterior / extensor compartment: diaphyseal",
    "D6.2.3 posterior / extensor compartment: distal",
    "D6.2.4 posterior / extensor compartment: combinations",
    "D6.3.1 compartment combinations: proximal",
    "D6.3.2 compartment combinations: diaphyseal",
    "D6.3.3 compartment combinations: distal",
    "D6.3.4 compartment combinations: combinations",
    "D7.1. intraarticular wrist joint",
    "D7.2. extraarticular wrist joint",
    "D8.1. dorsum manus",
    "D8.2. palma manus",
    "D8.3. hand combinations",
    "D8.4. fingers",
    rep(NA, 5),
    "D10.3. abductors / gluteal muscles",
    "D11.1. inguina soft tissues (incl. funiculus spermaticus & scrotum)",
    "D10.4. extrapelvic, other (please specify in next field)",
    "D10.1. iliacus - psoas",
    "D10.1.1. uterus",
    "D10.2. intrapelvic, other (please specify in next field)",
    "D10.2.2. pararectal",
    "D10.6.1. anterior through inguina",
    "D10.6.4. anterior through foramen obturatum",
    "D10.6.2. lateral through sciatic notch",
    "D10.6.3. both intra- and extrapelvic, other (please specify in next field)",
    "D10.1. intraarticular hip joint",
    "D10.2. extraarticular hip joint",
    "D12.6.1 anterior / extensor compartment: proximal",
    "D12.6.2 anterior / extensor compartment: diaphyseal",
    "D12.6.3 anterior / extensor compartment: distal",
    "D12.6.4 anterior / extensor compartment: combinations",
    "D12.7.1 posterior / flexor compartment: proximal",
    "D12.7.2 posterior / flexor compartment: diaphyseal",
    "D12.7.3 posterior / flexor compartment: distal",
    "D12.7.4 posterior / flexor compartment: combinations",
    "D12.5.1 medial / adductor compartment: proximal",
    "D12.5.2 medial / adductor compartment: diaphyseal",
    "D12.5.3 medial / adductor compartment: distal",
    "D12.5.4 medial / adductor compartment: combinations",
    "D12.8.1 compartment combinations: anterior - posterior",
    "D12.8.2 compartment combinations: anterior - medial",
    "D12.8.3 compartment combinations: medial - posterior",
    "D12.8.4 compartment combinations: anterior - medial - posterior",
    "D13.1. periarticular, intraarticular knee joint",
    "D13.2. periarticular, extraarticular knee joint",
    "D13.3. popliteal, intraarticular knee joint",
    "D13.4. popliteal, extraarticular knee joint",
    "D14.2.1 anterior / extensor compartment: proximal",
    "D14.2.2 anterior / extensor compartment: diaphyseal",
    "D14.2.3 anterior / extensor compartment: distal",
    "D14.2.4 anterior / extensor compartment: combinations",
    "D14.3.1 posterior / flexor compartment: proximal",
    "D14.3.2 posterior / flexor compartment: diaphyseal",
    "D14.3.3 posterior / flexor compartment: distal",
    "D14.3.4 posterior / flexor compartment: combinations",
    "D14.1.1 lateral / fibular compartment: proximal",
    "D14.1.2 lateral / fibular compartment: diaphyseal",
    "D14.1.3 lateral / fibular compartment: distal",
    "D14.1.4 lateral / fibular compartment: combinations",
    "D14.4.1 compartment combinations: anterior - posterior",
    "D14.4.2 compartment combinations: anterior - fibular",
    "D14.4.3 compartment combinations: fibular - posterior",
    "D14.4.4 compartment combinations: anterior - fibular - posterior",
    "D15.1. intraarticular ankle joint",
    "D15.2. extraarticular ankle joint",
    "D16.1. dorsum pedis",
    "D16.2. planta pedis",
    "D16.4. digits",
    "D16.3. foot combinations",
    "D18.1. abdominal wall: anterior",
    "D18.2. abdominal wall: lateral",
    "D18.3. intraperitoneal",
    "D18.4. retro- / extraperitoneal",
    "D19.1. chest: sternal sternal",
    "D19.2. chest: pectoral pectoral",
    "D19.3. chest: lateral",
    "D19.3.1. chest: posterior",
    "D19.4.1. lung",
    "D19.4.2. pleura",
    "D19.4.3. mediastinum",
    "D19.4.4. heart",
    "D19.4.5. intrathoracic, other (please specify in next field)"
  )
)

###
library(shinytreeview)
args <- list(
  data = anatomic_region,
  levels = names(anatomic_region)
)
#args$data <- args$data[1:5,]
args[names(anatomic_region)[1:3]] <- list(list(selectable = FALSE))
tree <- do.call(make_tree, args)

# Setting node to NULL, makes the node selectable again
### Not (yet) determined
tree[[1]]$selectable <- NULL
### Bone: Face
tree[[2]]$nodes[[1]]$nodes[[1]]$selectable <- NULL
tree[[2]]$nodes[[1]]$nodes[[2]]$selectable <- NULL
tree[[2]]$nodes[[1]]$nodes[[3]]$selectable <- NULL
tree[[2]]$nodes[[1]]$nodes[[4]]$selectable <- NULL

### Bone: Torso
tree[[2]]$nodes[[3]]$nodes[[1]]$selectable <- NULL
tree[[2]]$nodes[[3]]$nodes[[2]]$selectable <- NULL
tree[[2]]$nodes[[3]]$nodes[[3]]$selectable <- NULL
tree[[2]]$nodes[[3]]$nodes[[4]]$selectable <- NULL
tree[[2]]$nodes[[3]]$nodes[[5]]$selectable <- NULL
tree[[2]]$nodes[[3]]$nodes[[6]]$selectable <- NULL

### Bone: Pelvis
tree[[2]]$nodes[[4]]$nodes[[1]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[2]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[3]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[4]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[5]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[6]]$selectable <- NULL
tree[[2]]$nodes[[4]]$nodes[[7]]$selectable <- NULL

### Superficial soft tissue: Face
tree[[3]]$nodes[[1]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[1]]$nodes[[2]]$selectable <- NULL
tree[[3]]$nodes[[1]]$nodes[[3]]$selectable <- NULL
tree[[3]]$nodes[[1]]$nodes[[4]]$selectable <- NULL
tree[[3]]$nodes[[1]]$nodes[[5]]$selectable <- NULL

### Superficial soft tissue: Torso
tree[[3]]$nodes[[3]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[3]]$nodes[[2]]$selectable <- NULL
tree[[3]]$nodes[[3]]$nodes[[3]]$selectable <- NULL
tree[[3]]$nodes[[3]]$nodes[[4]]$selectable <- NULL

### Superficial soft tissue: Pelvis
tree[[3]]$nodes[[4]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[4]]$nodes[[2]]$selectable <- NULL
tree[[3]]$nodes[[4]]$nodes[[3]]$selectable <- NULL
tree[[3]]$nodes[[4]]$nodes[[4]]$selectable <- NULL

### Superficial soft tissue: Abdomen
tree[[3]]$nodes[[6]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[6]]$nodes[[2]]$selectable <- NULL
tree[[3]]$nodes[[6]]$nodes[[3]]$selectable <- NULL

### Superficial soft tissue: Chest
tree[[3]]$nodes[[7]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[7]]$nodes[[2]]$selectable <- NULL

### Deep soft tissue: Face
tree[[4]]$nodes[[1]]$nodes[[1]]$selectable <- NULL
tree[[4]]$nodes[[1]]$nodes[[2]]$selectable <- NULL
tree[[4]]$nodes[[1]]$nodes[[3]]$selectable <- NULL
tree[[4]]$nodes[[1]]$nodes[[4]]$selectable <- NULL

### Deep soft tissue: Torso
tree[[4]]$nodes[[3]]$nodes[[1]]$selectable <- NULL
tree[[4]]$nodes[[3]]$nodes[[2]]$selectable <- NULL
tree[[4]]$nodes[[3]]$nodes[[3]]$selectable <- NULL
tree[[4]]$nodes[[3]]$nodes[[4]]$selectable <- NULL
tree[[4]]$nodes[[3]]$nodes[[5]]$selectable <- NULL

save(tree, file = here::here("inst/extdata/tree_anatomic_region_name.RData"))

######

ui <- fluidPage(
  treeviewInput(inputId = "tree", label = "Tree",
                choices = tree, selected = NULL,
                multiple = T),
  verbatimTextOutput("tree_output")
)

server <- function(input, output, session) {

  # Message tree input
  observe({
    if(is.null(input$tree)) {
      message("tree input = NULL")
    } else {
      message("tree input = ", input$tree)
    }

    output$tree_output <- renderText({
      input$tree
    })

  })
}

shinyApp(ui, server)

