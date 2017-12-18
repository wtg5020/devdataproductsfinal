
library(shiny)


shinyUI(fluidPage(
  
  titlePanel("Car Performance Predictor"),
  

  sidebarLayout(position = "right",
    sidebarPanel(
       selectInput("trIn",
                   h3("Transmission Type"),
                   choices = list("Automatic" = 0, "Manual" = 1
                                 ), selected = 0),
       
       numericInput("cylBox", 
                   h3("Number of Cylinders"), 
                   value = 4),
       sliderInput("hpBox", h3("Select Horsepower"), 
                   min = 80, max = 500, value = 90),
       
    
      numericInput("wtBox", 
                 h3("Car Weight (1000 lbs)"), 
                 value = 1)
    ),
    mainPanel(
       h4("Car Performance Predictions based on specifications"),
       p("Welcome to the Car Predictor Webapp! The panel on the right side of the screen allows you to input your desiered Transmission Type (Automatic or Manual) 
        from the dropdown, Desired Cylinders (Numeric Input), Desired Horsepower (80 to 500), and Planned total weight (In 1000s of pounds, 2 for 2,000). 
         The predicted performance metrics of Miles Per gallon and Quarter Mile time (Qsec, in seconds) are calculated. Below these are two tables, 
         one showing the existing vehicles that are close to or meet the MPG requirement and the other showing which existing vehicles meet or are close to the quarter mile
         requirement. Those tables have a built in search capability if there are too many records returned"),
       h3("Miles Per Gallon"),
       textOutput("pred1"),
       h3("Quarter Mile Time (seconds)"),
       textOutput("pred2"),
       h3("Vehicles with MPG requirements"),
       dataTableOutput("dTable"),
       h3("Vehicles with Quarter Mile requirements"),
       dataTableOutput("dTable2")
    )
  )
))
