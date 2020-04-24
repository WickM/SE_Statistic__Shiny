
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & ... & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
#renv::restore()

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
library(readxl)
library(png)

#Daten NewYork Flugdaten
flights <- nycflights13::flights
airports <- nycflights13::airports
airlines <- nycflights13::airlines
weather <- nycflights13::weather
planes <- nycflights13::planes
#Import data dat_mobil_change

#Chamois <- read_excel("Chamois_climate.xlsx", 
                      #col_types = c("numeric", "text", "numeric", 
                                  # "text", "numeric", "numeric"))
#Chamois$date <- round(as.vector(Chamois$rel.Temp),2)


#ShinyApp ab hier
shinyServer(function(input, output) {
    # For storing which rows have been excluded

    ## output table with statistic summary

    output$text <- renderText(input$text)
    
    output$plot1 <- renderPlot({
        

        # Plot filtered data
        

        ggplot(filtered_data(), aes(juliandate,val),col = Movement_type) +
            geom_jitter(alpha = 0.6, aes(color = Movement_type)) +
            geom_smooth(method = loess, fullrange = TRUE, aes(color = Movement_type)) +
            geom_hline(yintercept = 0, linetype="dashed", 
                       color = "grey20", size=0.7)+
            labs( x= "Julian date", y ="Change of Movement in %", size = 10)+
            coord_cartesian(xlim = c(0, 110), ylim = c(-100,100))

    })
    

    ## filter the data
    filtered_data <- reactive({
        dplyr::filter(subset(dat_mobil_change, Movement_type =="walking" | Movement_type =="driving"| Movement_type =="stay at home"),
                      name == input$name, dataset ==input$dataset)
    })
  

    output$table <- renderTable(filtered_data() %>%
                                    group_by(Movement_type) %>%
                                    summarise("Mean" = mean(val), 
                                              "Median" = median(val),
                                              "STDEV" = sd(val), 
                                              "Min" = min(val),
                                              "Max" = max(val)))
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    
    
    
    
})
