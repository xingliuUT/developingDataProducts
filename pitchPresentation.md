US Renewable Energy Consumption
========================================================
author: Xing Liu
date: 4/8/2017
font-family: "Georgia"
class: small

- This presentation is part of the course project of [Developing Data Products](https://www.coursera.org/learn/data-products/) on Coursera . It describes a shiny [application](https://xingliuut.shinyapps.io/shinyapp/) that visualizes the yearly renewable energy consumption in the US. 

- The source code is in GitHub [repo](https://github.com/xingliuUT/developingDataProducts).

Load and Clean Data
========================================================
incremental: true
class: small

- After downloading the data from [EIA website](https://www.eia.gov/totalenergy/data/monthly/#renewable), load it in R and clean up the data. 


```r
data <- read.csv('MER_T10_01.csv', na.strings = c("NA", "NaN", "", " ","Not Available"))
data <- data[complete.cases(data[,3]),]
```

- Omitting long and tedious data cleaning code, the summary of the final data is as follows.

```r
summary(consumption)[,-2]
```

```
      year          Value            Column_Order   
 Min.   :1949   Min.   :    0.009   Min.   : 4.000  
 1st Qu.:1974   1st Qu.:  175.545   1st Qu.: 5.000  
 Median :1990   Median : 1440.487   Median : 8.000  
 Mean   :1988   Mean   : 1859.108   Mean   : 8.109  
 3rd Qu.:2003   3rd Qu.: 2817.633   3rd Qu.:11.000  
 Max.   :2016   Max.   :10159.578   Max.   :12.000  
                                                    
              sources   
 Hydroelectric    : 68  
 Total   Biomass  : 68  
 Total   Renewable: 68  
 Wood             : 68  
 Geothermal       : 57  
 Waste            : 47  
 (Other)          :103  
```

Source Code: Two Interactive Plots
========================================================
type: prompt
class: small

- The first interactive plot is for total consumption of one or more renewable energy sources versus year. 




```r
p1 <- ggplot(consumption1, aes(x = year, y = Value)) +
      geom_line(aes(color = sources), size = 2) +
      xlab("Year") + ylab("Consumption (Trillion Btu)") +
      guides(col = guide_legend(ncol = 4)) +theme(legend.position = "bottom", 
      legend.title = element_blank(),
      legend.text = element_text(colour = "black", size = 16, face = "bold"),
      axis.text.x = element_text(size = 16, face = "bold"),
      axis.text.y = element_text(size = 16, face = "bold"),
      axis.title.x = element_text(size = 16, face = "bold"),
      axis.title.y = element_text(size = 16, face = "bold"))
```
- The second is a pie chart for percentage of various renewable energy sources in a given year.


```r
p2 <- ggplot(data = consumption2, aes(x = "", y = Value, fill = sources)) +
      geom_bar(stat = "identity") +
      theme(legend.position = "bottom", axis.text.x = element_blank()) +
      coord_polar("y",start = 0) + scale_fill_brewer(palette = "Dark2")+
      guides(col = guide_legend(ncol = 4)) +
      theme(legend.position = "bottom", legend.title = element_blank(),
            legend.text = element_text(colour = "black", size = 16, face = "bold"),
            axis.title = element_blank(), panel.border = element_blank(),
            panel.grid = element_blank(), axis.ticks = element_blank())
```
First Plot: Time History of Yearly Consumption by Source
========================================================
type: sub-session
class: small

<img src="pitchPresentation-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" width="400px" height="400px" style="display: block; margin: auto;" />
- <span style="color:blue"> Users could custimize the range of the year as well as the types of renewable energy sources they are interested to find out.</span>

Second Plot: Percentage Consumption in a Given Year
========================================================
type: sub-session
class: small

<img src="pitchPresentation-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="400px" height="400px" style="display: block; margin: auto;" />
- <span style="color:blue"> Users specify a year to generate a pie chart that helps visualize the percentage consumption of each renewable energy.</span>
