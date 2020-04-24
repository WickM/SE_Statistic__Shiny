
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & ... & ...

options(stringsAsFactors = FALSE)

library(shiny)
library(magrittr)
install.packages("epitools")
library(epitools)


#load("SE_Statistic_Shiy_App/data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE)


dat_mobil_change$juliandate <-julian(dat_mobil_change$date, origin = as.Date("2020-01-01"),)
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "driving_percent_change_from_baseline"] <- "driving"
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "walking_percent_change_from_baseline"] <- "walking"
dat_mobil_change$percent_change_type[dat_mobil_change$percent_change_type == "residential_percent_change_from_baseline"] <- "stay at home"
colnames(dat_mobil_change)[7] <- "Movement_type"



# Define UI for application that draws a histogram
shinyUI(navbarPage("SE Statistic Shiny APP",
                    #Tab1----#####################################################################
                    tabPanel("Plot",
                             sidebarLayout(
                               sidebarPanel(
                                 #Ab hier Code fuer Sidebar
                                 
                                 selectInput("name", "Please select Country",
                                             choices=c("Austria","Sweden", "Germany", "Italy", "Japan")),
                                 checkboxGroupInput("dataset","Source", choices=c("Apple","Google"), selected = c("Apple","Google")),
                                 textInput("text", "Enter some text to be displayed", "")
                                 
                               ),
                             
                             
                             mainPanel(
                               h3(textOutput("text"),width = 6, align = "center"),
                               tableOutput("table"),width = 6, align = "Center",
                               fluidPage(
                      fluidRow(
                        column(width = 12, align = "Center",
                               plotOutput("plot1", height = 350
                                         
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
