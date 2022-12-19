library(shiny)

# lets add a box plot

#next: horizontal tabs layout

ui <- fixedPage(
  titlePanel("fixed grid layout"),
  fixedRow(
    column(2, 
           numericInput("n", "samplesize",value = 30)),
    column(12,
           fixedRow(
             column(6, plotOutput("hist")),
             column(6, plotOutput("box"))
           ))
  )
)

server <- function(input, output, session) {
  # let us extract data into a single variable
  data <- reactive({
    rnorm(input$n)
  })
  # histogram
  output$hist <- renderPlot({
    hist(data(), main="Histogram of data")
  })
  # box plot
  output$box <- renderPlot({
    boxplot(data(), main="Box plot of data")
  })
}

shinyApp(ui, server)