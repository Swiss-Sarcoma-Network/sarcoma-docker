reconstruction <- data.frame(
  group = c("Not applicable",
            "skin- / mesh-graft",
            rep("pedicled tissue transfer", 17),
            rep("free tissue transfer", 5),
            rep("tendon / ligament", 3),
            rep("bone", 22),
            rep("vessel", 6),
            rep("nerve", 4),
            "chest wall",
            rep("abdomen", 6),
            rep("sequelae of primary treatment", 3)
  ),
  sub = c(NA,
          "recA.1 skin- / mesh-graft",
          rep("muscle flaps", 15),
          rep("perforator flap", 2),
          "recC.1 latissimus dorsi",
          "recC.2 gracilis",
          "recC.5 other free tissue transfer (please specify in next field)",
          rep("perforator flap", 2),
          "recJ.1 autologous tendon transfer",
          "recJ.2 allograft tendon reconstruction",
          "recJ.3 local tendon reconstruction",
          "recD.1 cementation",
          "recD.2 ORIF (incl. bone ankers; removal of OS material)",
          "recD.13 pedicle screws / rods / cages",
          "recD.16 artificial bone substitute (Ca-sulfate etc)",
          "recD.3 autograft",
          "recD.4 vascularised fibula autograft (based on fibular artery)",
          "recD.20 vascularised epiphyseal transfer (based on tibial anterior artery)",
          "recD.5 non-vascularised fibula autograft",
          "recD.6 pasteurised autograft",
          "recD.7 allograft chips",
          "recD.8 bulk allograft",
          "recD.9 conventional prosthesis",
          "recD.10 modular tumor prosthesis",
          "recD.11 custom-made prosthesis",
          "recD.12 growing prosthesis",
          "recD.18 arthrodesis",
          "recD.15 distraction osteogenesis",
          "recD.17 cement spacer / pseudoarthrosis / flail joint",
          "recD.19 Canadell distraction epiphyseolysis",
          "recD.14 other bone reconstruction (please specify in next field)",
          "recD.21 pseudarthrosis (intentional)",
          "recD.22 goretex mesh; Trevira etc",
          "recF.1 artery complete",
          "recF.2 artery patch",
          "recF.3 vein complete",
          "recF.4 vein patch",
          "recF.5 lympho-venous",
          "recF.6 other vessel reconstruction (please specify in next field)",
          "recG.1 nerve reconstruction (please specify in next field)",
          "recG.2 neurotisation / local transfer",
          "recG.31 neurotisation / local transfer autologous (please specify in next field)",
          "recG.32 neurotisation / local transfer allograft",
          "recH chest wall reconstruction",
          rep("abdominal wall reconstruction", 1),
          rep("Intraabdominal reconstruction", 5),
          "recK.1 cement spacer implantation",
          "recK.2 partial implantation / replacement",
          "recK.3 complete prosthesis implantation / replacement"
  ),
  reconstruction_name = c(NA,
                          ###
                          NA,
                          ###
                          "recB.1 rectus abdominis",
                          "recB.15 rectus abdominis (with skin)",
                          "recB.2 gastrocnemius",
                          "recB.25 gastrocnemius (with skin)",
                          "recB.3 latissimus dorsi",
                          "recB.35 latissmus dorsi (with skin)",
                          "recB.4 gracilis",
                          "recB.45 gracilis (with skin)",
                          "recB.5 sartorius",
                          "recB.55 sartorius (with skin)",
                          "recB.6 soleus",
                          "resB.65 soleus (with skin)",
                          "recB.7 serratus",
                          "recB.75 serratus (with skin)",
                          "recB.10 other muscle flap (please specify in next field)",
                          "recB.8 ALT",
                          "recB.9 other (please specify in next field)",
                          ###
                          rep(NA, 3),
                          "recC.3 ALT",
                          "recC.4 other perforator flap (please specify in next field)",
                          ###
                          rep(NA, 3),
                          ###
                          rep(NA, 22),
                          ###
                          rep(NA, 6),
                          ###
                          rep(NA, 4),
                          rep(NA, 1),
                          ###
                          "recI.1 wall",
                          ###
                          "recI.2 colon anastomosis",
                          "recI.3 stoma",
                          "recI.4 bladder",
                          "recI.5 ureter",
                          "recI.6 other intraabdominal reconstruction (please specify in next field)",
                          ###
                          rep(NA, 3)
  )
)

args <- list(
  data = reconstruction,
  levels = names(reconstruction)
)
#args$data <- args$data[1:5,]
args[names(reconstruction)[1:2]] <- list(list(selectable = FALSE))
tree <- do.call(make_tree, args)

# Setting node to NULL, makes the node selectable again
### Not (yet) determined
tree[[1]]$selectable <- NULL

tree[[2]]$nodes[[1]]$selectable <- NULL

tree[[4]]$nodes[[1]]$selectable <- NULL
tree[[4]]$nodes[[2]]$selectable <- NULL
tree[[4]]$nodes[[3]]$selectable <- NULL

tree[[6]]$nodes[[1]]$selectable <- NULL
tree[[6]]$nodes[[2]]$selectable <- NULL
tree[[6]]$nodes[[3]]$selectable <- NULL
tree[[6]]$nodes[[4]]$selectable <- NULL
tree[[6]]$nodes[[5]]$selectable <- NULL
tree[[6]]$nodes[[6]]$selectable <- NULL
tree[[6]]$nodes[[7]]$selectable <- NULL
tree[[6]]$nodes[[8]]$selectable <- NULL
tree[[6]]$nodes[[9]]$selectable <- NULL
tree[[6]]$nodes[[10]]$selectable <- NULL
tree[[6]]$nodes[[11]]$selectable <- NULL
tree[[6]]$nodes[[12]]$selectable <- NULL
tree[[6]]$nodes[[13]]$selectable <- NULL
tree[[6]]$nodes[[14]]$selectable <- NULL
tree[[6]]$nodes[[15]]$selectable <- NULL
tree[[6]]$nodes[[16]]$selectable <- NULL
tree[[6]]$nodes[[17]]$selectable <- NULL
tree[[6]]$nodes[[18]]$selectable <- NULL
tree[[6]]$nodes[[19]]$selectable <- NULL
tree[[6]]$nodes[[20]]$selectable <- NULL
tree[[6]]$nodes[[21]]$selectable <- NULL
tree[[6]]$nodes[[22]]$selectable <- NULL

tree[[7]]$nodes[[1]]$selectable <- NULL
tree[[7]]$nodes[[2]]$selectable <- NULL
tree[[7]]$nodes[[3]]$selectable <- NULL
tree[[7]]$nodes[[4]]$selectable <- NULL
tree[[7]]$nodes[[5]]$selectable <- NULL
tree[[7]]$nodes[[6]]$selectable <- NULL

tree[[8]]$nodes[[1]]$selectable <- NULL
tree[[8]]$nodes[[2]]$selectable <- NULL
tree[[8]]$nodes[[3]]$selectable <- NULL
tree[[8]]$nodes[[4]]$selectable <- NULL

tree[[9]]$nodes[[1]]$selectable <- NULL

tree[[11]]$nodes[[1]]$selectable <- NULL
tree[[11]]$nodes[[2]]$selectable <- NULL
tree[[11]]$nodes[[3]]$selectable <- NULL


save(tree, file = here::here("inst/extdata/tree_reconstruction_name.RData"))

##### Sample app ######
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
