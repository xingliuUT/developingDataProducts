
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(stringi)
library(ggplot2)
library(scales)
data <- read.csv('MER_T10_01.csv', na.strings = c("NA", "NaN", "", " ","Not Available"))
data <- data[complete.cases(data[,3]),]

year <- vector(mode="integer",length=nrow(data))
month <-  vector(mode="character",length=nrow(data))
for (i in 1:nrow(data)) {
  year[i] <- data$YYYYMM[i] %/% 100
  month[i] <- month.abb[data$YYYYMM[i] %% 100]
  if (is.na(month[i]) == 1) {
    month[i] = "SUM"
  }
}

data1 <- cbind(year, month, data)
data1$Value <- as.numeric(as.character(data1$Value))
data1$MSN <- NULL
data1$Unit <- NULL
data1$YYYYMM <- NULL

r <- with(data1, which(Column_Order < 4))
consumption <- data1[-r,]
consumption <- consumption[consumption$month == "SUM",]
sources <-  vector(mode="character",length=nrow(consumption))
for (i in 1:nrow(consumption)) {
   tempstr<- unlist(strsplit(as.character(consumption$Description[i]), " "))
   if (tempstr[1] == "Total") {
     sources[i] <- paste(tempstr[1], " ", tempstr[2])
   } else {
     sources[i] <- tempstr[1]
   }

}
consumption <- cbind(consumption,sources)
consumption$Description <- NULL

sourceTypes <- unique(consumption$sources)

shinyServer(function(input, output) {
  
  output$chooseSources <- renderUI({
    checkboxGroupInput("sourceSelected", label = h4("Source Types"), 
                       choices = sourceTypes, selected = sourceTypes[9])
  })
  consumptionbySource <- reactive(
    consumption[consumption$year >= input$yearRange[1] & 
                consumption$year <= input$yearRange[2]& 
                as.character(consumption$sources) %in% input$sourceSelected,]
  )

  output$yearlyConsumption <- renderPlot({
    ggplot(consumptionbySource(),
           aes(x = year, y = Value)) +
      geom_line(aes(color = sources), size = 2) +
      xlab("Year") + ylab("Consumption (Trillion Btu)") +
      guides(col = guide_legend(ncol = 4)) +
      theme(legend.position = "bottom", 
          legend.title = element_blank(),
          legend.text = element_text(colour = "black", size = 16, face = "bold"),
          axis.text.x = element_text(size = 16, face = "bold"),
          axis.text.y = element_text(size = 16, face = "bold"),
          axis.title.x = element_text(size = 16, face = "bold"),
          axis.title.y = element_text(size = 16, face = "bold"))
  })

  consumptionbyYear <- reactive(
    consumption[consumption$year == input$yearSelected & 
                  consumption$Column_Order < 11,]
  )

  output$text2 <- renderText({
    paste("Year = ",input$yearSelected)
  })

  output$dataThisYear <- renderDataTable({
    thisyear <- consumptionbyYear()[,c(5,3)]
    for (i in nrow(thisyear)) {
      thisyear$Value <- percent(thisyear$Value / sum(thisyear[2]))
    }
    thisyear
  }, options = list(bFilter = FALSE))

  output$barGraphbyYear <- renderPlot({
    ggplot(data = consumptionbyYear(), 
           aes(x = "", y = Value, 
               fill = sources)) +
      geom_bar(stat = "identity") +
      theme(legend.position = "bottom", axis.text.x = element_blank()) +
      coord_polar("y",start = 0) +
      scale_fill_brewer(palette = "Dark2")+
      guides(col = guide_legend(ncol = 4)) +
      theme(legend.position = "bottom", 
            legend.title = element_blank(),
            legend.text = element_text(colour = "black", size = 16, face = "bold"),
            axis.title = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            axis.ticks = element_blank())
  })
  
  output$data1 <- renderDataTable({
    consumption
  }, options = list(bFilter = FALSE, iDisplayLength = 50))

})
