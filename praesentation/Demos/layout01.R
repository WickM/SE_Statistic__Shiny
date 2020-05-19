library(shiny)

# Start of UI code ----
ui <- fluidPage(

  titlePanel("Layout Demo 1"),
  
  hr(),
  
  splitLayout(
    "Some text for column 1",
    "Some text for column 2",
    "Some text for column 3"
  ),
  
  hr(),
  
  splitLayout(
    "Some text for column 1",
    "Some text for column 2",
    "Some text for column 3",
    "Some text for column 4",
    "Some text for column 5"
  ),

  hr(),
  
  verticalLayout(
    "Text for vertical layout",
    "Another text for vertical layout",
    "I am filler text"
  ),
  
  hr(),
  
  sidebarLayout(
    sidebarPanel("This is the sidebar panel"),
    mainPanel("This is the main panel"),
  ),
  
)
# End of UI code----

# Start of server code----
server <- function(input, output) {
  # for this layout demo no actual functions are needed
}
# End of server code----

# Run the app ----
shinyApp(ui, server)