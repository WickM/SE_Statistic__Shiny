
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & ... & ...
options(stringsAsFactors = FALSE)

library(shiny)
library(magrittr)

load("SE_Statistic_Shiy_App/data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE)

# Define UI for application that draws a histogram
shinyUI( navbarPage("SE Statistic Shiny APP",id = "nav_bar",
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
                                 sidebarPanel(width = 4,
                                              shiny::selectizeInput(inputId = "t3_countries", label="Airport", multiple =TRUE, choices = unique(flights$origin), selected=  unique(flights$origin)),
                                              shiny::selectizeInput(inputId = "carrier", label="Carrier", multiple =TRUE, choices = unique(flights$carrier), selected=  unique(flights$carrier)),
                                              shiny::sliderInput(inputId = "month", label= "Month",
                                                                 min = min(as.Date(flights$time_hour)), 
                                                                 max = max(as.Date(flights$time_hour)),
                                                                 value = c(min(as.Date(flights$time_hour)) ,max(as.Date(flights$time_hour))),
                                                                 timeFormat= "%m %y"),
                                              shiny::tags$br(), shiny::tags$hr(),
                                              actionButton(inputId = "generate_Report", label = "generate Report")
                                   
                                 ), 
                                 mainPanel(
                                   shiny::tableOutput(outputId = "table")
                                 )
                                 )
                             )
                             
)#Navbar Ende´
)#shinUi Ende
