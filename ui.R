library(shiny)

shinyUI(
        pageWithSidebar(
                headerPanel("Wine Quality Predictor"),
                sidebarPanel(
                        h3("Wine attribute"),
                        radioButtons(inputId='type', label='Type of wine', 
                                    choices=c('red', 'white'), selected='red', inline=T),
                        sliderInput(inputId='acidity', label='Volatile acidity', 
                                    min=0.1, max=1.6, value=0.52),
                        sliderInput(inputId='sulphates', label='Sulphates',
                                     min=0.3, max=2.1, value=0.65),
                        sliderInput(inputId='alcohol', label='Alcohol', 
                                    min=8, max=16, value=10.42)
                ),
                mainPanel(
                        p("The following diagram represents the distribution of the quality of red and white variants of the Portuguese \"Vinho Verde\" wine.",
                          "We have tested 1599 red wines and 4898 white wines.",
                          "The quality is based on sensory data (median of at least 3 evaluations made by wine experts)."),
                        p("To predict the quality of your \"Vinho Verde\" wine, please fill the attributes in the left panel.",
                          "Wine has many attributes but, in our study, these attributes are 4 variables that most influence the quality of a \"Vinho Verde\" wine."),
                        p("The predicted quality of your wine will be displayed bellow.",
                          "The dashed line on the histogram positions your wine in the distribution of the wines of the same type (red or white)"),
                        h3(textOutput('quality'), align = "center"),
                        plotOutput('hist')
                )
        )
)