
library(DT)

fluidPage(
  
  fluidRow(
    column(3, 
           headerPanel("Logins")
    ),
    column(9, 
           dataTableOutput("logins"),
           hr(),
           
           h3("Update a row"),
           fluidRow(
             column(2,
                    textInput("id", "ID")),
             column(2,
                    textInput("firstname", "First name")),
             column(2,
                    textInput("surname", "Surname")),
             column(2,
                    textInput("email", "Email")),
             column(2,
                    textInput("password", "Password")),
             column(2,
                    actionButton("update", "Update", style = 'margin:10px;'),
                    actionButton("delete", "Delete", style = 'margin:10px;'))
           ),
           hr(),
           
           h3("Insert a record"),
           fluidRow(
             column(2,
                    textInput("firstnameinsert", "First name")),
             column(2,
                    textInput("surnameinsert", "Surname")),
             column(2,
                    textInput("emailinsert", "Email")),
             column(2,
                    textInput("passwordinsert", "Password")),
             column(2,
                    actionButton("insert", "Insert"))
           )
           
    )
  )
)

