library(tidyverse)
library(ggpmisc)
source("utils.R")

prettynames <- c("Beaufort", "Cape Hatteras", "Duck")
names <- c("beauf", "ch", "duck")

processedfiles <- list.files(path = "./deriveddata", pattern = "*.csv")
data <- list()
for (i in 1:length(processedfiles)) {
  df <- read.csv(paste0("./deriveddata/", processedfiles[i]))
  df <- getdate(df)
  df <- df[,-1]
  df <- df[,-2]
  df <- df[,-2]
  assign(gsub('processed.csv', '', processedfiles[i]), df)
  data[[i]] <- get(names[i])
  names(data)[i] <- names[i]
}

for (i in 1:length(data)) {
  plot(data[[i]])
}

for (i in 1:length(data)) {
  ggplot() + geom_point(data = data[[i]], mapping = aes(x = date, y = av_ss_temp)) + ggtitle(paste0(prettynames[i], " Sea Surface Temperature"))
  ggsave(paste0("./figures/", names[i], "sstpoint.png"))
}

for (i in 1:length(data)) {
  ggplot(data = data[[i]], mapping = aes(x = date, y = av_ss_temp)) + geom_point(size=0.5) + stat_poly_line() + stat_poly_eq(aes(label = paste(after_stat(eq.label), after_stat(rr.label), sep = "*\", \"*")), size = 3)  + ggtitle(paste0(prettynames[i], " Sea Surface Temperature Linear Model")) + xlab("Date") + ylab("Sea Surface Temperature") + mytheme()
  ggsave(paste0("./figures/", names[i], "sstglm.png"), width = 8, height = 6, units = "in")
}
