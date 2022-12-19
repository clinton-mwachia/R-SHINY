library(shiny)

# thanks for watching, see you in the next video.

ui <- navbarPage(
  title = "Navbar Layout",
  tabPanel("sample size",
           numericInput("n", "sample size", value = 30)),
  tabPanel("Histogram", plotOutput("hist")),
  tabPanel("Boxplot", plotOutput("box")),
  navbarMenu("Graph",
             tabPanel("Graph 1", "graph 1"),
             tabPanel("Graph 2", "graph 2"))
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