library(shiny)
library(plotly)
library(ggplot2)

source('dataset.R')

my.ui <- navbarPage(
  
  # Application title
  "Name",

  tabPanel("Tab 1",
    sidebarLayout(
      sidebarPanel(
        tags$h4("Story of the day"),
        tags$p("Today's story is with ", tags$b(story$entity_name),
               if (story$alt_name != ""){
                (paste0("(",story$alt_name,")"))
               }, "!"),
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
        tags$p("A data breach occurs when an unauthorized entity has stolen, copied, 
               or viewed data that is private, confidential or protected."),
        tags$h2("What are examples of data breaches?"),
        tags$p("A common example of a data breach is some malicious user hacking into
               a unauthorized network and stealing data files. However, data breaches
               can occur simply an employee leaving confidential information up on their
               computer screen, and then some unauthorized employee is able to read it."),
        tags$h2("Why are data breaches bad? Who does it impact?"),
        tags$p("Obviously, when a company is hit with a data breach, they inevitably lose revenue.
               Often they will be hit by the press, and end up being painted in a negative light.",
               tags$br(),
               "But this is not why a data breach can be devastating. What if the data that was stolen
               included your personal information? Now, private information is no longer private, and
               can end up being sold and your privacy violated. When a company is hit by a data breach,
               especially when the company handles sensitive information such as bank accounts, passwords,
               or health records, all consumers are impacted.")
        
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
                 tabPanel("Bar Graph", plotlyOutput("barGraph")),
                 tabPanel("Time Series", plotlyOutput("timeSeries"))
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