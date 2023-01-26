library(shiny)

options(shiny.autoreload=TRUE)

# lets call our functions in our app
source("helpers/Utils.R")

# it's a simple app

# we are going to separate this app into simple components

# lets create input function

# lets right a function for box plot

# let's add a custom value box
# let's add styling

# thanks for watching

ui <- fluidPage(
  includeCSS("www/styles.css"),
  #title of the app
  titlePanel("Your title"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # numeric input
      SelectInput("num", "Num 1:", 20),
      SelectInput("num2", "Num 2:", 40)
    ),
    # main
    mainPanel(
      # display to the user
      plotOutput("plot"),
      # align them horizontally
      div(
        class="container",
        value_box(
          class="test",
          style="display:flex;align-items:center;justify-content:center",
          value=200, title="Data One"
        ),
        value_box(
          class="test",
          style="display:flex;align-items:center;justify-content:center;
        background-color: grey",
          value=400, title="Data Two"
        ),
        value_box(
          class="test",
          style="display:flex;align-items:center;justify-content:center;
        background-color: red",
          value=400, title="Data Two"
        )
      )
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
    box_plot(data(), title = "data 1")
  })
}

shinyApp(ui, server)