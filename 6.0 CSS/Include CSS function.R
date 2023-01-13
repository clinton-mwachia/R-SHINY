library(shiny)

# i am using the same app from previous videos.
# i am coding it a fresh so that incase someone is only intrested
# in this part, they do not have to re-watch previous video.

# lets add our css

# we will use that css in our app

# so that method 2 for getting your external css into the app

# thanks for watching.

ui <- fluidPage(
  includeCSS("www/styles.css"),
  h1("External CSS Part II"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter num:", value = 100),
      # header input
      textInput("header","Header:", placeholder = "Histogram",
                value = "Histogram")
    ),
    # main
    mainPanel(
      # display plot to the user
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # the reactive data
  data <- reactive({
    rnorm(input$num)
  })
  # the plot
  output$plot <- renderPlot({
    hist(data(), main = input$header)
  })
}

shinyApp(ui, server)