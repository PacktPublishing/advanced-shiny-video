
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
      actionButton("downloadData", "Download data frame")
    ),
    
    mainPanel(
      tabsetPanel(
        id = "theTabs",
        tabPanel("Budgets", value = "plot",
                 splitLayout(
                   plotOutput("budgetYear",
                              brush = brushOpts("dateBrush",
                                                direction = "x")),
                   plotOutput("yearBudget", 
                              click = clickOpts("plotClick"))
                 )
        ),
        tabPanel("Movie picker", value = "table", 
                 tableOutput("moviePicker"))
      )
    )
  )
)