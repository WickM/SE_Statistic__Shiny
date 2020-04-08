
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & ... & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
renv::restore()

#Snapshot ist notwendig wenn librarys hinzugefügt wurden damit wir alle genau dioe gleichen verwendne 
#renv::snapshot()

# Leaflet Library
library(leaflet)

# COVID-19 data formatting
t2_covidCasesWorld <- read.csv(
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
for (col in 5:ncol(t2_covidCasesWorld)){                             # change date from X1.22.20 to 2020-01-22
    t2_newDate <- colnames(t2_covidCasesWorld)[col]                  # get wrong col names
    t2_newDate <- substr(t2_newDate, 2, nchar(t2_newDate))           # remove x
    colnames(t2_covidCasesWorld)[col] <- format(strptime(t2_newDate, "%m.%d.%y"), "%Y-%m-%d")   # change date order to ISO-Date
}
t2_covidCasesWorld


#Server Library
library(shiny)
library(tidyverse)
library(nycflights13)

#Daten NewYork Flugdaten
flights <- nycflights13::flights
airports <- nycflights13::airports
airlines <- nycflights13::airlines
weather <- nycflights13::weather
planes <- nycflights13::planes


#ShinyApp ab hier
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 2 Leaflet ################################################################################    
    output$t2_map <- renderLeaflet({
        leaflet() %>%
        clearMarkers() %>%
        clearShapes() %>%
        addProviderTiles(providers$CartoDB.Positron) %>% 
        addCircleMarkers(data = t2_db(), 
                         lat = ~Lat, 
                         lng = ~Long, 
                         label = ~active_cases,
                         weight = 1,
                         radius = ~(active_cases)^(1/4), 
                         fillOpacity = 0.1, 
                         color = "red")
    })
    
    t2_db <- eventReactive(input$t2_date, {
        t2_db_help <- select(t2_covidCasesWorld, 1:4, as.character(input$t2_date))
        colnames(t2_db_help)[5] <- "active_cases"   # change date to active_cases for easier selection
        t2_db_help
    })
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    


    
})
