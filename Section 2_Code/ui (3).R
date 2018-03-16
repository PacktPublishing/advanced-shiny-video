
library(d3scatter)
library(DT)

fluidPage(
  
  titlePanel("Movies explorer"),
  
  fluidRow(
    column(6,       sliderInput("year", "Year", min = 1893, max = 2005,
                                value = c(1945, 2005), sep = ""),
           selectInput("genre", "Which genre?", 
                       c("Action", "Animation", "Comedy", "Drama", 
                         "Documentary", "Romance", "Short")),
           uiOutput("listMovies"),
           d3scatterOutput("budgetYear")),
    column(6, DT::dataTableOutput("movieSummary"))
  )
)
