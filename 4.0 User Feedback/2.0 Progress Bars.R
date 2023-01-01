library(shiny)
library(waiter)

# thanks for watching

ui <- fluidPage(
  titlePanel(h5("Progress bar")), # app title
  # app layout
  sidebarLayout(
    # sidebar
    sidebarPanel(
      # file upload
      # it has a default progress bar
      fileInput("file", "Upload file", multiple = TRUE),
      # select data
      selectInput("data", "Select Data:", 
                  choices = c("iris","mtcars"))
    ),
    # main panel
    mainPanel(
      # display the histogram
      plotOutput("plot2")
    )
  )
)

server <- function(input, output, session) {
  # get the data
  data <- reactive({
    get(input$data)
  })
  # plot the data
  # lets add progress bar
  output$plot <- renderPlot({
    withProgress(message = "Rendering Plot...", value = 0, {
      for (i in 1:10) {
        incProgress(1/10)
        Sys.sleep(0.2)
      }
    })
    hist(data()[,1]) # plot a histogram of the first column
  })
  
  # we can use another package called waiter
  # it can handle complex progress bars
  # install.packages(waiter, dependencies=T)
  # define the waitress
  waiter <- Waitress$new("#plot2")
  # rendering the plot
  output$plot2 <- renderPlot({
    for (i in 1:10) {
      waiter$inc(10) # increment by 10%
      Sys.sleep(0.2)
    }
    hist(data()[,1])
    waiter$close()
  }) 
}

shinyApp(ui, server)