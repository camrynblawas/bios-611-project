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
kmeans <- list()
for (i in 1:length(data)) {
  df <- data[[i]]
  df <- df[,-1]
  df <- df[,-1]
  df <- df[,-9]
  df <- df[,-9]
  df <- df[,-9]
  result[[i]] <- prcomp(df)
  names(result)[i] <- names[i]
  results <- result[[i]]
  result$rotation
  # biplot(results)
  ggplot(results$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) + geom_point() + ggtitle(paste0(prettynames[i], " PCA"))
  # ggsave(paste0("./figures/", names[i], "pca.png"))
  kmeans_data = kmeans(df, center = 3)
  kmeansTab = table(kmeans_data$cluster, df$year)
  kmeans[[i]] <- kmeansTab
  names(kmeans)[i] <- kmeans[i]
  # table(summary(result[[i]]))
}



