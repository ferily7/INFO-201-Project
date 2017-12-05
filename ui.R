library(shinythemes)
library(shiny)
library(plotly)
library(ggplot2)
source('dataset.R')

my.ui <- navbarPage(theme = shinytheme("cosmo"),
  
  # Application title
  "Name",
  tabPanel("Data Breaches",
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
  
  tabPanel("Breach Type & Data Sensitivity",
    fluidPage(
      fluidRow(
        h4("Title"),
        p("Description"),
        div(
          plotlyOutput("heatMap", height="700px",width="1000px"),
          align = "center", style="margin-top: 50px;"
        )
      )
    )
  ),
  
  tabPanel("Type of Organizations",
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
          tabPanel("Bar Graph", 
                   h4("Which type of organizations have the highest amount of breaches?"),
                   p("Below is a bar graph showing the top 10 organizations who have had the 
                      highest number of cyber breaches. On the x-axis is the number of records
                      lost in the organization and the y-axis is the name of the organization.
                      Each organization type has a different amount of records lost from cyber
                      breaches, with some organizations affected more than others."),
                   br(),
                   plotlyOutput("barGraph")),
          tabPanel("Time Series",
                   h4("How do data breaches behave over time?"),
                   p("Below is a time series plot revealing how many data breaches have
                      occurred during the 2004-2017. The yellow line is a best-line fit
                      highlighting the trend of the data. Notice it remains increasing
                      for most of the organization types, with the few exceptions only due
                      a smaller sample size."),
                   br(),
                   plotlyOutput("timeSeries"))
        )
      )
    )
  ),
  
  tabPanel("Year",
    sidebarLayout(
      sidebarPanel(
        sliderInput("obs", "Year:", min = 2004, max = 2017, value = 1, sep = "")
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Pie 1",
                   h4("Title"),
                   p("Description"),
                   br(),
                   plotlyOutput("pie")
          ),
          
          tabPanel("Pie 2",
                   h4("Title"),
                   p("Description"),
                   br(),
                   plotlyOutput("distplot")
          )
        )
      )
    )
  )
)
  

shinyUI(my.ui)