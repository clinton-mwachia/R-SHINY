library(shiny)

# thanks for watching, see you in part 2 where we discuss in detail

ui <- fluidPage(
  titlePanel("Modal Dialog Part I"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter Number:", value = 30),
      # action button
      # lets add an icon, font awesome icons
      actionButton("action", "Click Me", icon('computer-mouse'))
    ),
    # main
    mainPanel(
      # display to the user
      plotOutput("box")
    )
  )
)

server <- function(input, output, session) {
  # lets display modal
  # we will observer the event of the action button click
  observeEvent(input$action, {
    showModal(modalDialog(
      title = "Modal Dialog",
      "This is a basic modal dialog",
      size = "s",
      easyClose = TRUE # WE CAN CLOSEMODAL BY CLICKI OUTSIDE
    ))
  })
  # the data
  data <- reactive({
    rnorm(input$num)
  })
  
  # box plot
  output$box <- renderPlot({
    boxplot(data())
  })
}

shinyApp(ui, server)