library(shiny)

# changing the header should not affect the histogram.
# lets fix that

# let us style the header

# pros:
## it is easy to implement on very small projects.

# cons:
## not appropriate for large projects.

# thanks for watching.

ui <- fluidPage(
  # title of the app
  # method 1 for styling elements
  # headerPanel(
   # h1("Inline CSS", style="color:green;text-align:center;font-size:30px;
    #   font-family:Ink Free")
  #),
  # method 2
  tags$head(
    tags$style(
      HTML("
          body {
            font-family: Ink Free;
            border: 2px solid red;
            margin: 6px;
          }
      
           h1 {
             color:green;
             text-align:center;
             font-size:30px;
             font-family:Ink Free;
             border-style: double;
           }
           ")
    )
  ),
  h1("Inline CSS"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter Num:", value = 100),
      # header input
      # allow use to enter the header of the plot
      textInput("header", "Header:", placeholder = "Histogram",
                value = "Histogram")
    ),
    # main panel
    mainPanel(
      # display the plot to the user
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # make data reactive
  data <- reactive({
    rnorm(input$num)
  })
  # plot output
  output$plot <- renderPlot({
    hist(data(), main=input$header)
  })
}

shinyApp(ui, server)