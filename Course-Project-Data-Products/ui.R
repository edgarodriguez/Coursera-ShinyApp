library(shiny)
library(drc)
data <- read.csv("LULC-BioclimaticParameters.csv", encoding = "UTF-8")
data2<-data

shinyUI(fluidPage(
    titlePanel("Data Products: Predict Evapotranspiration with Precipitation data in Yucatán Península, México"),
    sidebarLayout(
        sidebarPanel(
        sliderInput("sliderP", "What is the Precipitation?",10,2000, value=1100),
        checkboxInput("showModel1","show/hide Model1", value=TRUE),
        checkboxInput("showModel2","show/hide Model2", value=TRUE),
        ),                      
        mainPanel(
            plotOutput("plot1"),
            h4("Model1: Predict AET (Hamon Method) with lineal regression (lm function):"),
            textOutput("pred1"),
            h4("Model2: Predict AET (Hargreaves Method) with logistic regression (drc MM.2 funtion):"),
            textOutput("pred2")
        )
    )
))