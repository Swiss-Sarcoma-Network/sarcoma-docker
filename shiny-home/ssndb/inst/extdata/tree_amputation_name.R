amputation <- data.frame(
  group = c("Not applicable",
            rep("forequarter", 2),
            rep("upper extremity", 6),
            rep("lower extremity", 6)),
  amputation_name = c(NA,
                      "resB.52 forequarter amputation with chest wall",
                      "resB.53 forequarter amputation without chest wall",
                      "resB.62 shoulder joint trans-articular",
                      "resB.63 humerus",
                      "resB.64 elbow joint",
                      "resB.65 forearm",
                      "resB.66 hand / wrist",
                      "resB.67 finger",
                      "resB.68 hip disarticulation",
                      "resB.69 thigh",
                      "resB.70 knee joint",
                      "resB.71 BKA",
                      "resB.72 foot",
                      "resB.90 digit")
)

args <- list(
  data = amputation,
  levels = names(amputation)
)
args[names(amputation)[1]] <- list(list(selectable = FALSE))
tree <- do.call(make_tree, args)

# Setting node to NULL, makes the node selectable again
### Not (yet) determined
tree[[1]]$selectable <- NULL

save(tree, file = here::here("inst/extdata/tree_amputation_name.RData"))

