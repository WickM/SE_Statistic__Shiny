library(shiny)

linkToImage <- "https://upload.wikimedia.org/wikipedia/commons/8/80/OldFaithful1948.jpg"

#### Exercise starts here
ui <- navbarPage(
  "Exercise 2",
  tabPanel("...",
           sidebarLayout(
             # code for "Side Bar Layout" tab here (aprox. 6 lines of code)
             
             
             
             
           )
  ),
  tabPanel("...",
           # code for image tab here (aprox. 1 line of code)     
  ),
  tabPanel("...",
           splitLayout(
             # code for links tab here (aprox. 3 lines of code)
             
             
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