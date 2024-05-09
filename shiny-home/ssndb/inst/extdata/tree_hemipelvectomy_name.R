hemipelvectomy <- data.frame(
  group = c("Not applicable",
            rep("type I", 9),
            rep("type II", 28),
            rep("type III", 5),
            rep("type IV", 18),
            rep("type V", 8)
  ),
  hemipelvectomy_name = c(NA,
                          "resB.12 type I - 1.1. preservation of pelvic ring",
                          "resB.13 type I - 2.1. supra-acetabular: lateral to SIJ",
                          "resB.14 type I - 2.2. supra-acetabular: medial to SIJ; lateral to sacral foramina (through sacral ala)",
                          "resB.14.1 type I - 2.4. supra-acetabular: through sacral foramina",
                          "resB.15 type I - 2.3. supra-acetabular: medial to sacral foramina / midline",
                          "resB.16 type I - 3.1. trans-acetabular: lateral to SIJ",
                          "resB.17 type I - 3.2. trans-acetabular: medial to SIJ; lateral to sacral foramina (through sacral ala)",
                          "resB.17.1 type I - 3.4. trans-acetabular: through sacral foramina",
                          "resB.18 type I - 3.3. trans-acetabular: medial to sacral foramina / midline",
                          "resB.19 type II - 1.1. superior part of Y (incl. parts of ilium)",
                          "resB.20 type II - 1.2. medial part of Y (parts of pubis)",
                          "resB.21 type II - 1.3. posterior / lateral part of Y (incl. parts of ischium)",
                          "resB.22 type II - 2.1. periacetabular (preservation of ilium; ischium; pubis)",
                          "resB.22.1 * A: periacetabular resections: transarticular",
                          "resB.22.2 * B: periacetabular resections: extraarticular with pelvic ring disruption",
                          "resB.22.3 * C: periacetabular resections: extraarticular without pelvic ring disruption (periacetabular resection)",
                          "resB.23 type II - 3.1. lateral to SIJ",
                          "resB.24 type II - 3.2. medial to SIJ - lateral to foramina (through sacral ala)",
                          "resB.24.1 type II - 3.3. medial to foramina / midline",
                          "resB.24.2 * A: acetabulum plus ilium / sacrum: transarticular",
                          "resB.24.3. * B: acetabulum plus ilium / sacrum: extraarticular",
                          "resB24.4 type II - 3.4. through foramina",
                          "resB.25 type II - 4.1. incl. ramus superior / symphysis",
                          "resB.26 type II - 4.2. incl. ischium / tuber ischiadicum",
                          "resB.27 type II - 4.3. complete pubis / ischium (OT through symphysis)",
                          "resB.91 *A: acetabulum plus pubis: transarticular",
                          "resB.92 *B: acetabulum plus pubis: extraarticular",
                          "resB.28.1 type II - 5.1. proximal OT: lateral to SIJ",
                          "resB.28.2 type II - 5.2. proximal OS: medial to SIJ - lateral to foramina (through sacral ala)",
                          "resB.28.3 type II - 5.3. proximal OT: medial to foramina / midline",
                          "resB.28.4 type II - 5.a. distal OT: incl. ramus superior / symphysis",
                          "resB.28.5 type II - 5.b. distal OT: incl. tuber ischiadicum",
                          "resB.28.6 type II - 5.c. distal OT: pubis & ischium",
                          "resB.28.7 type II - 5.4. through foramina",
                          "resB.28 *A: acetabulum plus pubis / ischium and ilium / sacrum: trans-articular",
                          "resB.29 *B: acetabulum plus pubis / ischium and ilium / sacrum: extra-articular with pelvic ring disruption",
                          "resB.30 *C: acetabulum plus pubis / ischium and ilium / sacrum: extra-articular without pelvic ring disruption",
                          "resB.31 type III - 1.1. superior ramus",
                          "resB.32 type III - 1.2. inferior ramus",
                          "resB.33 type III - 1.3. both superior and inferior rami",
                          "resB.38 *A: tuber ischiadicum: preserved",
                          "resB.39 *B: tuber ischiadium: resected",
                          "resB.40 type IV - 1.1. partial; unilateral",
                          "resB.41 type IV - 1.2. complete / bilateral",
                          "resB.41.1 * A: posterior approach only",
                          "resB.41.2. * B: combined anterior & posterior approach",
                          "resB.41.3. * C: plus exenteration",
                          "resB.42 type IV - 2.1. no spino-pelvic dissociation",
                          "resB.43 type IV - 2.2. unilateral spino-pelvic dissociation",
                          "resB.44 type IV - 2.3. bilateral spino-pelvic dissociation",
                          "resB.49.1 * A: posterior approach only",
                          "resB.50.1 * B: combined anterior & posterior approach",
                          "resB.51.1 * C: plus exenteration",
                          "resB.45 type IV - 3.1. complete spino-pelvic dissociation",
                          "resB.46 type IV - 3.2. with parts of lumbar spine",
                          "resB.47 type IV - 3.3. with parts of iliac bone",
                          "resB.48 type IV - 3.4. with parts of lumbar & iliac bones",
                          "resB.49.2 * A: posterior approach only",
                          "resB.50.2 * B: combined anterior & posterior approach",
                          "resB.51.2 * C: plus exenteration",
                          "resB.54 hemipelvectomy type V - 1. trans-acetabular (with dissociation of pelvic ring; excluding hip disarticulation)",
                          "resB.55 hemipelvectomy type V - 2. trans-ilium (extra-articular - incl. supra-acetabular)",
                          "resB.56 hemipelvectomy type V - 3. trans-hemi-sacral incl. hemilumbar without contralateral spinopelvic dissociation",
                          "resB.57 hemipelvectomy type V - 4. trans-hemi-sacral incl. hemilumbar with contralateral spinopelvic dissociation",
                          "resB.58 hemipelvectomy type V - 5. hemicorporectomy",
                          "resB.59 * A: posterior flap",
                          "resB.60 * B: anterior flap",
                          "resB.61 * C: other (please specify in next field)"
  )
)

args <- list(
  data = hemipelvectomy,
  levels = names(hemipelvectomy)
)
args[names(hemipelvectomy)[1]] <- list(list(selectable = FALSE))
tree <- do.call(make_tree, args)

# Setting node to NULL, makes the node selectable again
### Not (yet) determined
tree[[1]]$selectable <- NULL

save(tree, file = here::here("inst/extdata/tree_hemipelvectomy_name.RData"))

