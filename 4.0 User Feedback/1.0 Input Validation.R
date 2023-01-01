library(shiny)
# THANKS FOR WATCHING.
# change max upload size
options(shiny.maxRequestSize=10*1024^2) # 10 MB

ui <- fluidPage(
  titlePanel(h5("Input validation")), # app title
  # app layout
  sidebarLayout(
    # sidebar
    sidebarPanel(
      # numeric input
      numericInput("num", "Enter Number", value = ''),
      # character input
      textInput("text", "Enter text:",  value = ""),
      # file upload validation
      fileInput("file", "choose csv File:", accept = ".csv",
                buttonLabel = "Upload"),
      # validate select input
      selectInput("data", "Select Data:", choices = c("iris", "anscombe","mine")),
      # custom validate select input
      selectInput("data2", "Select Data2:", choices = c("iris", "anscombe","mine"))
    ),
    # main panel
    mainPanel(
      # display number to user
      verbatimTextOutput("number"),
      # display string to user
      verbatimTextOutput("string"),
      # output files
      tableOutput("files"),
      # output select input to the user
      tableOutput("dataset"),
      # display custom validation to user
      verbatimTextOutput("number2")
    )
  )
)
# custom validation function to check if the selected data is called mine
check_mine <- function(input){
  if(input != "mine"){
    "Choose another data"
  }
}

server <- function(input, output, session) {
  # validate numeric input
  data <- reactive({
    validate(
      # handle non-empty input
      need(input$num != "", "Please select a number"),
      # throw an error of the number is 2
      need(input$num != 2, "Please select another number")
    )
    input$num
  })
  # output number
  output$number <- renderPrint({
    data()
  })
  
  # validate text input
  data2 <- reactive({
    validate(
      # handle non empty
      need(input$text != "", "Please enter text"),
      # prevent character more than 5 characters
      need(!nchar(input$text) > 5, "Too many characters")
    )
    input$text
  })
  
  # output text
  output$string <- renderPrint({
    data2()
  })
  
  # file input validation
  files <- reactive({
    file <- input$file
    # file extension
    ext <- tools::file_ext(file$datapath)
    
    req(file) #trigger any changes if file input changes
    # only allow csv upload files
    validate(need(ext == "csv", "Please upload a csv file"))
    
    # read file after validation
    read.csv(file$datapath)
  })
  # display the file uploaded
  output$files <- renderTable({
    head(files())
  })
  
  # validate select input
  data3 <- reactive({
    validate(
      # handle non empty
      need(input$data != "", "Please select your data"),
      # confirm that the data is in the package
      # we are handling the error
      need(exists(input$data), "Data not found")
    )
    # get the data from the package data sets
    get(input$data, 'package:datasets')
  })
  
  # handle and output select input
  output$dataset <- renderTable({
    head(data3())
  })
  
  # custom validation of input using our function
  data4 <- reactive({
    validate(
      check_mine(input$data2)
    )
    # return the data
    input$data2
  })
  
  output$number2 <- renderPrint({
    data4()
  })
}

shinyApp(ui, server)