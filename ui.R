library(shinythemes)
library(shiny)
library(plotly)
library(ggplot2)

source('dataset.R')

my.ui <- navbarPage(theme = shinytheme("cosmo"),
  
  # Application title
  "Name",

  tabPanel("Tab 1",
    sidebarLayout(
      sidebarPanel(
        tags$h4("Story of the day"),
        tags$p("Today's story is with ", tags$b(story$entity_name),
               if (story$alt_name != ""){
                (paste0("(",story$alt_name,")"))
               }
               ),
        tags$p("In ", story$year, ", ", story$description),
        tags$p("There was an estimated ", story$records_lost, " records lost!"),
        tags$a(href=story$source_1, "Continue reading..."),
        if (story$source_2 != "") {
          tags$a(href=story$source_2, "(additional source)")
        }
      ),
      
      mainPanel(
        # All of this text needs editing
        tags$h2("What is a data breach?"),
        tags$p("A data breach is when private, confidential or protected data has 
               been stolen, copied or viewed by an unauthorized entity."),
        tags$h2("What are examples of data breaches and how bad can they be?"),
        tags$p("A common example of a data breach is when some malicious user hacks into
               an unauthorized network and steals data files. However, data breaches can
               also occur simply when an employee leaves confidential information up on their
               computer screen and some unauthorized employee is able to read it. One of the most
               recent security breach that occurred was the Equifax Security Leak. Because of the 
               data breach, it impact more than 2.5 million Americans, which included information 
               such as social security numbers, addresses, driver license numbers and credit card 
               information."),
        tags$h2("Why are data breaches bad? Who does it impact?"),
        tags$p("Obviously, when a company is hit by a data breach, they inevitably lose revenue.
               Often they will be hit by the press and end up being painted in a negative light.
               However, this is not why a data breach can be devastating. What if the data that 
               was stolen included your personal information? Now, private information is no longer 
               private and can end up being sold, with your privacy violated. When a company is hit 
               by a data breach, especially when the company handles sensitive information such as 
               bank accounts, passwords, or health records, all consumers are impacted.")
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
               tabsetPanel(
                 tabPanel("Bar Graph", br(), plotlyOutput("barGraph")),
                 tabPanel("Time Series", br(), plotlyOutput("timeSeries"))
               )
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