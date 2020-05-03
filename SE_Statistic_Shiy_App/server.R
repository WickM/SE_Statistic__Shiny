
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
library(lubridate)

load("data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
    dplyr::mutate(date = as.Date(date)) %>% 
    dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
    dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
    dplyr::filter(is.na(sub_region_1) == TRUE) %>% 
    dplyr::mutate(percent_change_type = stringr::str_remove(percent_change_type, "_percent_change_from_baseline"))


#ShinyApp ab hier
shinyServer(function(input, output) {
    #Tab 1 Plot Code ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 2 Leafleat ##########    
    #Ab hier Code fuer Tab 1 Plot
    
    #Tab 3 Markdown ####################################################### 
    #Ab hier Code fuer Tab 3 Plot
    #' Markdown Teil der Shiny App 
    #' Es sollen in der UI Grafiken und Tabelle zusammengeklickt und als Markdown Bericht exportiert werden konnen
    #' 
    observeEvent(input$generate_Report, {
        shiny::withProgress(message = 'Report in progress',
                            detail = 'This may take a wile',
                            {
                                data <- table_filter_big()
                                shiny::setProgress(value = 0.3, message = "knit Report")
                                rmarkdown::render('Bericht/Bericht.Rmd', 
                                output_format = epuRate::epurate(),
                                    params = list(
                                    data = data
                                    )
                                )
                            shiny::setProgress(value = 0.9, message = "Reporting done",detail="")
                            appendTab(inputId = "nav_bar", tabPanel(title = "Report",
                                                    fluidPage(
                                                        fluidRow(
                                                            column(12,
                                                                   shiny::includeHTML("Bericht/Bericht.html")
                                                                ))))
                            )
                            }
                    )
        })
    
    table_filter_big <- reactive({
        dat_mobil_change_filter <- dat_mobil_change %>% 
            dplyr::filter(name %in% input$t3_countries & 
                              percent_change_type %in% input$t3_activity & 
                              date > input$t3_date[1] & 
                              date < input$t3_date[2]) %>% 
            dplyr::arrange(name, date)
        return(dat_mobil_change_filter)
    })
    
    table_filter_small <- reactive({
        dat_mobil_change_filter <- table_filter_big()
        
        dat_mobil_change_filter <- dat_mobil_change_filter %>% 
            dplyr::mutate(month = lubridate::month(date,label =TRUE)) %>% 
            group_by(name,month,percent_change_type) %>% 
            summarise(p_change = mean(val, na.rm = TRUE))
        
        return(dat_mobil_change_filter)
    })
    
    
    table_filter_slow <- shiny::throttle(r = table_filter_small, millis = 1000)
   
    output$table <- shiny::renderTable(table_filter_slow() )
})


