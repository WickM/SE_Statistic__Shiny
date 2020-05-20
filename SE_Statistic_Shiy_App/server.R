
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'Server File 
#'Manuel Wick-Eckl & Florian Feik & ...

options(stringsAsFactors = FALSE)

#Mit renv restore wird der zuletzt gespeicherte Snapshot geladen bzw. überprüft ob die Projekt Bibliothek aktuell ist.
renv::restore()

#Snapshot ist notwendig wenn librarys hinzugefügt wurden damit wir alle genau die gleichen verwenden 
#renv::snapshot()


#Leaflet Library
library(leaflet)

#Server Library
library(shiny)
library(dplyr)
library(lubridate)
library(ggplot2)
library(plotly)

load("data/aufb_covid_data_shiny.RData")

#ShinyApp ab hier
shinyServer(function(input, output) {

#Tab 1 Plot ################################################################################    
    output$t1_text <- renderText(input$t1_text)
    
    output$t1_plot <- renderPlot({
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
                      name == input$t1_country, dataset ==input$t1_dataset)
    })

    output$t1_table <- renderTable(filtered_data() %>%
                                    group_by(Movement_type) %>%
                                    summarise("Mean" = mean(val), 
                                              "Median" = median(val),
                                              "STDEV" = sd(val), 
                                              "Min" = min(val),
                                              "Max" = max(val)))
    
    #Tab 2 Leaflet ##########    
    # Ab hier Code fuer Tab 2 Plot
    
    output$t2_map <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$CartoDB.Positron)
    })
    
    observeEvent(c(input$t2_mapType, input$t2_date), {
        leafletProxy("t2_map") %>% 
        clearMarkers() %>%
        clearShapes() %>%
        addCircles(data = t2_data(input$t2_mapType),
                         lat = ~latitude, 
                         lng = ~longitude , 
                         label = ~paste(name, ":", val),
                         weight = 1,
                         radius = ~log(abs(val),2)*25000,
                         fillOpacity = 0.1, 
                         color = ~ifelse(val>0,"red","green"))
    })

     t2_data <- function(t2_type){
         t2_data_help <- data.frame(dat_mobil_change_tab_plot)
         t2_data_help <- t2_data_help[t2_data_help$percent_change_type == input$t2_mapType, ] 
         return(t2_data_help[t2_data_help$date == input$t2_date, ])
             
     }

    #Tab 3 Markdown ####################################################### 
    # Ab hier Code fuer Tab 3 Plot
    # Markdown Teil der Shiny App 
    observeEvent(input$generate_Report, {
        shiny::withProgress(message = 'Report in progress',
                            detail = 'This may take a while',
                            {
                                data <- table_filter_big()
                                shiny::setProgress(value = 0.3, message = "knit Report")
                                rmarkdown::render('Bericht/Bericht.Rmd',
                                output_format = "html_document",
                                    params = list(
                                    data = data
                                    )
                                )
                            shiny::setProgress(value = 0.9, message = "Reporting done",detail="")
                            shiny::appendTab(inputId = "nav_bar", tabPanel(title = "Report",
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
        dat_mobil_change_filter <- dat_mobil_change_tab_markdown %>% 
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
   
    output$tb3_table <- shiny::renderTable(table_filter_slow() )
})


