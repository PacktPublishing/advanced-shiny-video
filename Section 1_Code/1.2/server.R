
library(ggplot2movies)
library(tidyverse)
library(scales)
library(rlang)

function(input, output) {
  
  plotStore = reactiveValues()
  
  moviesSubset = reactive({
    
    dataReturn = movies %>% 
      filter(year %in% seq(input$year[1], input$year[2]), 
             UQ(sym(input$genre)) == 1,
             !is.na(budget))
    
    plotStore$xyz = dataReturn %>%
      sample_n(100) %>%
      select("budget", "rating", "year")
    
    return(dataReturn)
  })
  
  output$budgetYear = renderPlot({
    
    budgetByYear = summarise(group_by(moviesSubset(), year), 
                             m = mean(budget, na.rm = TRUE))
    
    ggplot(budgetByYear, 
           aes(x = year, y = m)) + 
      geom_line() + 
      scale_y_continuous(labels = scales::comma) + 
      geom_smooth(method = "loess")
    
  })
  
  observeEvent(input$plotClick, {
    
    newPoints = data.frame("budget" = input$plotClick$x, 
                           "rating" = input$plotClick$y,
                           "year" = NA)
    
    plotStore$xyz = rbind(plotStore$xyz, newPoints)
  })
  
  observeEvent(input$downloadData, {
    
    stopApp(returnValue = plotStore$xyz)
  })
  
  output$yearBudget = renderPlot({
    
    if(!is.null(input$dateBrush)){
      
      scatterData = plotStore$xyz %>%
        filter(is.na(year) |
                 year %in% seq(round(input$dateBrush$xmin, 0), 
                               round(input$dateBrush$xmax, 0)))
      
    } else {
      
      scatterData = plotStore$xyz
    }
    
    scatterData %>%
      ggplot(aes(x = budget, y = rating)) + geom_point() + 
      scale_x_continuous(labels = scales::comma) +
      geom_smooth(method = "lm")
  })
  
  output$listMovies = renderUI({
    
    selectInput("pickMovie", "Pick a movie", 
                choices = moviesSubset() %>% 
                  sample_n(10) %>%
                  select(title)
    )
  })
  
  output$moviePicker = renderTable({
    
    filter(moviesSubset(), title == input$pickMovie)
  })
  
}

# dataFrame = runApp()
