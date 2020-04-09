
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & Florian Feik & ...

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI( navbarPage("SE Statistic Shiny APP",
#Tab1----#####################################################################
                        tabPanel("Plot",
                             sidebarLayout(
                                 
                                 sidebarPanel(
                                    #Ab hier Code fuer Sidebar
                                     
                                     
                                  ),
                                 mainPanel(
                                    #Ab hier Code fuer das Main Panel
                                
                                     
                                 )
                             )),

#Tab2----#####################################################################

tabPanel("Leaflet",
  sidebarLayout(
    
    sidebarPanel(
      
      h3("Coronavirus COVID-19 Global Cases"),
      
      selectInput("t2_mapType",
                  label = "Choose a metic to display",
                  choices = c("Confirmed Cases", "Confirmed Deaths", "Recovered Cases"),
                  selected = "Confirmed Cases"),

      sliderInput("t2_date",
                  label = "Date input",
                  min = as.Date("2020-01-22"),
                  max = as.Date("2020-04-08"),    #TODO: automatically check for last entry
                  value = as.Date("2020-04-08"),
                  timeFormat = "%d %b",
                  animate=animationOptions(interval = 500, loop = FALSE)
      ),
      
      helpText("COVID-19 Data provided by the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE)."),
      helpText("Source:"),
      tags$a(href="https://github.com/CSSEGISandData/COVID-19","GitHub Repository")

      
      ),
    
    mainPanel(
      leafletOutput("t2_map"))
)),


#Tab3----#####################################################################
                    tabPanel("Markdown",
                             sidebarLayout(
                                 sidebarPanel(
                                     
                                 ),
                                 mainPanel(
                                     
                                 )
                             )
                             )

)#Navbar Ende´
)#shinUi Ende
