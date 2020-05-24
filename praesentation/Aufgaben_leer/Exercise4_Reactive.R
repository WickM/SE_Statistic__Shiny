
# Server Library
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

load("aufb_covid_data_shiny.RData")


# Define UI for application that draws a histogram
ui <- navbarPage("SE Statistic Shiny APP",
  id = "nav_bar",

  tabPanel(
    "Plot",
    sidebarLayout(
      sidebarPanel(
        #Select UI input ID = name
        selectInput("name", "Please select Country",
          choices = c("Austria", "Sweden", "Germany", "Italy", "Japan")
        ),
        #Checkbox UI input ID = dataset
        checkboxGroupInput("dataset", "Source", choices = c("Apple", "Google"), selected = c("Apple", "Google")), 
        #Text UI input ID = text
        textInput("text", "Enter some text to be displayed", "")
      ),

      mainPanel(
        h3(textOutput("text"), width = 6, align = "center"),
        #Tableoutput ID = table
        tableOutput("table"),
        width = 6, align = "Center",
        fluidPage(
          fluidRow(
            column(
              width = 12, align = "Center",
              #Plotly Output id = plot1
              plotlyOutput("plot1", height = 350),
            ),
          )
        )
      )
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  output$text <- renderText(input$text)

  ## Reactive Datafilter
  filtered_data <- ... 
    dplyr::filter(
      subset(dat_mobil_change, Movement_type == "walking" | Movement_type == "driving" | Movement_type == "stay at home"),
      name %in% ... , dataset %in% ... 
    )
  })
  
  #Reactive Plot
  plot <- ...
    ggplot( ... , aes(juliandate, val), col = Movement_type) +
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
  output$... <- renderPlotly(ggplotly( ... ))

  #Table output
  output$... <- renderTable(... %>%
    group_by(Movement_type) %>%
    summarise(
      "Mean" = mean(val),
      "Median" = median(val),
      "STDEV" = sd(val),
      "Min" = min(val),
      "Max" = max(val)
    ))
}

# Run the application
shinyApp(ui = ui, server = server)
