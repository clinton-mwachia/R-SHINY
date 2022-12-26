library(shiny)

ui <- fluidPage(
  titlePanel(h5("Inputs & Outputs: text, numeric and password")),
  # the layout
  sidebarLayout(
    sidebarPanel(
      # text input
      textInput("fname", "Full name:", value = "Your name",
                placeholder = "Enter full name"),
      # text area: for long sentences
      textAreaInput("long", "Comment", value = "Your comment",
                    placeholder = "Enter your comment"),
      # numeric input
      numericInput("num", "Enter Number:", value = 10),
      # password input
      passwordInput("secret", "Enter password", value = "1234!?",
                    placeholder = "Password")
    ),
    mainPanel(
      # lets display text output
      fluidRow(
        # title of the row
        titlePanel("Text Outputs"),
        column(6, textOutput("name")),# normal text output
        column(6, verbatimTextOutput("name1")), # printing text
        column(6, textOutput("sentence")),# long text output
        column(6, verbatimTextOutput("sentence2")) # printing long text
      ),
      # row for display numeric values
      fluidRow(
        titlePanel("Numeric Outputs"),
        column(6, textOutput("number")) # display number to user
       # column(6, plotOutput("number2")), # display plot to user
      ),
      # row for display password to users
      fluidRow(
        titlePanel("Password Outputs"),
        column(6, textOutput("psw")), # display password to user
        column(6, textOutput("psw2")) # display password to user
      )
    )
  )
)

server <- function(input, output, session) {
  # text output
  ## normal text
  output$name <- renderText({
    input$fname
  })
  ## verbatim text output
  output$name1 <- renderPrint({
    input$fname
  })
  
  # text area output 
  output$sentence <- renderText({
    input$long 
  })
  # verbatim text area output
  output$sentence2 <- renderPrint({
    input$long 
  })
  
  # numeric output
  output$number <- renderText({
    input$num
  })
  # display a graph using numeric input
  output$number2 <- renderPlot({
    hist(rnorm(input$num))
  })
  
  # password output
  output$psw <- renderText({
    input$secret
  })
  
  # print password to user
  output$psw2 <- renderPrint({
    input$secret
  })
}

shinyApp(ui, server)