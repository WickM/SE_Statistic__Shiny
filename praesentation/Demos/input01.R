library(shiny)

ui <- fluidPage(
  titlePanel("Input Demo 1"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selectBar", 
                  label = h4("Select Bar Color"), 
                  choices = list("yellow", "red", "green", "blue", "black", "white"), 
                  selected = "green"),
      
      radioButtons("selectBorder", 
                   label = h4("Select Border Color"), 
                   choices = list("yellow", "red", "green", "blue", "black", "white"), 
                   selected = "blue",
                   inline = TRUE),
      
      sliderInput("range", 
                  label = h4("Select Display Range"),
                  min = 1, 
                  max = 6,
                  step = 0.5,
                  value = c(1,6)),
      
      numericInput("buckets",
                   label = h4("Number of Histogram Buckets"),
                   min = 5,
                   max = 65,
                   value = 5,
                   step = 20),
    ),

    mainPanel(
      plotOutput("plot")
    )
  )
)


server <- function(input, output) {
  output$plot <- renderPlot({
    hist(faithful$eruptions, 
         breaks = input$buckets - 1, 
         col = input$selectBar, 
         border = input$selectBorder,
         xlab = "Category",
         xlim = input$range,
         main = "Demo Histogram"
  )})} 

shinyApp(ui, server)
