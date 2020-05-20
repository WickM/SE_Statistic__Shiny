library(shiny)

CoronaVirusImageLink <- "https://upload.wikimedia.org/wikipedia/commons/8/82/SARS-CoV-2_without_background.png"

#### Exercise starts here
ui <- ........(
  "Exercise 2",
  .......("......",
           ..........(
             .....Panel(...(src = ........, width = "....")),
             .....Panel("...........")
           )
  ),
  .......("......"),
  .......("......")
  )

# ~+~+~+ TIPPS +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Layout objects needed:
#  navbarPage() with navbarPage()
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