
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & ... & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
renv::restore()

#Snapshot ist notwendig wenn librarys hinzugefügt wurden damit wir alle genau die gleichen verwenden 
#renv::snapshot()

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
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 2 Plot
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 3 Plot
    
    observe( 
        for(temp_y in input$y_achse) {
            local({ 
                y <- temp_y
                output[[y]] <- renderPlot( 
                    qplot(!!sym(input$x_achse), !!sym(y), data = iris)
                )
            }
            )}
    )
    
    output$plots <- renderUI(
        lapply(
            lapply(input$y_achse, plotOutput, height = "200", width = "200"),
            div,
            style = htmltools::css(display = "inline-block")
        )
    )
    
})
