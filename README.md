---
title: "Untitled"
author: "Xing Liu"
date: "4/5/2017"
output: html_document
---

### Background
The shiny application is developed as the course project of [Developing Data Products](https://www.coursera.org/learn/data-products/) on Coursera.

I design the application to visualize the yearly renewable energy consumption in the US starting from the year 1949 until 2016. The data comes from the [U.S. Energy Information Administration](https://www.eia.gov/totalenergy/data/monthly/#renewable).

### Web App
The web application is available [here](https://xingliuut.shinyapps.io/shinyapp/).

On the first page, users could customize the line plots of total consumption of one or more renewable energy sources in the unit of trillion Btu (British thermal unit) versus year. This is done by choosing from the slider the year range of interest and from the check boxes the particular energy sources, for example, solar, wind, biofuels etc.

On the second page, users specify a year to generate a table with various renewable energy sources and their corresponding consumption percentage in that year. On the main panel of the page, there's a pie chart that helps visualize the percentage consumption of each renewable energy.

### Presentation
A presentation written in R presentation could be found [here](http://rpubs.com/xl3676/DevelopingDataProducts).

### Source code
The source code for R Shiny Application is in files `server.R` and `ui.R`. 

The source code for R presentation is in files `PitchPresentation.css` and `pitchPresentation.md`.


