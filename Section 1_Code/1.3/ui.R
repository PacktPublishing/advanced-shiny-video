
fluidPage(
  
  titlePanel("Movies explorer"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year", min = 1893, max = 2005,
                  value = c(1945, 2005), sep = ""),
      selectInput("genre", "Which genre?", 
                  c("Action", "Animation", "Comedy", "Drama", 
                    "Documentary", "Romance", "Short")),
      uiOutput("listMovies"),
      actionButton("showClientData", "Show client data")
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Budgets over time", value = "plot", 
                           plotOutput("budgetYear")),
                  tabPanel("Movie picker", value = "table", 
                           tableOutput("moviePicker"))
      )
    )
  )
)