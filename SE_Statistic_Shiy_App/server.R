
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

#ShinyApp ab hier
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 2 Plot
    
    #Tab 3 Markdown ####################################################### 
    #Ab hier Code fuer Tab 3 Plot
    #' Markdown Teil der Shiny App 
    #' Es sollen in der UI Grafiken und Tabelle zusammengeklickt und als Markdown Bericht exportiert werden konnen
    #' 
    observeEvent(input$generate_Report, {
        rmarkdown::render('Bericht/Bericht.Rmd', 
                        output_format = epuRate::epurate(),
                        params = list(
                            monat = "Mai",
                            Airport = "EWR"
                            )
                        )
        appendTab(inputId = "nav_bar", tabPanel(title = "Test",
                                                fluidPage(
                                                    fluidRow(
                                                        column(8,
                                                               shiny::includeHTML("Bericht/Bericht.html")
                                                               ))))
        )
        })
    
    table_filter <- reactive({
        flights_filter <- flights %>% 
            dplyr::filter(origin %in% input$airport &
                       carrier %in% input$carrier &
                       as.Date(time_hour, "%m %y") > input$month[1] &
                       as.Date(time_hour, "%m %y") < input$month[2]
            ) %>% 
            group_by(origin, carrier) %>% 
            summarise(avg_delay = mean(dep_delay, na.rm = TRUE))
        return(flights_filter)
    })
    
    table_filter_slow <- shiny::throttle(r = table_filter, millis = 5000)
    output$table <- shiny::renderTable(table_filter_slow() )
})
