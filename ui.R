
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  navbarPage("US Renewable Energy Consumption",
    tabPanel("By source",
      h3("Time History of Yearly Renewable Energy Consumption by Source"),
      sidebarPanel(
        width = 4,
        sliderInput("yearRange", label = h4("Years"), min = 1949,
                    max = 2016, value = c(1949,2010)),
        uiOutput("chooseSources")
      ),
      mainPanel(
        fluidRow(
          column(12,
                 plotOutput("yearlyConsumption", height = "580px")
          )
        )
        
      )
    ),
    tabPanel("By year",
      h3("Percentage Consumption of Each Renewable Source in a Given Year"),
      sidebarPanel(
        width = 4,
        fluidRow(
          column(12,
            numericInput("yearSelected", label = h4("Select Year"), value = 2010,
                       min = 1949, max = 2016)
          )
        ),
        fluidRow(
          column(12,
            dataTableOutput(outputId = "dataThisYear")
          )
        )
      ),
      mainPanel(
        fluidRow(
          column(12,
                 plotOutput("barGraphbyYear", height = "580px")
          )
        )
      )
    ),
    tabPanel('About', mainPanel(includeMarkdown("Readme.Rmd")))
  )
)
)
