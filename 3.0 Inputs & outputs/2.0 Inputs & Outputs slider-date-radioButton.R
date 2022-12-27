library(shiny)

choices = c("Option 1","Option 2")

ui <- fluidPage(
  titlePanel(h5("Inputs & Outputs: slider, date and radio button")),
  # the app layout
  sidebarLayout(
    sidebarPanel(
      # slider input
      sliderInput("slider", "Select value:",value = 2, min = 0,max = 10),
      # slider input animated
      sliderInput("sliderAnim", "Animate:",value = 2, min = 0,max = 10,
                  animate = TRUE),
      # slider with multiple values
      sliderInput("slider2", "Select value:",value = c(2,4), min = 0,max = 10),
      # date input
      dateInput("date", "Reg Date"),
      # range of dates
      dateRangeInput("date2","exam period"),
      # radio buttons
      radioButtons("radio", "Option:", choices = choices)
    ),
    mainPanel(
      # display to the user layout
      fluidRow(
        # title of the row
        titlePanel("Slider output"),
        column(6, verbatimTextOutput("slid")),
        column(6, verbatimTextOutput("slid2")),
        column(6, verbatimTextOutput("slid3"))
      ),
      fluidRow(
        # title of the row
        titlePanel("Date output"),
        column(6, verbatimTextOutput("regDate")),
        column(6, verbatimTextOutput("exam")),
      ),
      fluidRow(
        # title of the row
        titlePanel("Radio Button output"),
        column(6, verbatimTextOutput("rad"))
      ),
      fluidRow(
        # title of the row
        titlePanel("CONCLUSION"),
        column(6, "thanks for watching, see you in the next video")
      )
    )
  )
)

server <- function(input, output, session) {
  # slider output
  output$slid <- renderPrint({
    input$slider
  })
  
  # slider ANIMATE output
  output$slid2 <- renderPrint({
    input$sliderAnim
  })
  
  # slider output with multiple values
  output$slid3 <- renderPrint({
    input$slider2
  })
  
  # date output
  output$regDate <- renderPrint({
    input$date
  })
  
  # date range output
  output$exam <- renderPrint({
    input$date2
  })
  
  # radio buttons output
  output$rad <- renderPrint({
    input$radio
  })
}

shinyApp(ui, server)