
library(shinyjs)

fluidPage(
  
  tags$head(
    tags$style(HTML(".redTable {
                      color: red;
                    }"
    ))
  ),
  
  useShinyjs(),
  
  titlePanel("Movies explorer"),
  
  sidebarLayout(
    sidebarPanel(
      div(id = "yearAndGenre", 
          sliderInput("year", "Year", min = 1893, max = 2005,
                      value = c(1945, 2005), sep = ""),
          selectInput("genre", "Which genre?", 
                      c("Action", "Animation", "Comedy", "Drama", 
                        "Documentary", "Romance", "Short"))
      ),
      checkboxInput("redTable", "Red text in table?"),
      uiOutput("listMovies"),
      actionButton("reset", "Reset year and genre?")
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Budgets over time", value = "plot", 
                           plotOutput("budgetYear"),
                           p(id = "controlList"), ""),
                  tabPanel("Movie picker", value = "table", 
                           div(id = "theTable", tableOutput("moviePicker")))
      )
    )
  )
)