#https://r-charts.com/flow/chord-diagram/

library(circlize)
library(tidyverse)
library(reshape2)
set.seed(1)
m <- matrix(sample(15, 15), 5, 3)
rownames(m) <- paste0("Row", 1:5)
colnames(m) <- paste0("Col", 1:3)

cols <- hcl.colors(15, "Temps")

chordDiagram(m,
             col = cols,
             transparency = 0.1,
             link.lwd = 1,    # Line width
             link.lty = 1,    # Line type
             link.border = 1) # Border color

circos.clear() 


bilat_mig_type <- read_csv("E:/GitHub/flowmap/raw/bilat_mig_type.csv")

m <- bilat_mig_type %>%
  mutate(da_min_open = round(da_min_open, 0)) %>% 
  filter(type == "outward", year0 == 1990, da_min_open > 0,
         orig == "CAN" | orig == "USA" | orig == "AUS",
         dest == "CAN" | dest == "USA" | dest == "AUS") 

m <- dcast(m, formula = orig ~ dest, value="da_min_open", fill=0) %>% 
  as.matrix()

m <- as.data.frame.matrix(xtabs(da_min_open ~ orig + dest, m))
  

