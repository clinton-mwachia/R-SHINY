library(shiny)

# THANKS FOR WATCHING

ui <- fluidPage(
  titlePanel(h5("notifications")),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # select data
      selectInput("data", "Select data:",
                  choices = ls('package:datasets'))
    ),
    # main panel
    mainPanel(
      # display to user
      tableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  # get the data from input
  data <- reactive({
    # you can validate the data here and show error in case of one.
    get(input$data)
  })
  
  # handle the data
  output$table <- renderTable({
    withProgress(message = "Rendering table", value = 0, {
      for (i in 1:10) {
        incProgress(1/10)
        Sys.sleep(0.2)
      }
    })
    # lets add notification when done
    showNotification("message",type = "message") # success
    showNotification("warning",type = "warning")
    showNotification("error",type = "error")
    showNotification("default",type = "default")
    head(data())
  })
}

shinyApp(ui, server)