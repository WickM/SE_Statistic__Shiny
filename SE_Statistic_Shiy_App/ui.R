
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & Florian Feik & ...

options(stringsAsFactors = FALSE)

library(shiny)
library(leaflet)
library(magrittr)
library(magrittr)
install.packages("epitools")
library(epitools)

load("data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE) %>% 
  dplyr::mutate(percent_change_type = stringr::str_remove(percent_change_type, "_percent_change_from_baseline"))




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
      
      h3("COVID-19 induced reduction in population mobility"),
      
      selectInput("t2_mapType",
                  label = "TESTEST",
                  choices = c(      #TODO: RENAME
                  "driving"="driving_percent_change_from_baseline",
                  "walking"="walking_percent_change_from_baseline",
                  "transit"="transit_percent_change_from_baseline",
                  "retail"="retail_and_recreation_percent_change_from_baseline",
                  "grocery"="grocery_and_pharmacy_percent_change_from_baseline",
                  "parks"="parks_percent_change_from_baseline",
                  "stations"="transit_stations_percent_change_from_baseline",
                  "workplaces"="workplaces_percent_change_from_baseline",    
                  "residential"="residential_percent_change_from_baseline"),
                  selected = "walking_percent_change_from_baseline"),

      sliderInput("t2_date",
                  label = "Date input",
                  min = as.Date(min(dat_mobil_change$date)),
                  max = as.Date(max(dat_mobil_change$date)),  
                  value = as.Date(min(dat_mobil_change$date)),
                  timeFormat = "%d %b",
                  animate=animationOptions(interval = 500, loop = FALSE)
      ),),
    
    mainPanel(
      leafletOutput("t2_map"))
)),


#Tab3----#####################################################################
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
                                 sidebarPanel(width = 4,
                                              shiny::selectizeInput(inputId = "t3_countries", label="Countries", multiple =TRUE, choices = unique(dat_mobil_change$name)),
                                              shiny::selectizeInput(inputId = "t3_activity", label="Activity Type", multiple =TRUE, choices = unique(dat_mobil_change$percent_change_type), selected=  unique(dat_mobil_change$percent_change_type)),
                                              shiny::sliderInput(inputId = "t3_date", label= "Date",
                                                                 min = min(dat_mobil_change$date), 
                                                                 max = max(dat_mobil_change$date),
                                                                 value = c(min(dat_mobil_change$date) ,max(dat_mobil_change$date))),
                                              shiny::tags$br(), shiny::tags$hr(),
                                              actionButton(inputId = "generate_Report", label = "generate Report")
                                   
                                 ), 
                                 mainPanel(
                                     
                                 )
                               sidebarPanel(
                                 
                               ),
                               mainPanel(
                                 
                               )
                             )
                    )
                    
)#Navbar Ende´
)#shinUi Ende
