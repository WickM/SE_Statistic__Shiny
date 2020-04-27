
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
t2_dataImportAndFormating <- function(linkToData) {
    import <- read.csv(linkToData)
    for (col in 5:ncol(import)){                                                        # change date from X1.22.20 to 2020-01-22
        t2_newDate <- colnames(import)[col]                                             # get wrong col names
        t2_newDate <- substr(t2_newDate, 2, nchar(t2_newDate))                          # remove x
        colnames(import)[col] <- format(strptime(t2_newDate, "%m.%d.%y"), "%Y-%m-%d")   # change date order to ISO-Date
    }
    return(import)
}

t2_covidCasesWorld <- t2_dataImportAndFormating("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
t2_covidDeathsWorld <- t2_dataImportAndFormating("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
t2_covidRecoveredWorld <- t2_dataImportAndFormating("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")

#Server Library
library(shiny)
library(tidyverse)

#ShinyApp ab hier
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 2 Leaflet ################################################################################    
    output$t2_map <- renderLeaflet({
        leaflet() %>%
        addProviderTiles(providers$CartoDB.Positron)
    })
    
    observeEvent(c(input$t2_mapType, input$t2_date), {
        leafletProxy("t2_map") %>% 
        clearMarkers() %>%
        clearShapes() %>%
        addCircleMarkers(data = t2_data(), 
                         lat = ~Lat, 
                         lng = ~Long, 
                         label = ~effected_cases,
                         weight = 1,
                         radius = ~(effected_cases)^(1/3.5), 
                         fillOpacity = 0.1, 
                         color = "red")
    })

    t2_data <- function(){
            if (input$t2_mapType == "Confirmed Cases"){
                t2_data_help <- select(t2_covidCasesWorld, 1:4, as.character(input$t2_date))
            } else if (input$t2_mapType == "Confirmed Deaths"){
                t2_data_help <- select(t2_covidDeathsWorld, 1:4, as.character(input$t2_date))
            } else if (input$t2_mapType == "Recovered Cases"){
                t2_data_help <- select(t2_covidRecoveredWorld, 1:4, as.character(input$t2_date))
            }
        
            colnames(t2_data_help)[5] <- "effected_cases"           # change col name from date to effected_cases for uniform selection
            return(t2_data_help[!(t2_data_help$effected_cases==0),])  # remove rows with zero cases
    }
    
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    


    
})
