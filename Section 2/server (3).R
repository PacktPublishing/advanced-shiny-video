
library(ggplot2movies)
library(tidyverse)
library(scales)
library(rlang)
library(d3scatter)
library(crosstalk)
library(DT)

function(input, output, session) {
  
  moviesSubset = reactive({
    
    movies %>% filter(year %in% seq(input$year[1], input$year[2]), 
                      UQ(sym(input$genre)) == 1,
                      !is.na(budget)) %>%
      head(100) %>%
      select(title : rating)
  })
  
  shared_movies = SharedData$new(moviesSubset)
  
  output$budgetYear = renderD3scatter({
    
    shared_movies %>%
      d3scatter(x = ~ log(budget), y = ~ rating)
  })

  output$movieSummary = DT::renderDataTable({
    
    shared_movies
  }, server = FALSE)
}
