
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & ... & ...
options(stringsAsFactors = FALSE)

library(shiny)
library(magrittr)

load("data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE) %>% 
  dplyr::mutate(percent_change_type = stringr::str_remove(percent_change_type, "_percent_change_from_baseline"))

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
                                              shiny::selectizeInput(inputId = "t3_countries", label="Countries", multiple =TRUE, choices = unique(dat_mobil_change$name), selected=  unique(dat_mobil_change$name)),
                                              shiny::selectizeInput(inputId = "t3_activity", label="Activity Type", multiple =TRUE, choices = unique(dat_mobil_change$percent_change_type), selected=  unique(dat_mobil_change$percent_change_type)),
                                              shiny::sliderInput(inputId = "t3_date", label= "Date",
                                                                 min = min(dat_mobil_change$date), 
                                                                 max = max(dat_mobil_change$date),
                                                                 value = c(min(dat_mobil_change$date) ,max(dat_mobil_change$date))),
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
