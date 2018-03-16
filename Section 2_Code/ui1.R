
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
      tags$input(type = "button",              
                 id = "append",                    
                 value = "Add current input values",
                 onClick = "buttonClick()"),
      includeHTML("appendText.js")
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Budgets over time", value = "plot", 
                           plotOutput("budgetYear"),
                           h3("User selection"),
                           p(id = "selection", "")),
                  tabPanel("Movie picker", value = "table", 
                           tableOutput("moviePicker"))
      )
    )
  )
)