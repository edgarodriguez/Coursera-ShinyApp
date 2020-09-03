library(shiny)
library(drc)

shinyServer(function(input,output){
    
    model1 <- lm(ETa.HAM ~ P,data=data2)
    model2 <- drm(ETa.HAR ~ P, data=data2, fct=MM.2() )

    model1pred <- reactive({
        PInput <- input$sliderP
        predict(model1, newdata=data.frame(P = PInput))
    })
    
    model2pred <- reactive({
        PInput <- input$sliderP
        predict(model2, newdata=
                    data.frame(P=PInput))
    })
    output$plot1 <- renderPlot({
        PInput <- input$sliderP
        
        plot(data2$P,data2$ETa.AVG, xlab="Precipitation (mm)",
             ylab="Actual Evapotranspiration (mm)",bty="n",pch=16,xlim=c(10,2000),ylim=c(10,2000),
             col=rgb(red=0.2, green=0.2, blue=1.0, alpha=0.05))
        if(input$showModel1){
            abline(model1, col="red",lwd=2)
        }
        if(input$showModel2){
            model2lines <- predict(model2,newdata = data.frame(P=10:2000))
            lines(10:2000,model2lines, col="green",lwd=2)
        
        }
        legend(25,250,c("Model 1 Prediction","Model 2 Prediction"),pch=16,
               col= c("red","green"),bty="n",cex=1.2)
        points(PInput,model1pred(),col="red",pch=16,cex=2)
        points(PInput,model2pred(),col="green",pch=16,cex=2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    output$pred2 <- renderText({
        model2pred()
    })
    })

