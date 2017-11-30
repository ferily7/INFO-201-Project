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
  # Mitch's tab - time series
  tabPanel("Tab 5",
    sidebarLayout(
      sidebarPanel(
        selectInput("filter", "Filter by:",
                    c("All" = "all",
                      "Web" = "web", 
                      "Financial" = "financial", 
                      "Telecommunications" = "telecoms", 
                      "Technology" = "tech", 
                      "Government" = "government", 
                      "Retail" = "retail", 
                      "Energy" = "energy", 
                      "Academia" = "academic", 
                      "Healthcare" = "healthcare", 
                      "Military" = "military",
                      "Gaming" = "gaming", 
                      "Media" = "media", 
                      "Transportation" = "transport", 
                      "Legal" = "legal", 
                      "Applications" = "app")
        )
      ),
      mainPanel(
         plotlyOutput("timeSeries")
      )
    )
  )
)

shinyUI(my.ui)