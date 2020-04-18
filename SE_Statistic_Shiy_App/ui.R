
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & ... & ...

library(shiny)

# Define UI for application that draws a histogram
shinyUI( navbarPage("SE Statistic Shiny APP",
#Tab1----#####################################################################
                        tabPanel("Plot",
                             sidebarLayout(
                                 
                                 sidebarPanel(
                                    #Ab hier Code fuer Sidebar
                                   position = "right",
                                   sidebarPanel(h3("Inputs for plot"), 
                                                selectInput("treat", "1. Select treatment", choices = c("without ozone"="control","with ozone"="ozone"), selected = "ozone"),
                                                br(),
                                                textInput("text", "4. Enter some text to be displayed", "")),
                                     
                                  ),
                                 mainPanel(
                                    #Ab hier Code fuer das Main Panel
                                   plotlyOutput("plot"),
                                   tableOutput("table"),
                                   textOutput("text")
                                     
                                 )
                             )),

#Tab2----#####################################################################

                    tabPanel("Leafleat",
                             sidebarLayout(
                                 sidebarPanel(
                                    #Ab hier Code fuer Sidebar
                                     
                                 ),
                                 mainPanel(
                                    #Ab hier Code fuer Main
                                    
                                 )
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
