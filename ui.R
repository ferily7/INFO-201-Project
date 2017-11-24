library(shiny)
library(plotly)
library(ggplot2)

shinyUI(fluidPage(
  
  # Application title

  # Sidebar with a slider input for number of calories 
  sidebarLayout(
    sidebarPanel(
      selectInput("choice", label = "Choose the type of organization", 
                  choices = list("Web" = "web", "Financial" = "financial", "Telecoms" = "telecoms", "Tech" = "tech", "Government" = "government", 
                                 "Retail" = "retail", "Energy" = "energy", "Academic" = "academic", "Healthcare" = "healthcare", "Military" = "military",
                                 "Gaming" = "gaming", "Media" = "media", "Transport" = "transport", "Legal" = "legal", "App" = "app"), 
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("selectBox")
    )
  )
))