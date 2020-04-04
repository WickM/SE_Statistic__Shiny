
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
                                     
                                     
                                  ),
                                 mainPanel(
                                    #Ab hier Code fuer das Main Panel
                                
                                     
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
