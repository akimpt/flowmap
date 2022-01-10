library(flowmapblue)
library(htmltools)
library(lubridate)

source("../../API_KEYS/R/mapbox_key.R")

bilateral_international_migration <- read_csv("E:/GitHub/flowmap/clean/bilateral_international_migration.csv") %>% 
  mutate(time = lubridate::year(time_year),
         time = as.integer(time) * 1000)
world_centroids <- read_csv("E:/GitHub/flowmap/clean/world_centroids.csv")

flowmap <- flowmapblue(world_centroids, bilateral_international_migration, mapbox_key, clustering=TRUE, darkMode=TRUE, animation=FALSE)

flowmap

save_html(html = flowmap, file = "flowmap.html")

#https://personal.tcu.edu/kylewalker/interactive-flow-visualization-in-r.html

#https://stackoverflow.com/questions/44283774/flow-maptravel-path-using-lat-and-long-in-r