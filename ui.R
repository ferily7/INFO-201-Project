library(shiny)
library(plotly)
library(ggplot2)

my.ui <- navbarPage(
  
  # Application title
  "Cyber Breaches within Organizations",

  tabPanel("Types Of Organizations",
    sidebarLayout(
      sidebarPanel(
        selectInput("choice", label = "Choose the type of organization", 
                    choices = list("Web" = "web", "Financial" = "financial", "Telecoms" = "telecoms", "Tech" = "tech", "Government" = "government", 
                                   "Retail" = "retail", "Energy" = "energy", "Academic" = "academic", "Healthcare" = "healthcare", "Military" = "military",
                                   "Gaming" = "gaming", "Media" = "media", "Transport" = "transport", "Legal" = "legal", "App" = "app"), 
                    selected = 1)
      ),
    
    mainPanel(
          plotlyOutput("selectBox")
        )
      )
    ),
    tabPanel("Year vs. Leaked Method",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("obs", "Year:", min = 2004, max = 2017, value = 1, sep = "")
               ),
               
               mainPanel(
                 plotlyOutput("distplot")
               )
             )
    )
  )
  

shinyUI(my.ui)