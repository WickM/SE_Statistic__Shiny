
#' Titel: Se Statistic Shiny App
#' date 03.04.2020
#' UI File
#' Manuel Wick-Eckl & Florian Feik & ...

options(stringsAsFactors = FALSE)

library(shiny)
library(leaflet)
library(magrittr)
library(plotly)

load("data/aufb_covid_data_shiny.RData")
# load("SE_Statistic_Shiy_App/data/aufb_covid_data_shiny.RData")

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

<<<<<<< HEAD
# Define UI for application that draws a histogram
shinyUI(
  navbarPage("SE Statistic Shiny APP",
    id = "nav_bar",
    # Tab1----#####################################################################
    tabPanel(
      "Plot",
      sidebarLayout(
        sidebarPanel(
          # Ab hier Code fuer Sidebar
          selectInput("name", "Please select Country",
            choices = c("Austria", "Sweden", "Germany", "Italy", "Japan")
          ),
          checkboxGroupInput("dataset", "Source", choices = c("Apple", "Google"), selected = c("Apple", "Google")),
          textInput("text", "Enter some text to be displayed", "")
        ),

        mainPanel(
          h3(textOutput("text"), width = 6, align = "center"),
          tableOutput("table"),
          width = 6, align = "Center",
          fluidPage(
            fluidRow(
              column(
                width = 12, align = "Center",
                plotlyOutput("plot1", height = 350),
              ),
              # actionButton("exclude_toggle", "Toggle points"),
              # actionButton("exclude_reset", "Reset")
            )
          )
        )
      )
    ),

    # Tab2----#####################################################################

    tabPanel(
      "Leaflet",
      sidebarLayout(
        sidebarPanel(
          h5("COVID-19 induced reduction in population mobility"),

          selectInput("t2_mapType",
            label = "mobility metric",
            choices = c(
              "driving" = "driving_percent_change_from_baseline",
              "walking" = "walking_percent_change_from_baseline",
              "transit" = "transit_percent_change_from_baseline",
              "retail store visits" = "retail_and_recreation_percent_change_from_baseline",
              "grocery store visits" = "grocery_and_pharmacy_percent_change_from_baseline",
              "park visits" = "parks_percent_change_from_baseline",
              "train station usage" = "transit_stations_percent_change_from_baseline",
              "workplaces occupation" = "workplaces_percent_change_from_baseline",
              "staying at home" = "residential_percent_change_from_baseline"
            ),
            selected = "driving_percent_change_from_baseline"
          ),

          sliderInput("t2_date",
            label = "Date input",
            min = as.Date(min(dat_mobil_change_tab_plot$date)),
            max = as.Date(max(dat_mobil_change_tab_plot$date)),
            value = as.Date(min(dat_mobil_change_tab_plot$date)),
            timeFormat = "%d %b",
            animate = animationOptions(interval = 1000, loop = FALSE)
          ),
        ),

        mainPanel(
          leafletOutput("t2_map")
        )
      )
    ),

=======
shinyUI(navbarPage("SE Statistic Shiny APP", id = "nav_bar",
                   
# Plot Tab ----#####################################################################
tabPanel("Plot",
         sidebarLayout(
           sidebarPanel(
             selectInput("t1_country", 
                         label = "Please select Country",
                         choices = c("Austria", "Sweden", "Germany", "Italy", "Japan")),
             checkboxGroupInput("t1_dataset",
                                label = "Source", 
                                choices = c("Apple","Google"), 
                                selected = c("Apple","Google")),
             textInput("t1_text", 
                       label = "Enter Title", 
                       value = "Title"),
             br(),

             img(src=CoronaVirusImageLink, width = "100%")
            ),
           
           mainPanel(
             h2(textOutput("t1_text")),
             tableOutput("t1_table"),
             plotOutput("t1_plot")
           )
         )
),

# Leaflet Tab ----#####################################################################
tabPanel("Leaflet",
         sidebarLayout(
           
           sidebarPanel(
             
             h5("COVID-19 induced reduction in population mobility"),
             
             selectInput("t2_mapType",
                         label = "mobility metric",
                         choices = c(
                           "driving"="driving_percent_change_from_baseline",
                           "walking"="walking_percent_change_from_baseline",
                           "transit"="transit_percent_change_from_baseline",
                           "retail store visits"="retail_and_recreation_percent_change_from_baseline",
                           "grocery store visits"="grocery_and_pharmacy_percent_change_from_baseline",
                           "park visits"="parks_percent_change_from_baseline",
                           "train station usage"="transit_stations_percent_change_from_baseline",
                           "workplaces occupation"="workplaces_percent_change_from_baseline",    
                           "staying at home"="residential_percent_change_from_baseline"),
                         selected = "driving_percent_change_from_baseline"),
             
             sliderInput("t2_date",
                         label = "Date input",
                         min = as.Date(min(dat_mobil_change_tab_plot$date)),
                         max = as.Date(max(dat_mobil_change_tab_plot$date)),  
                         value = as.Date(min(dat_mobil_change_tab_plot$date)),
                         timeFormat = "%d %b",
                         animate = animationOptions(interval = 1000, loop = FALSE)
             ),
           ),
           mainPanel(leafletOutput("t2_map"))
         )
),
>>>>>>> 9d05bf718f6815431c15c0faf8ca0107796d2078

    # Tab3----#####################################################################
    tabPanel(
      "Markdown",
      sidebarLayout(
        sidebarPanel(
          width = 4,
          shiny::selectizeInput(inputId = "t3_countries", label = "Countries", multiple = TRUE, choices = unique(dat_mobil_change_tab_markdown$name)),
          shiny::selectizeInput(inputId = "t3_activity", label = "Activity Type", multiple = TRUE, choices = unique(dat_mobil_change_tab_markdown$percent_change_type), selected = unique(dat_mobil_change_tab_markdown$percent_change_type)),
          shiny::sliderInput(
            inputId = "t3_date", label = "Date",
            min = min(dat_mobil_change_tab_markdown$date),
            max = max(dat_mobil_change_tab_markdown$date),
            value = c(min(dat_mobil_change_tab_markdown$date), max(dat_mobil_change_tab_markdown$date))
          ),
          shiny::tags$br(), shiny::tags$hr(),
          actionButton(inputId = "generate_Report", label = "generate Report")
        ),

<<<<<<< HEAD
        mainPanel(
          shiny::tableOutput(outputId = "tb3_table")
        )
      )
    )
  ) # Navbar Ende´
) # shinUi Ende
=======
# Markdown Tab ----#####################################################################
  tabPanel("Markdown",
    sidebarLayout(
      sidebarPanel(width = 4,
        shiny::selectizeInput(inputId = "t3_countries", label="Countries", multiple =TRUE, choices = unique(dat_mobil_change_tab_markdown$name)),
        shiny::selectizeInput(inputId = "t3_activity", label="Activity Type", multiple =TRUE, choices = unique(dat_mobil_change_tab_markdown$percent_change_type), selected=  unique(dat_mobil_change_tab_markdown$percent_change_type)),
        shiny::sliderInput(inputId = "t3_date", label= "Date",
                           min = min(dat_mobil_change_tab_markdown$date), 
                           max = max(dat_mobil_change_tab_markdown$date),
                           value = c(min(dat_mobil_change_tab_markdown$date) ,max(dat_mobil_change_tab_markdown$date))),
        shiny::tags$br(), shiny::tags$hr(),
        actionButton(inputId = "generate_Report", label = "generate Report")
        ), 
                                 
      mainPanel(
        shiny::tableOutput(outputId = "tb3_table")
        )
      )
    )
)
)
>>>>>>> 9d05bf718f6815431c15c0faf8ca0107796d2078
