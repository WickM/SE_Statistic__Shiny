#'//////////////////////////////////////////////////////////////////////////////
#' FILE: Covid Mobilitaetsdaten
#' AUTHOR: Manuel Wick-Eckl
#' CREATED: 22 April 2020
#' MODIFIED: 22 April 2020
#' PURPOSE:Script mit welchem die Mobilitätsdaten von Google und Android aufbereitet werden
#' Status: 
#' Comments:
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

#'Libraries:
library(tidyverse)
library(magrittr)
#rvest
#xml2

###Daten----

#Daten von google
dat_google <- readr::read_csv("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv")
#Google LLC "Google COVID-19 Community Mobility Reports." https://www.google.com/covid19/mobility/ Accessed: <2020-4-22>

countries <- 
  xml2::read_html("https://developers.google.com/public-data/docs/canonical/countries_csv") %>% 
  rvest::html_nodes("table") %>%
  .[[1]] %>% 
  rvest::html_table()
#Google LLC "Google Developer" https://developers.google.com/public-data/docs/canonical/countries_csv Accessed: <2020-4-22>

#Daten von Apple 
dat_apple <- readr::read_csv("https://covid19-static.cdn-apple.com/covid19-mobility-data/2006HotfixDev11/v1/en-us/applemobilitytrends-2020-04-20.csv")
#Apple "Apple Mobility Trends Reports" https://www.apple.com/covid19/mobility Accessed: <2020-4-22>

###Aufbereitung Apple ----
#' Apple Daten sind im wide Format
#' Aufbereitung: long Format, anpassen an Google Daten Format
#' -% Änderung von baseline pro Tag für walking, dirving u. transit 
#' Region City herrausnehmen da in google nicht vorhanden als eigenen Datensatz abspeichern
#' spalte % change wie bei google mit Runden auf volle Zahl, 

setdiff(dat_apple$region, countries$name)
#'Laendernamen UK, Macao und "Republic of Korea" umbenennen so das sie zum countries datensatz passen

dat_apple_wide <- 
  dat_apple %>% 
  select(-`2020-01-13`) %>% 
  pivot_longer(data = ., cols = starts_with("2020"), names_to = "date", values_to = "val") %>% 
  mutate("val" = round(val -100, digits = 0),
         percent_change_type = str_c(transportation_type, "_percent_change_from_baseline"),
         name = recode(region, "Macao" = "Macau", "UK" = "United Kingdom", "Republic of Korea" = "South Korea")) %>% 
  select(-region,-transportation_type) %>% 
  left_join(., countries, by="name") %>% 
  select(country, name,latitude, longitude,geo_type,date, percent_change_type, val)

dat_apple_countries <- 
  dat_apple_wide %>% 
  filter(geo_type == "country/region") %>% 
  select(-geo_type)

dat_apple_cities <- 
  dat_apple_wide %>% 
  filter(geo_type == "city") %>% 
  select(-country, -latitude, -longitude,-geo_type)

###Aufbereitung google----
#' Spalten ins wide format
#' country cleaning

setdiff(dat_google$country_region, countries$name)

dat_google_countries <-
  dat_google %>% 
  mutate(name = recode(country_region, "The Bahamas" = "Bahamas", "Czechia"= "Czech Republic", 
                       "North Macedonia" = 	"Macedonia [FYROM]", "Myanmar (Burma)" = "Myanmar [Burma]")) %>%
  pivot_longer(contains("_percent_"),names_to = "percent_change_type", values_to = "val") %>% 
  select(-country_region_code, -sub_region_2) %>% 
  left_join(., countries, by="name") %>% 
  select(country, name, sub_region_1, latitude, longitude, date, percent_change_type, val)

###save ----
#save(dat_apple_countries, dat_apple_cities, dat_google_countries, file = "SE_Statistic_Shiy_App/data/aufb_covid_data.RData")
load("SE_Statistic_Shiy_App/data/aufb_covid_data.RData")

#Tab spezifische daten


dat_mobil_change_tab_markdown <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE) %>% 
  dplyr::mutate(percent_change_type = stringr::str_remove(percent_change_type, "_percent_change_from_baseline"))

dat_mobil_change_tab_plot <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE)

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE)

dat_mobil_change$juliandate <-julian(dat_mobil_change$date, origin = as.Date("2020-01-01"),)
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "driving_percent_change_from_baseline"] <- "driving"
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "walking_percent_change_from_baseline"] <- "walking"
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "residential_percent_change_from_baseline"] <- "stay at home"
colnames(dat_mobil_change)[7] <- "Movement_type"

save(dat_mobil_change_tab_markdown, dat_mobil_change_tab_plot, dat_mobil_change, file = "SE_Statistic_Shiy_App/data/aufb_covid_data_shiny.RData")

