#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source('logisticMap.R')
library(shiny)

ui <- fluidPage(
    # Application title
    titlePanel("Build logistic map of Feigenbaum equation"),
    withMathJax(),
    tags$h3("\\(x_{n+1} = \\lambda x_{n}(1-x_{n})\\)"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("start",
                "Start:",
                min = 0,
                max = 4,
                step = 0.01,
                value = 2.98),
            sliderInput("end",
                "End:",
                min = 0,
                max = 4,
                step = 0.01,
                value = 4),
            sliderInput("frequency",
                "Step:",
                min = 0.0001,
                max = 0.1,
                step = 0.0005,
                value = 0.002),
            sliderInput(
                "iterations",
                "Iterations:",
                min = 0,
                max = 1000,
                value = c(990, 1000))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

server <- function(input, output, session) {
    output$distPlot <- renderPlot({
        logisticDistribution(input$start, input$end, input$frequency, input$iterations)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
