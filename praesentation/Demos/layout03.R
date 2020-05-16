library(shiny)

text <- "This is a very long text block in the main panel. It occupies the full width of our demo app."
mainText <- text
for (n in 1:10){
  mainText <- paste(mainText, text)
}


# Start of UI code ----
ui <- navbarPage("Layout Demo 3",
     tabPanel(
       "Side Bar Layout",
        sidebarLayout(
          # position = "right",
          sidebarPanel("This is the sidebar panel"),
          mainPanel(mainText)
        )
     ),
     tabPanel(
       "Split Layouts",
        splitLayout(
          "Some text for column 1",
          "Some text for column 2",
          "Some text for column 3"
        )
     ),
     tabPanel(
       "Picture",
       img(src="https://upload.wikimedia.org/wikipedia/commons/d/d0/RStudio_logo_flat.svg", width="100%")
    )
  )
# End of UI code----

server <- function(input, output) {
  # for this layout demo no actual functions are needed
}

# Run the app ----
shinyApp(ui = ui, server = server)