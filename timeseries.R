library(tidyverse)
library(lubridate)
library(trend)
library(tseries)
source("utils.R")

prettynames <- c("Beaufort", "Cape Hatteras", "Duck")
names <- c("beauf", "ch", "duck")

processedfiles <- list.files(path = "./deriveddata", pattern = "*.csv")
datalist <- list()
for (i in 1:length(processedfiles)) {
  df <- read.csv(paste0("./deriveddata/", processedfiles[i]))
  df <- getdate(df)
  df <- df[,-1]
  assign(gsub('processed.csv', '', processedfiles[i]), df)
  datalist[[i]] <- get(names[i])
  names(datalist)[i] <- names[i]
}

alldata <- bind_rows(data, .id = 'id')

for (i in 1:length(datalist)) {
data = datalist[[i]]
f_month <- month(first(data$date))
f_year <- year(first(data$date))

ts <- ts(data$av_ss_temp,frequency = 12)
ts_decomposed <- stl(ts, s.window = "periodic")
plot(ts_decomposed)
ts_components <- as.data.frame(ts_decomposed$time.series[,1:3])
ts_components <- mutate(ts_components, observed = data$av_ss_temp, date = data$date)
ggplot(ts_components) + geom_line(aes(y = observed, x = date),  size = 0.25) + geom_line(aes(y = trend, x = date), color = "#c13d75ff") + geom_line(aes(y = seasonal, x = date), color = "blue") + ylab("Temperature")
temp_trend
summary(temp_trend)
ts_nonseas <- ts - ts_decomposed$time.series[,1]
ts_components <- mutate(ts_components, nonseasonal = ts_nonseas)
ts_nonseas_trend <- trend::mk.test(ts_nonseas)
ts_nonseas_trend 
ggplot(ts_components) +
  geom_line(aes(y = observed, x = date),  size = 0.25) +
  geom_line(aes(y = nonseasonal, x = date), color = "#c13d75ff") +
  geom_smooth(aes(y = nonseasonal, x = date)) +
  labs(title = paste(prettynames[i],"Seasonal Temperature Trend"), y = "Temperature (\u00B0C)", x = "Date") +
  geom_text(x=as.Date("2021-01-01"), y=2, label=paste0("p-value = ", signif(ts_nonseas_trend$p.value, digits = 6)), size=3)
ggsave(paste0("./figures/", names[i], "seasonaltrend.png"), width = 6, height = 4, units = "in")
}

f_month <- month(first(data$date))
f_year <- year(first(data$date))

beauf_ts <- ts(beauf$av_ss_temp,frequency = 12)
beauf_ts_decomposed <- stl(beauf_ts, s.window = "periodic")
plot(beauf_ts_decomposed)
beauf_ts_components <- as.data.frame(beauf_ts_decomposed$time.series[,1:3])
beauf_ts_components <- mutate(beauf_ts_components, observed = beauf$av_ss_temp, date = beauf$date)
temp_trend <- trend::smk.test(beauf_ts)
temp_trend
summary(temp_trend)

beauf_ts_nonseas <- beauf_ts - beauf_ts_decomposed$time.series[,1]
beauf_ts_components <- mutate(beauf_ts_components, 
                             Nonseasonal = beauf_ts_nonseas)
ggplot(beauf_ts_components) +
  geom_line(aes(y = observed, x = date),  size = 0.25) +
  geom_line(aes(y = Nonseasonal, x = date), color = "#c13d75ff") +
  geom_smooth(aes(y = Nonseasonal, x = date)) +
labs(title = "Beaufort Seasonal Temperature Trend", y = "Temperature (\u00B0C)", x = "Date") + geom_text(x="2022-01-01", y=2, label=paste0("p-value = ", ))
beauf_ts_nonseas_trend <- trend::mk.test(beauf_ts_nonseas)
beauf_ts_nonseas_trend
