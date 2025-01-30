library(shiny)

# the UI
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  selectInput("report_type", "Select Report Format:", 
              choices = c("PDF" = "pdf", "Word" = "docx", "HTML" = "html")),
  downloadButton("report", "Generate report"),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

# Copy report template to temporary directory
report_path <- tempfile(fileext = ".Rmd")

if (file.exists("report.Rmd")) {
  file.copy("report.Rmd", report_path, overwrite = TRUE)
} else {
  stop("Missing 'report.Rmd'. Please ensure the template is available.")
}

# Function to render report
render_report <- function(input, output, params, format) {
  output_format <- switch(format,
                          pdf = "pdf_document",
                          docx = "word_document",
                          html = "html_document")
  
  tryCatch({
    rmarkdown::render(input,
                      output_file = output,
                      params = params,
                      output_format = output_format,
                      envir = new.env(parent = globalenv()))
  }, error = function(e) {
    message("Rendering Error: ", e$message)
  })
}

server <- function(input, output) {
  # get the data
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  # Generate and download report
  output$report <- downloadHandler(
    filename = function() { paste0(input$dataset, "_report.", input$report_type) },
    
    content = function(file) {
      params <- list(data = dataset())
      
      id <- showNotification("Rendering report...", duration = NULL, closeButton = FALSE)
      on.exit(removeNotification(id), add = TRUE)
      
      callr::r(render_report, list(input = report_path, output = file, params = params, format = input$report_type))
    }
  )
  
  # print summary
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  # render table for the data
  output$table <- renderTable({
    dataset()
  })
}
shinyApp(ui = ui, server = server)
