
library(ggplot2movies)
library(tidyverse)
library(scales)
library(rlang)

function(input, output, session) {
  
  # function from shiny.rstudio.com/articles/client-data.html
  
  cdata = session$clientData
  
  observeEvent(input$showClientData, {
    
    cnames = names(cdata)
    
    allvalues = lapply(cnames, function(name) {
      
      paste(name, cdata[[name]], sep = " = ")
    })
    
    showModal(modalDialog(
      
      title = "Client data",
      HTML(paste(allvalues, collapse = "<br>"))
    ))
  })
  
  moviesSubset = reactive({
    
    movies %>% filter(year %in% seq(input$year[1], input$year[2]), 
                      UQ(sym(input$genre)) == 1)
  })
  
  output$budgetYear = renderPlot({
    
    budgetByYear = summarise(group_by(moviesSubset(), year), 
                             m = mean(budget, na.rm = TRUE))
    
    ggplot(budgetByYear[complete.cases(budgetByYear), ], 
           aes(x = year, y = m)) + 
      geom_line() + 
      scale_y_continuous(labels = scales::comma) + 
      geom_smooth(method = "loess")
    
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
  
  observe({
    searchString = 
      parseQueryString(session$clientData$url_search)
    
    if(length(searchString) > 0) { # check to see if the URL 
                                   # has terms in it
      
      if(searchString[["genre"]] == "comedy"){
        
        updateSelectInput(session, "genre", selected = "Comedy")
      }
      
      if(!is.null(searchString[["yearmin"]])){
        
        updateSliderInput(
          session, "year",
          value = c(as.numeric(searchString["yearmin"]),
                    input$year[2])
        )
      }
    }
  })
}

# runApp(port = 5000, launch.browser = FALSE)

# http://127.0.0.1:5000/?yearmin=1920&genre=comedy

