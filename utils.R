library(tidyverse)
library(rnoaa)

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
  df <- df %>% mutate(datetime = as.POSIXct(time, format = "%Y-%m-%dT%H:%M:%SZ"), date = as.POSIXct(time, format = "%Y-%m-%d")) %>% select(datetime, date, lat, lon, wind_dir, wind_spd, gust, air_pressure, air_temperature, sea_surface_temperature)
  return(df)
}

getdate <- function(df) {
  df$datetime <- as.POSIXct(df$datetime, format = "%Y-%m-%d %H:%M:%S")
  df$date <-  as.Date(as.character(as.POSIXct(df$datetime, format = "%Y-%m-%d")))
  return(df)
}

mytheme <- function() {
  theme(plot.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), axis.line = element_line(colour = "black"), panel.grid.minor=element_line(colour="gray"))
}
