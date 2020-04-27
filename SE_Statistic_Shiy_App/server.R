
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & Florian Feik & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
renv::restore()

#Snapshot ist notwendig wenn librarys hinzugefügt wurden damit wir alle genau dioe gleichen verwendne 
renv::snapshot()

#Leaflet Library
library(leaflet)

#Server Library
library(shiny)
library(tidyverse)

#Data import
library(magrittr)

load("data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
    dplyr::mutate(date = as.Date(date)) %>% 
    dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
    dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
    dplyr::filter(is.na(sub_region_1) == TRUE)


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
        addCircleMarkers(data = t2_data(input$t2_mapType),  #TODO: addCircleMarkers or addCircles
                         lat = ~latitude, 
                         lng = ~longitude , 
                         label = ~paste(name, ":", val),
                         weight = 1,
                         radius = ~abs(val),               #TODO: proper scaling
                         fillOpacity = 0.1, 
                         color = ~ifelse(val>0,"red","green"))
    })

     t2_data <- function(t2_type){
         t2_data_help <- data.frame(dat_mobil_change)
         t2_data_help <- t2_data_help[t2_data_help$percent_change_type == input$t2_mapType, ] 
         return(t2_data_help[t2_data_help$date == input$t2_date, ])
             
     }


     
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    


    

})