
library(DBI)
library(pool)
library(DT)

pool = dbPool(
  
  drv = RMySQL::MySQL(),
  dbname = "XXXX",
  host = "XXXX",
  username = "XXXX",
  password = "XXXX"
)

function(input, output, session) {
  
  # data function
  
  loginsData = reactive({
    
    input$update # refresh when update runs
    input$delete # refresh when delete runs
    input$insert # refresh when insert runs
    
    query = "SELECT * FROM logins;" 
    fetch = sqlInterpolate(pool, query)
    dbGetQuery(pool, fetch)
    
  })
  
  output$logins = DT::renderDataTable({
    
    updateTextInput(session, "id", value = "")
    updateTextInput(session, "firstname", value = "")
    updateTextInput(session, "surname", value = "")
    updateTextInput(session, "email", value = "")
    updateTextInput(session, "password", value = "")
    
    datatable(loginsData(), selection = "single", 
              rownames = FALSE)

  })
  
  outputOptions(output, 'logins', priority = -100)
  
  observe({
    
    if(!is.null(input$logins_row_last_clicked)){
      
      updateValue = 
        loginsData()[input$logins_row_last_clicked, ]
      
      updateTextInput(session, "id", 
                      value = updateValue$id)
      updateTextInput(session, "firstname", 
                      value = updateValue$firstname)
      updateTextInput(session, "surname", 
                      value = updateValue$surname)
      updateTextInput(session, "email", 
                      value = updateValue$email)
      updateTextInput(session, "password", 
                      value = updateValue$password)
    }
  })
  
  observeEvent(input$update, {
    
    query = "UPDATE logins SET firstname = ?firstname, 
      surname = ?surname, email = ?email,
      password = ?password WHERE id = ?id;"
    
    fetch = sqlInterpolate(pool, query, 
                           firstname = input$firstname, 
                           surname = input$surname,
                           email = input$email, 
                           password = input$password, 
                           id = input$id)
    
    dbGetQuery(pool, fetch)
    
  }, priority = 200)
  
  observeEvent(input$insert, {
    
    query = "INSERT INTO logins (id, firstname, surname,
      email, password) VALUES (NULL, ?firstname, ?surname, 
      ?email, ?password);"
    
    fetch = sqlInterpolate(pool, query, 
                           firstname = input$firstnameinsert, 
                           surname = input$surnameinsert,
                           email = input$emailinsert, 
                           password = input$passwordinsert)
    
    dbGetQuery(pool, fetch)
    
    # delete the data that has just been entered
    
    updateTextInput(session, "firstnameinsert", value = "")
    updateTextInput(session, "surnameinsert", value = "")
    updateTextInput(session, "emailinsert", value = "")
    updateTextInput(session, "passwordinsert", value = "")
    
  }, priority = 200)
  
  observeEvent(input$delete, {
    
    query = "DELETE FROM logins WHERE id = ?id;"
    
    fetch = sqlInterpolate(pool, query, id = input$id)
    
    dbGetQuery(pool, fetch)
  }, priority = 200)
  
}
