library(shiny)

ui <- fluidPage(
  titlePanel("Input Demo 2"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("buckets", 
                  label = h4("Aprox. Number of Buckets"),
                  min = 1, 
                  max = 25,
                  step = 3,
                  value = 0,
                  animate = animationOptions(interval = 1000)),
      
      numericInput("probability", 
                   label = h4("Probability"), 
                   value = 0.5, 
                   min = 0, 
                   max = 1, 
                   step = 0.01)
      ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    hist(rbinom(1000, 100, input$probability), 
         breaks = input$buckets, 
         col = "green", 
         border = "black",
         xlim = c(0,100),
         xlab = "Value",
         main = "Binomial Distribution"
    )})}

shinyApp(ui, server)
