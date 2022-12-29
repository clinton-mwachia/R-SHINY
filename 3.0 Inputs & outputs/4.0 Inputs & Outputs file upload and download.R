library(shiny)
# thanks for watching guys.

# increase file upload size limit
options(shiny.maxRequestSize=10*1024^2) # 10 mb

ui <- fluidPage(
  titlePanel(h5("inputs & outputs: file upload and download")),
  # app layout
  sidebarLayout(
    sidebarPanel(
      # file upload input
      fileInput("file", "Upload")
    ),
    mainPanel(
      # display head of the uploaded data
      tableOutput("upload"),
      # DOWNLOAD THE DATA
      downloadButton("download")
    )
  )
)

server <- function(input, output, session) {
  # lets handle the uploaded data
  
  # creating a reactive data
  data <- reactive({
    req(input$file)
    
    # file extension
    ext <- tools::file_ext(input$file$name)
    
    # loop through file extensions
    switch (ext,
            # handle csv
      csv = read.csv(input$file$datapath),
      # throw error for wrong file uploaded
      validate("Invalid file uploaded: Only accepts csv files")
    )
  })
  
  # head of the data
  output$upload <- renderTable({
    head(data(), 5)
  })
  
  # download the loaded data
  output$download <- downloadHandler(
    filename = function(){
      paste0(input$file)
    },
    content = function(file){
      write.csv(data(), file)
    }
  )
}

shinyApp(ui, server)