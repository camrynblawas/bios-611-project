library(tidyverse)
library(ggmap)
library(ggpubr)
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
  filter(doy %in% (110:130)) %>%
  ggplot(mapping = aes(x = doy, y = av_ss_temp)) +
  geom_point()+ geom_smooth() + ylim(5,30) +
  facet_grid( ~ id, scales = "free") +
  labs(title = "2017 March, April, and May Temperature Trends", y = "Temperature (\u00B0C)", x = "Day")

alldata %>%
  filter(month == 4) %>%
  ggplot(mapping = aes(x = day, y = av_ss_temp, color=factor(year))) +
  geom_smooth(size=0.25) + ylim(5,30) +
  facet_grid( ~ id, scales = "free") +
  labs(title = "April Temperature Trends", y = "Temperature (\u00B0C)", x = "Day")

my_comp <- list(c("[126,133]","[119,126]"), c("[126,133]", "[112,119]"), c("[126,133]", "[105,112]"), c("[119,126]", "[112,119]"), c("[119,126]", "[105,112]"), c("[112,119]", "[105,112]"))
wcrdays <- alldata %>%
  mutate(bin = cut_width(doy, width=7, boundary=0)) %>%
  filter(year == 2017) %>%
  filter(doy %in% (110:130))
wilcoxtest <- compare_means(av_ss_temp ~ bin, comparisons = my_comp, method='wilcox.test', data = wcrdays)
wilcoxtest <- wilcoxtest %>% mutate(y.position = c(22.5, 24, 25.5, 27, 28.5, 30))
ggplot(data = wcrdays, mapping = aes(x = bin, y = av_ss_temp, group = factor(bin))) + geom_boxplot(fill = "darkcyan") + ylim(10,30) + labs(title = "Possibly WCR Weeks Compared", y = "Temperature (\u00B0C)", x = "Day Bins") + scale_x_discrete() + theme(legend.position = "none") + stat_pvalue_manual(wilcoxtest, label = "p = {p.adj}", size = 3)
ggsave("./figures/warmcoreringdayscompared.png", width = 6, height = 4, units = "in")

alldata %>%
  filter(month == 4) %>%
  filter(day %in% (15:30)) %>%
  ggplot(mapping = aes(x = day, y = av_ss_temp, color=factor(year))) +
  geom_point(alpha=0.2)+
  geom_smooth(size=0.25) + ylim(5,30) +
  facet_grid( ~ id, scales = "free") +
  labs(title = "Late April 2017 Temperature Trends", y = "Temperature (\u00B0C)", x = "Day")

my_comp <- list(c("2017","2016"), c("2017", "2018"), c("2017", "2019"), c("2017", "2020"), c("2017", "2021"))

aprilbeauf <- beauf %>% filter(month==4)
aprilbeauf$year <- as.factor(aprilbeauf$year)
wilcoxtest <- compare_means(av_ss_temp ~ year, comparisons = my_comp, method='wilcox.test', data = aprilbeauf)
wilcoxtest <- wilcoxtest %>% filter(group1 == 2017 | group2 == 2017) %>% mutate(y.position = c(22.5, 24.5, 26.5, 28.5, 30))
ggplot(data = aprilbeauf, mapping = aes(x = year, y = av_ss_temp, group = factor(year))) + geom_boxplot(fill = "darkcyan") + ylim(5,30) + labs(title = "Beaufort April Yearly Temperature Trends Compared", y = "Temperature (\u00B0C)", x = "Year") + scale_x_discrete() + theme(legend.position = "none") + stat_pvalue_manual(wilcoxtest, label = "p = {p.adj}", tip.length = 0.01) 
ggsave("./figures/beaufapriltrends.png", width = 6, height = 4, units = "in")

aprilch <- ch %>% filter(month==4)
aprilch$year <- as.factor(aprilch$year)
wilcoxtest <- compare_means(av_ss_temp ~ year, comparisons = my_comp, method='wilcox.test', data = aprilch)
wilcoxtest <- wilcoxtest %>% filter(group1 == 2017 | group2 == 2017) %>% mutate(y.position = c(22.5, 24.5, 26.5, 28.5, 30))
ggplot(data = aprilch, mapping = aes(x = year, y = av_ss_temp, group = factor(year))) + geom_boxplot(fill = "darkcyan") + ylim(5,30) + labs(title = "Cape Hatteras April Yearly Temperature Trends Compared", y = "Temperature (\u00B0C)", x = "Year") + scale_x_discrete() + theme(legend.position = "none") + stat_pvalue_manual(wilcoxtest, label = "p = {p.adj}", tip.length = 0.01) 
ggsave("./figures/chapriltrends.png", width = 6, height = 4, units = "in")

my_comp <- list(c("2017","2016"), c("2017", "2018"), c("2017", "2019"))
aprilduck <- duck %>% filter(month == 4)
aprilduck$year <- as.factor(aprilduck$year)
wilcoxtest <- compare_means(av_ss_temp ~ year, comparisons = my_comp, method='wilcox.test', data = aprilduck)
wilcoxtest <- wilcoxtest %>% filter(group1 == 2017 | group2 == 2017) %>% mutate(y.position = c(22.5, 25, 28.5))
ggplot(data = aprilduck, mapping = aes(x = year, y = av_ss_temp, group = factor(year))) + geom_boxplot(fill = "darkcyan") + ylim(5,30) + labs(title = "Duck Yearly April Temperature Trends Compared", y = "Temperature (\u00B0C)", x = "Year") + scale_x_discrete() + theme(legend.position = "none") + stat_pvalue_manual(wilcoxtest, label = "p = {p.adj}", tip.length = 0.01) 
ggsave("./figures/duckapriltrends.png", width = 6, height = 4, units = "in")