library(shiny)
data("faithful")

# The old faithful data frame contains 272 observations of eruptions 
# of the Old Faithfull geyser on 2 variables.
#
# faithful$eruptions:  Eruption time [minutes]
# faithful$waiting:    Waiting time to next eruption [minutes]


ui <- fluidPage(
  
  titlePanel("Old Faithfull Demo"),

  sidebarLayout(
    sidebarPanel(
      
      selectInput("color", 
                  label = h4("Select Color:"), 
                  choices = list("yellow", "red", "green", "blue", "black", "white"), 
                  selected = "green"),
      
      # Input: Slider for the number of bins ----
      sliderInput("bins",
                  label = "Number of bins:",
                  min = 10,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Server logic
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    hist(faithful$eruptions, 
         breaks = input$bins, 
         col = input$color, 
         border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Eruption time")
    
  })}
# Complete app with UI and server components
shinyApp(ui, server)
