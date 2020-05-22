library(shiny)

# Start of UI code ----
ui <- fluidPage(

  titlePanel("Layout Demo 2"),
  
  sidebarLayout(
    position = "right",
    sidebarPanel("This is the sidebar panel"),
    mainPanel(
      splitLayout(
        "Some text for column 1",
        "Some text for column 2",
        "Some text for column 3"
      ),
      
      hr(),
      
      splitLayout(
        cellWidths = c("25%", "50%", "25%"), 
        "Some text for column 1",
        "Some text for column 2",
        "Some text for column 3"
      ),
      
      br(),
      br(),
      br(),
      
      "This is a very long text block below the split layout. It occupies the full width of our demo app. 
       This is a very long text block below the split layout. It occupies the full width of our demo app.
       This is a very long text block below the split layout. It occupies the full width of our demo app.
       This is a very long text block below the split layout. It occupies the full width of our demo app.
       This is a very long text block below the split layout. It occupies the full width of our demo app. 
       This is a very long text block below the split layout. It occupies the full width of our demo app.
       This is a very long text block below the split layout. It occupies the full width of our demo app.
       This is a very long text block below the split layout. It occupies the full width of our demo app.",

      br(),
      br(),
      br(),
      
      sidebarLayout(
        sidebarPanel("This is the sidebar panel in the main panel"),
        mainPanel("This is the main panel in the outer main panel")
      )
    )
  )
)
# End of UI code----

server <- function(input, output) {
  # for this layout demo no actual functions are needed
}

# Run the app ----
shinyApp(ui, server)