library(shiny)

# thanks for watching and see you in the next video.
# all the code will be available in github link in the description

ui <- fluidPage(
  titlePanel("Fluid Grid Layout"),
  fluidRow(
    column(3, 
           numericInput(inputId = "n", label = "Sample size",value = 30)),
    column(6, plotOutput("hist")),
    column(2, h4("another column"))
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    hist(rnorm(input$n),main="Histogram of data")
  })
}

shinyApp(ui, server)