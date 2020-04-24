
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & ... & ...

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage("SE Statistic Shiny APP",
                    #Tab1----#####################################################################
                    tabPanel("Plot",
                             sidebarLayout(
                               sidebarPanel(
                                 #Ab hier Code fuer Sidebar
                                 actionButton("exclude_toggle", "Toggle points"),
                                 actionButton("exclude_reset", "Reset"),
                                 selectInput("Region", "Please select Region",
                                             choices=c("Styria","Salzburg")),
                                 textInput("text", "Enter some text to be displayed", "")
                                 
                               ),
                             
                             
                             mainPanel(
                               h3(textOutput("text"), align = "center"),
                               tableOutput("table"),
                               fluidPage(
                      fluidRow(
                        column(width = 12,
                               plotOutput("plot1", height = 350,
                                          click = "plot1_click",
                                          brush = brushOpts(
                                            id = "plot1_brush"
                                          ),
                               ),
                               #actionButton("exclude_toggle", "Toggle points"),
                              # actionButton("exclude_reset", "Reset")
                              
                        )
                             ))))),
                    
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
