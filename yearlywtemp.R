library(tidyverse)
source("utils.R")

prettynames <- c("Beaufort", "Cape Hatteras", "Duck")
names <- c("beauf", "ch", "duck")

processedfiles <- list.files(path = "./deriveddata", pattern = "*.csv")
data <- list()
for (i in 1:length(processedfiles)) {
  df <- read.csv(paste0("./deriveddata/", processedfiles[i]))
  df <- getdate(df)
  df$doy <- as.POSIXlt(df$date, format = "%Y-%m-%d")
  df$doy <- strftime(df$doy, format = "%j")
  df$doy <- as.numeric(df$doy)
  df <- df[,-1]
  assign(gsub('processed.csv', '', processedfiles[i]), df)
  data[[i]] <- get(names[i])
  names(data)[i] <- names[i]
}

for (i in 1:length(data)) {
  df <- data[[i]]
  df$year <- as.factor(df$year)
  df %>%
  group_by(year) %>%
  ggplot(mapping = aes(x = doy, y = av_ss_temp, fill = year)) +
  geom_smooth(size = 0.25) +
  scale_fill_manual(values = c("red", "orange", "yellow", "green", "blue", "purple")) + 
  labs(title = paste(prettynames[i], "Yearly Water Temperature Trends", sep = " "), y = "Water Temperature (\u00B0C)", x = "Day of the Year") +  mytheme() + theme(legend.position = "right")
  ggsave(paste0("./figures/", names[i], "yearlytrend.png"))
}
year1 <- data.frame()
for (i in 1:length(data)) {
  year <- data[[i]]
  year <- year %>% filter(year == 2017) %>% mutate(loc = prettynames[i])
  year1 <- rbind(year1, year)
  }

ggplot(data = year1, mapping = aes(x = doy, y = av_ss_temp, fill = loc)) +
geom_smooth(size = 0.25) + geom_point(mapping = aes(fill = loc)) +
scale_fill_manual(values = c("green", "blue", "purple")) + 
labs(title = paste("2017 Water Temperature Trends"), y = "Temperature (\u00B0C)", x = "Day of the Year") +  mytheme() + theme(legend.position = "right")
ggsave(paste0("./figures/", "2017trend.png"))

