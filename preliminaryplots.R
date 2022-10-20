library(tidyverse)
source("utils.R")

prettynames <- c("Beaufort", "Cape Hatteras", "Duck")
names <- c("beauf", "ch", "duck")

processedfiles <- list.files(path = "./deriveddata", pattern = "*.csv")
data <- list()
for (i in 1:length(processedfiles)) {
  df <- read.csv(paste0("./deriveddata/", processedfiles[i]))
  df <- getdate(df)
  assign(gsub('processed.csv', '', processedfiles[i]), df)
  data[[i]] <- get(names[i])
  names(data)[i] <- names[i]
}


for (i in 1:length(data)) {
  ggplot() + geom_point(data = data[[i]], mapping = aes(x = date, y = sea_surface_temperature)) + ggtitle(paste0(prettynames[i], " Sea Surface Temperature"))
  ggsave(paste0("./figures/", names[i], "sstpoint.png"))
}

for (i in 1:length(data)) {
  ggplot(data = data[[i]], mapping = aes(x = date, y = sea_surface_temperature)) + geom_point(size=0.5) + stat_smooth(method = "lm", col = "blue") + ggtitle(paste0(prettynames[i], " Sea Surface Temperature Linear Model")) + xlab("Date") + ylab("Sea Surface Temperature") + mytheme()
  ggsave(paste0("./figures/", names[i], "sstglm.png"), width = 8, height = 6, units = "in")
}
