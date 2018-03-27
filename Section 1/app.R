
library(shiny)

uiLogin = fluidPage(
  div(id = "login",
      wellPanel(textInput("username", "Username"),
                passwordInput("password", "Password"),
                br(),
                actionButton("Login", "Log in"))),
  tags$style(type = "text/css", "#login 
      {font-size:10px;   
        text-align: left;position:absolute;top: 40%;
        left: 50%; margin-top: -100px; margin-left: -150px;}")
)

ui = htmlOutput("page")

server = function(input, output,session) {
  
  USER = reactiveValues(Logged = FALSE, attempt = FALSE)
  
  observe({ 
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        
        isolate(
          if(!is.null(input$username) & !is.null(input$password)){
            if(input$username == "test" & input$password == "test"){
              USER$Logged = TRUE
            }
          }
        )
      } 
    }
  })
  
  observeEvent(input$Login, {
    
    if(USER$Logged == FALSE){
      USER$attempt = TRUE
    }
    
  })
  
  observe({
    if(USER$Logged == FALSE) {
      
      if(!USER$attempt){
        output$page <- renderUI({
          
          fluidPage(uiLogin)
        })
      } else {
        
        output$page <- renderUI({
          
          fluidPage(uiLogin, 
                    span(style = "color:red", "Incorrect login"))
        })
      }
    }
    
    if (USER$Logged == TRUE) {
      output$page <- renderUI({
        
        # Title panel
        tagList(
          titlePanel("Title the graph"),
          
          # Typical sidebar layout with text input
          sidebarLayout(
            sidebarPanel(
              textInput("title", "Title", value = "Your title here")
            ),
            
            # Plot is placed in main panel
            mainPanel(
              plotOutput("thePlot")
            )
          )
        )
      })
    }
  })
  
  output$thePlot = renderPlot({
    
    plot(1:10, main = input$title)
  })
}

shinyApp(ui, server)