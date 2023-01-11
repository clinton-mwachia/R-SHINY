library(shiny)

# lets add our styles

# we will create a folder named www, this is where we will add all our
# resources such as css, javascript and images.

# lets load the css to our app

## pros: best for both small and large projects.
## cons: flipping between files to confirm classes and ids.

# THANKS FOR WATCHING.

ui <- fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="styles.css")
  ),
  h1("External CSS"),
  # app layout
  sidebarLayout(
    # sidebar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter Num:", value = 100),
      # header input
      textInput("header", "Header:", placeholder = "Histogram",
                value = "Histogram")
    ),
    # main panel
    mainPanel(
      # display plot to the user
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # the data
  data <- reactive({
    rnorm(input$num)
  })
  
  # the plot
  output$plot <- renderPlot({
    hist(data(),main=input$header)
  })
}

shinyApp(ui, server)