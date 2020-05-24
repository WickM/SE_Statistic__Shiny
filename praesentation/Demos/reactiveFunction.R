library(shiny)


ui <- fluidPage(
  titlePanel("Reactiv Function Demo"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxInput(inputId = "react", label = "reactiveFunction", value = FALSE),
      sliderInput("numbers1", 
                  label = h4("Number range1"),
                  min = 0, 
                  max = 100,
                  value = c(45,55)),
      
      checkboxInput(inputId = "obs", label = "Observer", value = FALSE),
      sliderInput("numbers2", 
                  label = h4("Number range2"),
                  min = 0, 
                  max = 100,
                  value = c(45,55)),
      
      checkboxInput(inputId = "eventreact", label = "EventReactive", value = FALSE),
      sliderInput("numbers3", 
                  label = h4("Number range3"),
                  min = 0, 
                  max = 100,
                  value = c(45,55)),
      
      

    ),
    
    mainPanel(
      h4("SUM Reactive Function"),
      textOutput("sum1"),
      
      h4("SUM observer Function"),
      textOutput("sum2"),
      
      br(),
      
      h4("SUM Event Reactive Function"),
      textOutput("sum3"),
    )
  )
)

server <- function(input, output) {
  
  #Reactive Function
  #A Reactive Function returns a value
  sum_reactive <- reactive({
    if (input$react) {
      value <- sum(input$numbers1, input$numbers2, input$numbers3)
      return(value)
    }
  })
  output$sum1 <- renderText(as.character(sum_reactive() ))

  #Observe Function
  #An Observe Function doesn't return a value. 
  #It's beeing used for side effects
  observe({
    if (input$obs) {
      value <- sum(input$numbers1, input$numbers2, input$numbers3)
      output$sum2 <- renderText(as.character(value))
    }
  })

  
  #Event Reactive Function
  #A Reactive Function returns a value
  #"Listens" only to one input 
  sum_reactiveEvent <- eventReactive(input$eventreact, {
    if (input$eventreact) {
      value <- sum(input$numbers1, input$numbers2, input$numbers3)
      return(value)
    }
  })
  output$sum3 <- renderText(as.character(sum_reactiveEvent() ))
  
  
}
shinyApp(ui, server)