library(tidyverse)
source("utils.R")

chraw <- getdata("HCGN7", 2016:2021)
write.csv(chraw, "sourcedata/chraw.csv")
duckraw <- getdata("DUKN7", 2016:2021)
write.csv(duckraw, "sourcedata/duckraw.csv")
beaufraw <- getdata("BFTN7", 2016:2021)
write.csv(beaufraw, "sourcedata/beaufraw.csv")


rawfiles <- list.files(path = "./sourcedata", pattern = "*.csv")
for (i in 1:length(rawfiles)) {
  df <- read.csv(paste0("./sourcedata/", rawfiles[i]))
  df <- formatdata(df)
  write.csv(df, paste0("./deriveddata/", gsub('raw.csv', 'processed.csv', rawfiles[i])))
}
