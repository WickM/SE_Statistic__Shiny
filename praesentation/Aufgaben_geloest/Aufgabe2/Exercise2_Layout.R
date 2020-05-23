library(shiny)

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 2",
  tabPanel("Plot",
           sidebarLayout(
             sidebarPanel(img(src=CoronaVirusImageLink, width = "100%")),
             mainPanel(
                "This is a main panel"
          #     HTML(paste(
          #       "<img src=\"", 
          #       CoronaVirusImageLink ,
          #       "\" width=\"100%\">"))               
               )
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
# Inserting Image using HTML: <img src="picture_URL" width="100%">
# When using HTML() " have to be escaped using \"
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+


server <- function(input, output) {
  # for this layout demo no actual functions are needed
}

# Run the app ----
shinyApp(ui, server)