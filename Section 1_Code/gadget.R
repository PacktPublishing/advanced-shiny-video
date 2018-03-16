
library(shiny)
library(miniUI)
library(httr)
library(leaflet)

mapFunction = function(type) {
  
  ui = miniPage(
    gadgetTitleBar("My Gadget"),
    miniContentPanel(
      textInput("postcode", "Postcode"),
      leafletOutput("mymap")
    )
  )
  
  server = function(input, output) {
    
    parseData = reactive({
      
      request = 
        GET(paste0("https://api.postcodes.io/postcodes/", 
                   input$postcode))
      
      content(request)
    })
    
    output$mymap <- renderLeaflet({
      
      validate(
        need(parseData()$result["longitude"], 
             "Invalid postcode")
      )
      
      leaflet() %>% 
        setView(
          lng = parseData()$result[["longitude"]], 
          lat = parseData()$result[["latitude"]], 
          zoom = 12) %>%
        addTiles() %>%
        addMarkers(
          lng = parseData()$result[["longitude"]], 
          lat = parseData()$result[["latitude"]])
    })
    
    observeEvent(input$done, {
      
      returnValue = parseData()$result[type]
      
      stopApp(returnValue)
    })
  }
  
  runGadget(ui, server)
}

mapFunction("longitude")

# mapFunction("region")
