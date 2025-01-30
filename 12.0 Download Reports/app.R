library(shiny)

# the UI
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  downloadButton("report", "Generate report"),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

# Copy report to temporary directory. This is mostly important when
# deploying the app, since often the working directory won't be writable
report_path <- tempfile(fileext = ".Rmd")
file.copy("report.Rmd", report_path, overwrite = TRUE)

# render report
render_report <- function(input, output, params) {
  
  rmarkdown::render(input,
                    output_file = output,
                    params = params,
                    envir = new.env(parent = globalenv())
  )
}

server <- function(input, output) {
  # get the data
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  # generate the report
  output$report <- downloadHandler(
    filename = "report.html",
    content = function(file) {
      params <- list(data = dataset())
      
      id <- showNotification(
        "Rendering report...",
        duration = NULL,
        closeButton = FALSE
      )
      on.exit(removeNotification(id), add = TRUE)
      callr::r(
        render_report,
        list(input = report_path, output = file, params = params)
      )
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
