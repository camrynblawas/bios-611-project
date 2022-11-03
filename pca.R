library(tidyverse)
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

result <- list()
for (i in 1:length(data)) {
  df <- data[[i]]
  df <- df[,-1]
  df <- df[,-1]
  df <- df[,-9]
  df <- df[,-8]
  result[[i]] <- prcomp(df)
  names(result)[i] <- names[i]
  results <- result[[i]]
  summary(results)
  ggplot(results$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) + geom_point() + ggtitle(paste0(prettynames[i], " PCA"))
  ggsave(paste0("./figures/", names[i], "pca.png"))
  # table(summary(result[[i]]))
}

