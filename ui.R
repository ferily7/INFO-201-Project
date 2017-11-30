library(shiny)
library(plotly)
library(ggplot2)

my.ui <- navbarPage(
  
  # Application title
  "Name",

  tabPanel("Tab 1",
    sidebarLayout(
      sidebarPanel(
        
      ),
      mainPanel(
        
      )
    )
  ),
  
  tabPanel("Tab 2",
    sidebarLayout(
      sidebarPanel(
        
      ),
      
      mainPanel(
        
      )
    )
  ),
  
  tabPanel("Tab 3",
    sidebarLayout(
      sidebarPanel(
        
      ),
      
      mainPanel(
        
      )
    )
  ),
  
  tabPanel("Tab 4",
    sidebarLayout(
      sidebarPanel(
        
      ),
      
      mainPanel(
        
      )
    )
  ),
  
  tabPanel("Tab 5",
    sidebarLayout(
      sidebarPanel(
        
      ),
      
      mainPanel(
        
      )
    )
  )
)

shinyUI(my.ui)