library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(
    title="Dashboard",
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Sales Dept",
                   message = "Sales are steady this month."
                 ),
                 messageItem(
                   from = "New User",
                   message = "How do I register?",
                   icon = icon("question"),
                   time = "13:45"
                 ),
                 messageItem(
                   from = "Support",
                   message = "The new server is ready.",
                   icon = icon("life-ring"),
                   time = "2014-12-01"
                 )
    ),
    dropdownMenu(type = "notifications",
                 notificationItem(
                   text = "5 new users today",
                   icon("users")
                 ),
                 notificationItem(
                   text = "12 items delivered",
                   icon("truck"),
                   status = "success"
                 ),
                 notificationItem(
                   text = "Server load at 86%",
                   icon = icon("exclamation-triangle"),
                   status = "warning"
                 )
    ),
    dropdownMenu(type = "tasks", badgeStatus = "success",
                 taskItem(value = 90, color = "green",
                          "Documentation"
                 ),
                 taskItem(value = 17, color = "aqua",
                          "Project X"
                 ),
                 taskItem(value = 75, color = "yellow",
                          "Server deployment"
                 ),
                 taskItem(value = 80, color = "red",
                          "Overall project"
                 )
    )
  ),
  dashboardSidebar(
    sidebarSearchForm("search", "searchbtn", "search..."),
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", icon = icon("th"), tabName = "widgets",
               badgeLabel = "new", badgeColor = "green"),
      menuItem("charts", icon = icon("bar-chart-o"),
               menuSubItem("boxPlot",
                            tabName = "boxplot-tab" ) ,
               menuSubItem("piechart" ,
                            tabName = "pie-tab" ))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                # A static valueBox
                valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
                
                # Dynamic valueBoxes
                valueBox(10 * 15, "Progress", icon = icon("list"),
                         color = "purple"),
                
                valueBox(10 * 4, "New Orders", icon = icon("credit-card"),
                         color = "yellow"),
              ),
              fluidRow(
                box(
                  title = "Box title", width = 6, status = "primary",
                  "Box content"
                ),
                box(
                  title = "Box title",status = "warning", width = 6,
                  "Box content"
                )
              ),
      ),
      
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
  )
)

server <- function(input, output) {
  
}

shinyApp(ui, server)