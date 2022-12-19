library(shiny)

# that's it for sidebar layout.
# lets create the grid layout

ui <- fluidPage(
  titlePanel("sidebar layout"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "n", label = "Sample size",value = 30)),
    mainPanel(plotOutput("hist"))
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    hist(rnorm(input$n),main="Histogram of data")
  })
}

shinyApp(ui, server)