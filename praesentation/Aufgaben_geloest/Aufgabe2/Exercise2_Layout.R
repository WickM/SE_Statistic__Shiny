library(shiny)

linkToImage <- "https://upload.wikimedia.org/wikipedia/commons/8/80/OldFaithful1948.jpg"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 2",
  tabPanel("Side Bar Layout",
           sidebarLayout(
             position = "right",
             sidebarPanel(
               strong("This is bold sidebar panel text")
             ),
             mainPanel(
               h1("This is a header in the main panel")    
             )
           )
  ),
  tabPanel("Image",
           img(src = linkToImage, width = "50%")
  ),
  tabPanel("Links",
           splitLayout(
             cellWidths = c("75%", "25%"),
             HTML("<a href=\"https://shiny.rstudio.com/\">R Shiny Homepage</a>"),
             a("R Shiny Homepage", href="https://shiny.rstudio.com/")
           )))

# ~+~+~+ TIPPS +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Layout objects needed:
#   splitLayout() and sidebarLayout() with mainPanel() and sidebarPanel()
#
# Image in HTML: <img src="picture_URL" width="64" height="128">
# Linking to R Shiny home page in HTML:  
#   <a href="https://shiny.rstudio.com/"> R Shiny Homepage </a>
#
# Do not forgett to escape " with \" in R!
#
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+


server <- function(input, output) {
  # for this layout demo no actual functions are needed
}

# Run the app ----
shinyApp(ui, server)