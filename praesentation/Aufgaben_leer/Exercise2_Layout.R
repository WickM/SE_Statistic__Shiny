library(shiny)

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- ........(
  "Exercise 2",
  .......("......",
           ..........(
             .....Panel("..........."),
             .....Panel("...........")
           )
  ),
  .......("......"),
  .......("......")
  )

# ~+~+~+ TIPPS +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Layout objects needed:
#  navbarPage() with tabPanel()
#  sidebarLayout() with mainPanel() and sidebarPanel()
#
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+

server <- function(input, output) {
  # for this layout demo no server functions are needed
}

# Run the app ----
shinyApp(ui, server)