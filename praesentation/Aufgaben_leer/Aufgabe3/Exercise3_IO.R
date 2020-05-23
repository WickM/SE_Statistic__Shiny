# Server Library
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

load("aufb_covid_data_shiny.RData")

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 3",
  tabPanel("Plot",
           sidebarLayout(
             # Data selection in the sidebar below
             sidebarPanel(
               .......("country", 
                       ............,
                       choices = c("Austria", "Sweden", "Germany", "Italy", "Japan")),
               .......("dataset",
                       ..........., 
                       choices = c("Apple","Google"), 
                       selected = ......),
               .......("text", 
                         label = ........., 
                         value = .........),
               br(),
               
               img(src=CoronaVirusImageLink, width = "100%")
             ),
             
             # Output in the main panel below
             mainPanel(
               ..(.........("text")),
               ............("table"),
               ............("plot")
             )
           )
  ),
  tabPanel("Leaflet"),
  tabPanel("Markdown")
)

server <- function(input, output) {
  ....$text <- .........(.........)
  
  # ~+~+~+ TIPP +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
  # Input functions needed in the side panel:
  #   checkboxGroupInput(), textInput(), selectInput()
  #
  # Output functions needed in the main panel:
  #   textOutput(), tableOutput(), plotlyOutput()
  # ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+
  
  # Everything below here does not need to be changed 
  
  ## Reactive Datafilter
  filtered_data <- reactive({
    dplyr::filter(
      subset(dat_mobil_change, Movement_type == "walking" | Movement_type == "driving" | Movement_type == "stay at home"),
      name %in% input$country, dataset %in% input$dataset
    )
  })
  
  #Reactive Plot
  plot <- reactive({
    ggplot(filtered_data(), aes(juliandate, val), col = Movement_type) +
      geom_jitter(alpha = 0.6, aes(color = Movement_type)) +
      geom_smooth(method = loess, fullrange = TRUE, aes(color = Movement_type)) +
      geom_hline(
        yintercept = 0, linetype = "dashed",
        color = "grey20", size = 0.7
      ) +
      labs(x = "Julian date", y = "Change of Movement in %", size = 10) +
      coord_cartesian(xlim = c(0, 110), ylim = c(-100, 100))
  })
  
  #Plotly Output
  output$plot <- renderPlotly(ggplotly(plot()))
  
  #Table output
  output$table <- renderTable(filtered_data() %>%
                                group_by(Movement_type) %>%
                                summarise(
                                  "Mean" = mean(val),
                                  "Median" = median(val),
                                  "STDEV" = sd(val),
                                  "Min" = min(val),
                                  "Max" = max(val)
                                ))
}

# Run the app ----
shinyApp(ui, server)