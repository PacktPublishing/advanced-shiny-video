
fluidPage( 
  
  h4(HTML("Think of a number:</br>Does Shiny or JavaScript rule?")),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("pickNumber", "Pick a number",
                  min = 1, max = 10, value = 5),
      tags$div(id = "output")
    ),
    
    mainPanel(
      textOutput("randomNumber"),
      hr(),
      textOutput("theMessage"),
      includeHTML("dropdownDepend.js")
    )
  )
)