library(shinydashboard)
library(shinythemes)
library(shiny)
library(plotly)
library(ggplot2)
source('dataset.R')

my.ui <- dashboardPage(skin = "purple",
  dashboardHeader(title = "Cyber Breaches in Organizations",
                  titleWidth = 350),
  dashboardSidebar(width = 270,
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Number of Records Lost (by Quantiles)", tabName = "records", icon = icon("tasks")),
      menuItem("Breach Type & Data Sensitivity", tabName = "map", icon = icon("database")),
      menuItem("Type of Organizations", tabName = "types", icon = icon("sitemap")),
      menuItem("Year", tabName = "year", icon = icon("calendar-o"))
    )
  ),
  dashboardBody(
    tags$head (
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    
    tabItems(
      # First tab content
      tabItem(tabName = "home",
              fluidRow(
                box(
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

                tags$div(class = "content",
                         h2("What is a data breach?"),
                         p("A data breach is when private, confidential or protected data has 
                           been stolen, copied or viewed by an unauthorized entity."),
                         h2("What are examples of data breaches and how bad can they be?"),
                         p("A common example of a data breach is when some malicious user hacks into
                           an unauthorized network and steals data files. However, data breaches can
                           also occur simply when an employee leaves confidential information up on their
                           computer screen and some unauthorized employee is able to read it."),
                         p("One of the most recent security breach that occurred was the Equifax Security Leak.
                           Because of the data breach, it impacted more than 2.5 million Americans, which included 
                           information such as social security numbers, addresses, driver license numbers and credit card 
                           information."),
                         h2("Why are data breaches bad? Who does it impact?"),
                         p("When a company is hit by a data breach, some form of asset is being stolen, so some 
                           revenue is lost. This is amplified when media paints them in a negative light.
                           However, this is not why a data breach can be devastating. What if the data that 
                           was stolen included ", em("your personal information?"), " Now, private information is no longer 
                           private and can end up being sold, with your privacy violated. When a company is hit 
                           by a data breach, especially when the company handles sensitive information such as 
                           bank accounts, passwords, or health records, ", em("all consumers are impacted."))
               )
              )
      ),

      tabItem(tabName = "records",
              fluidPage(
                box(width = 12,
                h4("How do data breaches compare against each other?"),
                p("Below is a bubble chart designed to illustrate the magnititude of different data breaches
                  when compared both relatively and to all breaches as a whole. We see that especially as time
                  goes on, more and more records are being stolen during a breach as the world continues to obtain
                  data at an astonishing rate. However, there continues to be large amounts of variance in what 
                  sector is attacked or by which method. Hackers will use any means neccessary to breach!"),
                br(),
                plotlyOutput("bubble"),
                hr()
                ),
                fluidRow(
                  column(12, align = "center",
                         sliderInput("quantile", "Quantile:", min = 1, max = 16, value = 1, sep = "")
                  )
                )
              )
      ),
      
      tabItem(tabName = "map",
              fluidPage(
                fluidRow(
                  h4("Title"),
                  p("Description"),
                  br(),
                  plotlyOutput("heatMap", height="750px")
                )
              )
      ),
      
      tabItem(tabName = "types",
              fluidRow(
                box(width = 4,
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

                tabBox(width = 8,
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
      ),

      # last tab content
      tabItem(tabName = "year",
              fluidRow(
                box(width = 4,
                  sliderInput("obs", "Year:", min = 2004, max = 2017, value = 1, sep = "")
                ),

                tabBox(width = 8,
                  tabPanel("Data Sensitivity",
                           h4("Title"),
                           p("Description"),
                           br(),
                           plotlyOutput("pie")
                  ),
                  tabPanel("Leak Method",
                           h4("How has the information leak method changed throughout the years?"),
                           p("This pie chart shows how data has leaked throughout 2004 - 2017. As you see, progressingly, the leak method
                             becomes more varied. This shows that data breaches is developing at a rapid speed with new ways to hack into
                             data bases on the regular. In addition, in the more recent years, there has been a surge of hacking as a method
                             of data breach."),
                           br(),
                           plotlyOutput("distplot")
                  )
                )
              )
      )
    )
  )
)

shinyUI(my.ui)