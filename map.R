library(tidyverse)
library(ggmap)
library(osmdata)
source("utils.R")

prettynames <- c("Beaufort", "Cape Hatteras", "Duck")
names <- c("beauf", "ch", "duck")

processedfiles <- list.files(path = "./deriveddata", pattern = "*.csv")
data <- list()
for (i in 1:length(processedfiles)) {
  df <- read.csv(paste0("./deriveddata/", processedfiles[i]))
  df <- getdate(df)
  df <- df[,-1]
  df <- df[,-1]
  assign(gsub('processed.csv', '', processedfiles[i]), df)
  data[[i]] <- get(names[i])
  names(data)[i] <- names[i]
}

alldata <- bind_rows(data, .id = 'id')
unique <- alldata[!duplicated(alldata[ , c("lat", "id")]), ]
unique$site <- c("Beaufort", "Cape Hatteras", "Duck")

myLocation <- c(-77.900147,33.802938,-74.75,36.672128)
myMap <- get_stamenmap(bbox =myLocation, zoom = 10)

ggmap(myMap) +
geom_point(data = unique, aes(x = lon, y = lat), color = "blue") + geom_text(aes(x=lon, y=lat, label=site), data=unique, vjust=-.5) + theme(legend.position='none')+ labs(title = "Site Locations", y = "Latitude", x = "Longitude")
ggsave("./figures/sitemap.png", width = 4, height = 4, units = "in")
