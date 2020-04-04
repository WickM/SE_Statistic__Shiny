
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

#Daten NewYork Flugdaten
flights <- nycflights13::flights
airports <- nycflights13::airports
airlines <- nycflights13::airlines
weather <. nycflights13::weather
planes <- nycflights13::planes

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 3 Markdown ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    
    


    
})
