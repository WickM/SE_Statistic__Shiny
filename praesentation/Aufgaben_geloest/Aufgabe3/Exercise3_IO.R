library(shiny)

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 2",
  tabPanel("Plot",
           sidebarLayout(
             # Data selection in the sidebar below
             sidebarPanel(
               selectInput("country", 
                           label = "Please select Country",
                           choices = c("Austria", "Sweden", "Germany", "Italy", "Japan")),
               checkboxGroupInput("dataset",
                                  label = "Source", 
                                  choices = c("Apple","Google"), 
                                  selected = c("Apple","Google")),
               textInput("text", 
                         label = "Enter Title", 
                         value = "Title"),
               br(),
               
               img(src=CoronaVirusImageLink, width = "100%")
             ),
             
             # Output in the main panel below
             mainPanel(
               h2(textOutput("text")),
               tableOutput("table"),
               plotOutput("plot")
             )
           )  
        ),
  tabPanel("Leaflet"),
  tabPanel("Markdown")
)

server <- function(input, output) {
  output$text <- renderText(input$text)
  
  # TODO insert code for other output
}

# ~+~+~+ TIPP +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Input functions needed in the side panel:
#   checkboxGroupInput(), textInput(), selectInput()
#
# Output functions needed in the main panel:
#   textOutput(), tableOutput(), plotOutput()
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+

# Run the app ----
shinyApp(ui, server)