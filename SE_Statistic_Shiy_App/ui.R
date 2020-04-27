
#'Titel: Se Statistic Shiny App
#'date 03.04.2020
#'UI File 
#'Manuel Wick-Eckl & Florian Feik & ...

options(stringsAsFactors = FALSE)

library(shiny)
library(leaflet)
library(magrittr)

load("data/aufb_covid_data.RData")

dat_mobil_change <- dat_apple_countries %>% 
  dplyr::mutate(date = as.Date(date)) %>% 
  dplyr::bind_rows(., dat_google_countries, .id = "dataset") %>% 
  dplyr::mutate(dataset = dplyr::recode(dataset, '1' = "Apple", '2' = "Google")) %>% 
  dplyr::filter(is.na(sub_region_1) == TRUE)

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
