library(shiny)

choices = c(1,2,3)

choices2 = c("male","female")

# thanks for watching.

ui <- fluidPage(
  # title of the app
  titlePanel(h5("Inputs & Outputs: Select and Checkbox")),
  # app layout
  sidebarLayout(
    sidebarPanel(
      # select input
      selectInput("sel", "Select number", choices = choices),
      # select input, multiple
      selectInput("sel2", "Select multiple", choices = choices,
                  multiple = T),
      # check box
      checkboxInput("check", "I Agree"),
      # group check box: method 1
      checkboxGroupInput("check2", "Gender? :method1", choices = choices2),
      # # group check box: method 2
      checkboxGroupInput("check3", "Gender? :method2", 
                         choiceNames = list("male","female"),
                         choiceValues = c("Male", "Female"))
    ),
    mainPanel(
      fluidRow(
        titlePanel("Select Output"),
        column(6, verbatimTextOutput("num")),
        column(6, verbatimTextOutput("num2"))
      ),
      fluidRow(
        titlePanel("Checkbox Output"),
        column(6, verbatimTextOutput("box")),
        column(6, verbatimTextOutput("box2")),
        column(6, verbatimTextOutput("box3"))
      )
    )
  )
)

server <- function(input, output, session) {
  # select output
  output$num <- renderPrint({
    input$sel
  })
  
  # select multiple output
  output$num2 <- renderPrint({
    input$sel2
  })
  
  # check box output
  output$box <- renderPrint({
    input$check
  })
  
  # check box output: method 1
  output$box2 <- renderPrint({
    input$check2
  })
  
  # check box output: method 2
  output$box3 <- renderPrint({
    input$check3
  })
}

shinyApp(ui, server)