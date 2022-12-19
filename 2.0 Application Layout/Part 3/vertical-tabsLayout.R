library(shiny)

ui <- fluidPage(
  titlePanel("vertical tabs layout"),
  navlistPanel(
    "Inputs",
    tabPanel("Sample size",
             numericInput('n',"sample size",value = 30)),
    "Outputs",
    tabPanel("BoxPlot",plotOutput("box")),
    tabPanel("Histogram",plotOutput("hist"))
  )
)

server <- function(input, output, session) {
  data <- reactive({
    rnorm(input$n)
  })
  
  output$hist <- renderPlot({
    hist(data(),main = "Histogram of data")
  })
  
  output$box <- renderPlot({
    boxplot(data(),main = "Box Plot of data")
  })
}

shinyApp(ui, server)