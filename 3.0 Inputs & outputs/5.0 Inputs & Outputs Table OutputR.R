library(shiny)

# thanks for watching

ui <- fluidPage(
  titlePanel(h5("inputs & outputs: table output")),
  # app layout
  fluidRow(
    titlePanel("table"),
    #column(6, tableOutput("tab"))
    #column(6, tableOutput("sum"))
  ),
  fluidRow(
    titlePanel("data table"),
    column(10, dataTableOutput("tab2"))
  )
)

server <- function(input, output, session) {
  # table output
  output$tab <- renderTable({
    head(iris, 5)
  })
  
  # summary of the data
  # table output
  output$sum <- renderTable({
    summary(iris)
  })
  
  # data table output
  output$tab2 <- renderDataTable({
  iris
  })
}

shinyApp(ui, server)