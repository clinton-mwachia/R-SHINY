library(shiny)
library(bslib)

thematic::thematic_shiny(font="auto")

# lets create nav bar pages
# lets apply the boots watch theme with bslib
# it will take sometime to load

# AS YOU CAN SEE, THE INPUTS COLORS HAVE CHANGED
# plots are not applied the theme, lets work on that

# to get a list of all the themes, use the following
#bootswatch_themes(version = version_default())

# thanks for watching and see you in the next video.

ui <- navbarPage(
  theme = bs_theme(bootswatch = "darkly"),
  title = "Bootswatch Theming",
  collapsible = TRUE,
  # tab panels
  tabPanel("Inputs", 
           # input panel to contain the inputs
           inputPanel(
             # select input
             selectInput("select", "Select state:", choices = state.name),
             # text input
             textInput("text", "Enter Name:"),
             # multiple select
             selectInput("select2", "Select state:", choices = state.name,
                         multiple = T),
             # slider input
             sliderInput("slider", "Input amount:", min = 0, max=100, value = 20)
           ),
           # add space between inputs and outputs
           br(),
           verbatimTextOutput("inputs")
           ),
  tabPanel("Plots", 
           #app layout
           sidebarLayout(
             # sidebar
             sidebarPanel(
               numericInput("num", "Enter num:",min = 10, max = 100,value = 30)
             ),
             mainPanel(plotOutput("plot"))
           )
           ),
  tabPanel("Tables", dataTableOutput("table"))
)

server <- function(input, output, session) {
  # handle inputs and output them
  output$inputs <- renderPrint({
    # convert to string
    str(
      # output as list
      list(selectInput = input$select,
           selectInputMultiple = input$select2,
           TextInput = input$text,
           sliderInput = input$slider)
    )
  })
  
  # output plot
  output$plot <- renderPlot({
    # render progress first
    withProgress(message = "Rendering plot", value = 0, {
      for (i in 1:10) {
        incProgress(1/10)
        Sys.sleep(0.25)
      }
    })
    hist(rnorm(input$num),main="Histogram", xlab="rnorm")
  })
  
  # output table
  output$table <- renderDataTable({
    # render progress first
    withProgress(message = "Rendering table", value = 0, {
      for (i in 1:10) {
        incProgress(1/10)
        Sys.sleep(0.25)
      }
    })
    iris
  })
}

shinyApp(ui, server)