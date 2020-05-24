library(shiny)

strReverse <- function(x)
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse="")


ui <- fluidPage(
  titlePanel("Output Demo"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("text", 
                label = h4("Text input"), 
                value = "Sample Text"),
      
      sliderInput("numbers", 
                  label = h4("Number range"),
                  min = 0, 
                  max = 100,
                  value = c(45,55)),
      
      dateRangeInput("dates", 
                     label = h4("Date range")),

    ),
    
    mainPanel(
      h4("Text Value:"),
      textOutput("text"),
      
      h4("Reversed Text Value:"),
      textOutput("textReversed"),
      
      br(),
      
      h4("Number Sequence"),
      textOutput("numbers"),
      
      br(),
      
      h4("Date:"),
      textOutput("dates")
      
    )
  )
)

server <- function(input, output) {
  output$text <- renderText({ input$text })
  
  output$textReversed <- renderText({ strReverse(input$text) })
  
  output$numbers <- renderText({ input$numbers[1]:input$numbers[2] })
  
  output$dates <- renderText({ 
    paste("Date from", input$dates[1], "to", input$dates[2], "selected", sep = " ")
  })
}

shinyApp(ui, server)