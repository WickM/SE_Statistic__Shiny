library(shiny)

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 2",
  tabPanel("Plot",
           sidebarLayout(
             sidebarPanel("This is the side bar panel"),
             #sidebarPanel(img(src=CoronaVirusImageLink, width = "100%")),
             mainPanel("This is the main panel")
           )
  ),
  tabPanel("Leaflet"),
  tabPanel("Markdown")
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