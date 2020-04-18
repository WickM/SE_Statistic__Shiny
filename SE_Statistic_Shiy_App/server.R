
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & ... & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
renv::restore()

#Snapshot ist notwendig wenn librarys hinzugefügt wurden damit wir alle genau dioe gleichen verwendne 
#renv::snapshot()

#Server Library
library(shiny)
library(tidyverse)
library(nycflights13)
library(ggplot2)
library(plotly)
library(geepack)
library(dplyr)


#Daten NewYork Flugdaten
flights <- nycflights13::flights
airports <- nycflights13::airports
airlines <- nycflights13::airlines
weather <- nycflights13::weather
planes <- nycflights13::planes

data(sitka89)


#ShinyApp ab hier
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    output$plot <- renderPlotly(
        ggplotly(
            ggplot(sitka89, aes(x = time, y = size)) +
                geom_jitter(fill = "grey",
                            data = sitka89[sitka89$treat == input$treat,])))
    
    
    output$text <- renderText(input$text)
    
    output$table <- renderTable(sitka89 %>%
                                    filter(treat == input$treat) %>%
                                    summarise("Mean" = mean(size), 
                                              "Median" = median(size),
                                              "STDEV" = sd(size), 
                                              "Min" = min(size),
                                              "Max" = max(size)))

    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    


    
})
