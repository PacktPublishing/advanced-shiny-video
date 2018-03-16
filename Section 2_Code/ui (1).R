
library(shinyjs)

fluidPage(
  
  useShinyjs(),
  extendShinyjs(script = "appendText.js"),
  
  titlePanel("Movies explorer"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year", min = 1893, max = 2005,
                  value = c(1945, 2005), sep = ""),
      selectInput("genre", "Which genre?", 
                  c("Action", "Animation", "Comedy", "Drama", 
                    "Documentary", "Romance", "Short")),
      uiOutput("listMovies"),
      actionButton("buttonClick", "Add inputs"),
      selectInput("color", "Text colour", 
                  c("Red" = "red", 
                    "Blue" = "blue", 
                    "Black" = "black")),
      selectInput("size", "Text size",
                  c("Extremely small" = "xx-small", 
                    "Very small" = "x-small",
                    "Small" = "small", 
                    "Medium" = "medium", 
                    "Large" = "large", 
                    "Extra large" = "x-large", 
                    "Super size" = "xx-large")
      )
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Budgets over time", value = "plot", 
                           plotOutput("budgetYear"),
                           h3("User selection history"),
                           p(id = "selection", "")),
                  tabPanel("Movie picker", value = "table", 
                           tableOutput("moviePicker"))
      )
    )
  )
)