library(shiny)

# by default, when you change this file, you have to reload the app
# we can change this by using the auto reload option to improve our 
# development

# we have solved that

# another problem you will encounter is when uploading files.
# by default, shiny will only allow a maximum file of 5MB but you can change it as follows.

# the port for this app is 5562 but we can change it using the following options

# you can find more options in the help section.

# thanks for watching.

options(shiny.autoreload = TRUE, shiny.maxRequestSize = 10*1024^2,
        shiny.port=2000) # this changes maximum to 10MB

ui <- fluidPage(
  #title of the app
  titlePanel("Your title 4"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter Number:", value=30)
    ),
    # main
    mainPanel(
      # display to the user
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # the reactive data
  data <- reactive({
    rnorm(input$num)
  })
  
  # plot
  output$plot <- renderPlot({
    boxplot(data())
  })
}

shinyApp(ui, server)