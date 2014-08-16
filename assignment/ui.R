
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(slidify)

shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Kris' Homework"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("sample_size", 
                "Number of samples:", 
                min = 1, 
                max = 100, 
                value = 20),
    sliderInput("num_iterations", 
                "Number of iterations:", 
                min = 1, 
                max = 20, 
                value = 10)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    div(class="row", p("Documentation is at:"), a(href="http://krisgeus.github.io/shiny-documentation/", "Github pages documentation created with slidify")),
    div(class="row", p("Code is at:"), a(href="https://github.com/krisgeus/DevdataCoursera/tree/master/assignment", "Code for shiny application and slidify documentation")),
    div(class="row", plotOutput("distPlot1", width="100%", height="300")),
    div(class="row", plotOutput("distPlot2", width="100%", height="300")),
    div(class="row", plotOutput("distPlot3", width="100%", height="300"))
  )
    
))