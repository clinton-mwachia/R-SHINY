library(shiny)

# lets copy the data from previous code.
# the code is in the link below

# thanks for watching i will see you in the next video.

ui <- fluidPage(
  titlePanel("horizontal tabs layout"),
  tabsetPanel(
    tabPanel("sample size", 
             numericInput("n", "samplesize",value = 30)),
    tabPanel("boxplot", plotOutput("box")),
    tabPanel("histogram", plotOutput("hist"))
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