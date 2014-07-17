library(shiny)
library(ggplot2)

red.wines   <- read.csv("winequality-red.csv", sep=";")
white.wines <- read.csv("winequality-white.csv", sep=";")
fit.red     <- lm(quality~sulphates+alcohol+volatile.acidity, red.wines)
fit.white   <- lm(quality~sulphates+alcohol+volatile.acidity, white.wines)

quality <- function(input) {
        round(predict(fit, data.frame(volatile.acidity=input$acidity, 
                                      sulphates=input$sulphates, 
                                      alcohol=input$alcohol))
              ,1)
}

shinyServer(
        function(input, output) {
                output$hist <- renderPlot({
                        if (input$type == 'white') {
                                wines <- white.wines
                                fit   <- fit.white
                                color <- "LightYellow"
                        } else {
                                wines <- red.wines
                                fit   <- fit.red
                                color <- "pink"
                        }
                        ggplot(wines, stat="bin", aes(x=quality)) + 
                                geom_bar(binwidth=1, fill=color) +
                                geom_vline(xintercept=quality(input),
                                           linetype=4, colour="black")
                })
                
                output$quality <- renderText({ paste("Wine Quality : ", quality(input)) })
        }
)