library(shiny)

# lets add some sidebar layout

# lets use some real data

# thanks fro watching and see you in the next video

ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins","Bins", min = 1,max = 50, value = 30)
    ),
    mainPanel(
      # render the table
      plotOutput("hist")
    )
  ),
 
)

server <- function(input, output, session) {
  # output logic
  output$hist <- renderPlot({
    # get the waiting time to next eruption
    x <- faithful[,2]
    # lets make it respond to slider input
    bins <- seq(min(x), max(x), length.out=input$bins+1)
    hist(x, breaks = bins, col="gray", main="histogram")
  })
}

shinyApp(ui, server)