library(shiny)

linkToLogo <- "https://upload.wikimedia.org/wikipedia/commons/d/d0/RStudio_logo_flat.svg"

shinyUI(navbarPage(
    "Exercise 2",
    tabPanel("Side Bar Layout",
        # code for "Side Bar Layout" tab here (aprox. 6 lines of code)
        
        
        
        
        
    ),
    tabPanel("Image",
       # code for image tab here (aprox. 1 line of code)     
    ),
    tabPanel("Links",
       # code for links tab here (aprox. 4 lines of code)
       
       
       
    )))
# ~+~+~+ TIPPS +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Layout objects needed:
#   splitLayout()and sidebarLayout() with mainPanel() and sidebarPanel()
#
# Image in HTML: <img src="picture URL" width="64" height="128">
# Linking to R Shiny home page in HTML:  
#   <a href="https://shiny.rstudio.com/"> R Shiny Homepage </a>
#
# Do not forgett to escape " with \" in R!
#
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+