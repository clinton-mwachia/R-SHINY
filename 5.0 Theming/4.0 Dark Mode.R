library(shiny)
library(bslib)

# lets add dark mode to the app

# you can try customizing the themes and plots

# thanks for watching.

light <- bs_theme() # default theming
dark <- bs_theme(bg = "black", fg = "white", primary = "green")

ui <- fluidPage(
  theme = light,
  titlePanel("Theming - Dark Mode"),
  # APP LAYOUT
  sidebarLayout(
    # side bar
    sidebarPanel(
      #numeric input
      numericInput("num", "Enter Number:", value = 30),
      # dark mode toggler
      checkboxInput("Dark_mode","Dark_mode")
    ),
    mainPanel(
     fluidRow(
       # display plot to user
       column(6, plotOutput("plot")),
       # display table
       column(6, tableOutput("table"))
     )
    )
  )
)

server <- function(input, output, session) {
  # handle light and dark mode
  observe(session$setCurrentTheme(
    if (isTRUE(input$Dark_mode)) dark else light
  ))
  # plot histogram
  output$plot <- renderPlot({
    hist(rnorm(input$num))
  })
  
  # table
  output$table <- renderTable({
    head(iris, 10)
  })
}

shinyApp(ui, server)