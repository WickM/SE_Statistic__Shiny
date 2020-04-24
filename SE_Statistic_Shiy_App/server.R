
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
library(readxl)
library('MASS')
data(mtcars)

#Daten NewYork Flugdaten
flights <- nycflights13::flights
airports <- nycflights13::airports
airlines <- nycflights13::airlines
weather <- nycflights13::weather
planes <- nycflights13::planes
#Import data chamois

#Chamois <- read_excel("Chamois_climate.xlsx", 
                      #col_types = c("numeric", "text", "numeric", 
                                  # "text", "numeric", "numeric"))
#Chamois$rel.Temp <- round(as.vector(Chamois$rel.Temp),2)


#ShinyApp ab hier
shinyServer(function(input, output) {
    # For storing which rows have been excluded
    vals <- reactiveValues(
        keeprows = rep(TRUE, nrow(Chamois))
    )
    
    
    ## output table with statistic summary

    output$text <- renderText(input$text)
    
    output$plot1 <- renderPlot({
        

        # Plot the kept and excluded points as two separate data sets
        
        keep    <- Chamois[ vals$keeprows, , drop = FALSE]
        exclude <- Chamois[!vals$keeprows, , drop = FALSE]
        
        ggplot(filtered_data(), aes(rel.Temp, b.mass, col =Sex)) +
            geom_jitter(alpha = 0.6) +
            geom_smooth(method = lm, fullrange = TRUE, aes(color = Sex)) +
            geom_point(data = exclude, shape = 21, fill = NA, aes(color = Sex), alpha = 0.6) +
            coord_cartesian(xlim = c(0.9, 1.2), ylim = c(0,30))

    })
    
    # Toggle points that are clicked
    observeEvent(input$plot1_click, {
        res <- nearPoints(Chamois, input$plot1_click, allRows = TRUE)
        
        vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    
    # Toggle points that are brushed, when button is clicked
    observeEvent(input$exclude_toggle, {
        res <- brushedPoints(Chamois, input$plot1_brush, allRows = TRUE)
        
        vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    
    # Reset all points
    observeEvent(input$exclude_reset, {
        vals$keeprows <- rep(TRUE, nrow(Chamois))
    })
    
    ## filter the data
    filtered_data <- reactive({
        dplyr::filter(Chamois, Region == input$Region)
    })

    output$table <- renderTable(filtered_data() %>%
                                    group_by(Sex) %>%
                                    summarise("Mean" = mean(b.mass), 
                                              "Median" = median(b.mass),
                                              "STDEV" = sd(b.mass), 
                                              "Min" = min(b.mass),
                                              "Max" = max(b.mass)))
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    
    
    
    
})
