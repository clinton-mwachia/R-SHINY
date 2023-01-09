library(shiny)
library(bslib)

# lets add dark mode

# you can also add more options as we have done in previous videos

# thanks for watching.

light <- bs_theme()
dark <- bs_theme(bg = "black", fg="white", primary = "green")

ui <- fluidPage(
  theme = light,
  titlePanel("Dark mode"),
  # app layout
  sidebarLayout(
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter num:", value = 30),
      checkboxInput("Dark","Dark")
    ),
    mainPanel(
      # display plot to user
      fluidRow(
        column(6, plotOutput("plot")),
        column(6, tableOutput("table"))
      )
    )
  )
)

server <- function(input, output, session) {
  # handle light and dark mode
  observe(session$setCurrentTheme(
    if (isTRUE(input$Dark)) dark else light
  ))
  # plot histogram
  output$plot <- renderPlot({
    hist(rnorm(input$num))
  })
  
  # show table of data
  output$table <- renderTable({
    iris
  })
}

shinyApp(ui, server)