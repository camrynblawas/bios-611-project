library(tidyverse)
library(gridExtra)
# library(rnoaa)
# library(ncdf4)

getdata <- function(id, years) {
  i <- years[1]
  df_total = data.frame()
  for (i in years) {
    df <- buoy(dataset = "stdmet", buoyid = id,  year = i)
    df <- data.frame(df$data)
    df_total <- rbind(df_total,df)
  }
  return(df_total)
}

formatdata <- function(df) {
  df <- df %>% mutate(datetime = as.POSIXct(time, format = "%Y-%m-%dT%H:%M:%SZ"), date = as.POSIXct(time, format = "%Y-%m-%d")) %>% select(datetime, date, lat, lon, wind_dir, wind_spd, gust, air_pressure, air_temperature, sea_surface_temperature) %>% drop_na() %>%
    group_by(date) %>%
    summarize(date = mean(date), lat = mean(lat), lon = mean(lon), av_wind_dir = mean(wind_dir), av_wind_spd = mean(wind_spd), av_gust = mean(gust), av_air_pressure = mean(air_pressure), av_air_temp = mean(air_temperature), av_ss_temp = mean(sea_surface_temperature))
  return(df)
}

getdate <- function(df) {
  df$date <- as.Date(as.character(as.POSIXct(df$date, format = "%Y-%m-%d")))
  df$year <- as.numeric(format(df$date, format = "%Y"))
  df$month <- as.numeric(format(df$date, format = "%m"))
  df$day <- as.numeric(format(df$date, format = "%d"))
  df$doy <- as.POSIXlt(df$date, format = "%Y-%m-%d")
  df$doy <- strftime(df$doy, format = "%j")
  df$doy <- as.numeric(df$doy)
  return(df)
}

mytheme <- function() {
  theme(plot.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), axis.line = element_line(colour = "black"), panel.grid.minor=element_line(colour="gray"))
}
