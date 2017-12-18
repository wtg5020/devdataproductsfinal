
library(shiny)
library(data.table)

shinyServer(function(input, output) {
  
  dataTable <- cbind(names = rownames(mtcars), mtcars)
  
  dataTableSelect <- dataTable[, c("names", "mpg", "cyl", "hp", "wt", "qsec")] 
  
  modelMul <- lm(mpg ~ wt + cyl + hp + am, data=mtcars)
  
  modelQ <- lm(qsec ~ wt + cyl + hp + am, data=mtcars)
  
  tableFilter <- reactive({
    wtIn <- input$wtBox
    cylIn <- input$cylBox
    hpIn <- input$hpBox
    trIn <- as.numeric(input$trIn)
    mpgP <- predict(modelMul, newdata = data.frame(wt = wtIn, cyl = cylIn, hp = hpIn, am = trIn))
    dataTableSelect[dataTableSelect$mpg >=  mpgP,]
  })
  
  tableFilter2 <- reactive({
    wtIn <- input$wtBox
    cylIn <- input$cylBox
    hpIn <- input$hpBox
    trIn <- as.numeric(input$trIn)
    qsecP <- predict(modelQ, newdata = data.frame(wt = wtIn, cyl = cylIn, hp = hpIn, am = trIn))
    dataTableSelect[dataTableSelect$qsec >=  qsecP,]
  }) 
  
  mPrediction <- reactive({
    wtIn <- input$wtBox
    cylIn <- input$cylBox
    hpIn <- input$hpBox
    trIn <- as.numeric(input$trIn)
    predict(modelMul, newdata = data.frame(wt = wtIn, cyl = cylIn, hp = hpIn, am = trIn))
  })
  
  qPrediction <- reactive({
    wtIn <- input$wtBox
    cylIn <- input$cylBox
    hpIn <- input$hpBox
    trIn <- as.numeric(input$trIn)
    predict(modelQ, newdata = data.frame(wt = wtIn, cyl = cylIn, hp = hpIn, am = trIn))
  })
  

  
  output$pred1 <- renderText({
    mPrediction()
  })
  output$pred2 <- renderText({
    qPrediction()
  })

  output$dTable <- renderDataTable(tableFilter(), options = list(pageLength = 5))
  
  output$dTable2 <- renderDataTable(tableFilter2(), options = list(pageLength = 5))
})
