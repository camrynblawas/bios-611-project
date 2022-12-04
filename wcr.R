library(tidyverse)
library(ggmap)
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

alldata %>%
  filter(year == 2017) %>%
  filter(month %in% c(3, 4, 5)) %>%
  ggplot(mapping = aes(x = day, y = av_ss_temp)) +
  geom_point()+ geom_smooth() + ylim(5,30) +
  facet_grid( ~ id + month, scales = "free") +
  labs(title = "2017 Temperature Trends", y = "Temperature (\u00B0C)", x = "Day")

alldata %>%
  filter(year == 2017) %>%
  filter(month == 4) %>%
  ggplot(mapping = aes(x = day, y = av_ss_temp)) +
  geom_point()+ geom_smooth() + ylim(5,30) +
  facet_grid( ~ id, scales = "free") +
  labs(title = "April 2017 Temperature Trends", y = "Temperature (\u00B0C)", x = "Day")