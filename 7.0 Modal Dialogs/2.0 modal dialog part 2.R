library(shiny)

# lets add some icons to make it more beautiful

# thanks for watching.

ui <- fluidPage(
  titlePanel("Modal dialog Part II"),
  # app layout
  sidebarLayout(
    # side bar
    sidebarPanel(
      # action button to open modal dialog
      actionButton("data", "Show data modal")
    ),
    # main
    mainPanel(
      # lets display the data here
      tableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  # initialize the data
  data <- reactiveValues(data=NULL)
  
  # data modal
  # will be displayed after clicking the action button
  dataModal <- function(failed=FALSE){
    modalDialog(
      selectInput("dataset","Select data:", 
                  choices = c("mtcars","iris","mine")),
      if(failed)
        # will run if the data does not exist
        div(tags$b("Invalid data Selected", style="color:red")), # will execute when failer = TRUE
        # the modal footer
        footer = tagList(
          modalButton(icon("thumbs-down")),#cancel modal button
          actionButton("ok", icon("thumbs-up")) # take action on modal
        )
      
    )
  }
  
  # observer the event and run module
  # data action event.
  observeEvent(input$data,{
    showModal(dataModal())
  })
  
  # lets handle data after clicking okay
  observeEvent(input$ok, {
    # check if the data is not null and assign it to data
    # lets add a rule to handle if the data exists
    if(!is.null(input$dataset) && exists(input$dataset)){
      data$data <- get(input$dataset)
      removeModal()
    } else {
      showModal(dataModal(failed = TRUE))
    }
  })
  
  # table the data
  # lets handle empty data
  output$table <- renderTable({
    if(is.null(data$data)){
      "No data is selected"
    } else {
      head(data$data)
    }
  })
}

shinyApp(ui, server)