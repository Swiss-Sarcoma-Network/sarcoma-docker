##### Resection #####
resection <- data.frame(
  group = c(
    "Not applicable",
    rep("soft tissues", 13),
    rep("bone", 17),
    rep("chest / thorax", 10),
    rep("abdomen", 15),
    rep("sequelae of primary treatment", 11)
  ),
  sub = c(NA,
          "resA.1 simple",
          "resA.2 muscle resection",
          "resA.3 vessel dissection",
          "resA.4 nerve dissection",
          "resA.5 periost resection",
          "resA.6 bone resection",
          "resA.7 vessel resection",
          "resA.8 nerve resection",
          "resA.9 MR-HIFU",
          "resA.10 tendon resection",
          "resA.11 ligament resection",
          "resA.12 resection of funiculus; scrotum; genitals",
          "resA.13 other STS resection (please specify in next field)", ##
            ####
          "resB.1 simple curettage",
          "resB.2 hemi-cortex resection",
          "resB.3 complete / whole bone res. (incl. adj. soft tiss.): joint sparing (outside / preservation of joint)",
          "resB.4 complete / whole bone res. (incl. adj. soft tiss.): transarticular resection (through the joint)",
          "resB.5 complete / whole bone res. (incl. adj. soft tiss.): extraarticular joint resection",
          "resB.6 with 3D patient specific cutting guides",
          "resB.6.1 3D planning",
          "resB.8 radiofrequency ablation (RFA); cryotherapy; MR-HIFU",
          "resB.9 resection-replantation (upper extremity)",
          "resB.10 rotationplasty (lower extremity)",
          "resB.80 tendon resection",
          "resB.81 ligament resection",
          "resB.82 forced epiphyseolysis OT (Canadell technique)",
          "resB.83 extra-articular scapulo-humeral resection (Tikhoff-Linberg)",
          "resB.84 biopsy / gain of diagnostic tissue",
          "resB.85 removal of cement",
          "resB.86 other bone resection (please specify in next field)", ##
            ####
            rep("chest wall resection", 1),
            rep("open thoracotomy", 7),
            rep("thoraco-endoscopic resection (VATS)", 2),
            ####
            rep("abdominal wall resection", 1),
            rep("abdominal resection", 14),
            ####
            rep("soft tissue revision", 2),
            rep("bone revision", 4),
            rep("St. post tumor prosthesis implantation", 5)

  ),
  resection_name = c(NA,
                     rep(NA, 13),
                     ####
                     rep(NA, 17),
                     ####
                     ####
                     "resC.1 chest wall resection",
                     "resC.2 wedge resection",
                     "resC.3 segmental resection",
                     "resC.4 lobectomy",
                     "resC.5 bilobectomy / pneumonectomy",
                     "resC.6 pleuropneumonectomy",
                     "resC.7 thoracic wall resection / ribs",
                     "resC.10 other chest / lung resection (please specify in next field)", ###
                     "resC.8 wedge resection",
                     "resC.9 lobectomy",
                     ####
                     "resD.1 abdominal wall resection",
                     "resD.2 none", ### ????
                     "resD.3 kidney",
                     "resD.4 suprarenal glands",
                     "resD.5 ureter",
                     "resD.6 bladder",
                     "resD.7 colon / rectum",
                     "resD.8 bowel",
                     "resD.9 uterus / ovaries",
                     "resD.10 spleen",
                     "resD.11 liver",
                     "resD.12 pancreas",
                     "resD.13 gall bladder",
                     "resD.14 aorta / cava",
                     "resD.15 other abdominal resection (please specify in next field)",
                     ####
                     "resE.5 infection",
                     "resE.7 wound healing failure (incl. hematoma)",
                     "resE.8 infection",
                     "resE.9 osteosynthesis failure",
                     "resE.10 fracture",
                     "resE.12 pseudoarthrosis",
                     "resE.1 debridement",
                     "resE.2 inlay change",
                     "resE.3 partial removal of prosthesis",
                     "resE.4 complete removal of prosthesis",
                     "resE.11 other (please specify in next field)"
  )
)


args <- list(
  data = resection,
  levels = names(resection)
)
#args$data <- args$data[1:5,]
args[names(resection)[1:2]] <- list(list(selectable = FALSE))
tree <- do.call(make_tree, args)

# Setting node to NULL, makes the node selectable again
### Not (yet) determined
tree[[1]]$selectable <- NULL

### soft tissues
tree[[2]]$nodes[[1]]$selectable <- NULL
tree[[2]]$nodes[[2]]$selectable <- NULL
tree[[2]]$nodes[[3]]$selectable <- NULL
tree[[2]]$nodes[[4]]$selectable <- NULL
tree[[2]]$nodes[[5]]$selectable <- NULL
tree[[2]]$nodes[[6]]$selectable <- NULL
tree[[2]]$nodes[[7]]$selectable <- NULL
tree[[2]]$nodes[[8]]$selectable <- NULL
tree[[2]]$nodes[[9]]$selectable <- NULL
tree[[2]]$nodes[[10]]$selectable <- NULL
tree[[2]]$nodes[[11]]$selectable <- NULL
tree[[2]]$nodes[[12]]$selectable <- NULL
tree[[2]]$nodes[[13]]$selectable <- NULL

### bone
tree[[3]]$nodes[[1]]$selectable <- NULL
tree[[3]]$nodes[[2]]$selectable <- NULL
tree[[3]]$nodes[[3]]$selectable <- NULL
tree[[3]]$nodes[[4]]$selectable <- NULL
tree[[3]]$nodes[[5]]$selectable <- NULL
tree[[3]]$nodes[[6]]$selectable <- NULL
tree[[3]]$nodes[[7]]$selectable <- NULL
tree[[3]]$nodes[[8]]$selectable <- NULL
tree[[3]]$nodes[[9]]$selectable <- NULL
tree[[3]]$nodes[[10]]$selectable <- NULL
tree[[3]]$nodes[[11]]$selectable <- NULL
tree[[3]]$nodes[[12]]$selectable <- NULL
tree[[3]]$nodes[[13]]$selectable <- NULL
tree[[3]]$nodes[[14]]$selectable <- NULL
tree[[3]]$nodes[[15]]$selectable <- NULL
tree[[3]]$nodes[[16]]$selectable <- NULL
tree[[3]]$nodes[[17]]$selectable <- NULL

save(tree, file = here::here("inst/extdata/tree_resection_name.RData"))
##### Sample shiny appp #####

library(shinytreeview)
library(shiny)
load(data_path("trees.RData"))
tree <- tree_reconstruction
tree <- tree_resection
tree <- tree_anatomic_region
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

