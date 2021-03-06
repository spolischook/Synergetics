#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source('qmap.R')
library(shiny)

MAX_TRACE <- 1000

# Define UI for application that draws a histogram
ui <- fluidPage(
    withMathJax(),
   # Application title
   titlePanel("Find the value of Feigenbaum equation"),
    tags$h3("\\(x_{n+1} = \\lambda x_{n}(1-x_{n})\\)"),

   # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            tags$h3("Predefined Lambda"),
            actionButton("second", "3.222"),
            actionButton("three", "3.832"),
            actionButton("four", "3.543"),
            actionButton("five", "3.74"),
            actionButton("eight", "3.56"),
            hr(),
            sliderInput("lambda",
                "Lambda:",
                min = 0,
                max = 4,
                step = 0.001,
                value = 2.923,
                animate =
                    animationOptions(interval = 0.01, loop = TRUE)),
            numericInput("lambda_v",
                "Lambda value:",
                value = 2.923),
                sliderInput("x0",
                "Starting X:",
                min = 0,
                max = 1,
                step = 0.001,
                value = 0.2),
            sliderInput("trace_length",
                "Trace length:",
                min = 0,
                max = MAX_TRACE,
                step = 1,
                value = 400),
            sliderInput("burn_in",
                "Trace start from:",
                min = 0,
                max = MAX_TRACE,
                step = 1,
                value = 280)
        ),


        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

   output$distPlot <- renderPlot({
     q_map(input$lambda_v, input$x0, input$trace_length, burn_in=input$burn_in)
   })

    observeEvent(input$second, {
        updateLambda(3.222)
    })

    observeEvent(input$three, {
        updateLambda(3.832)
    })

    observeEvent(input$four, {
        updateLambda(3.543)
    })

    observeEvent(input$five, {
        updateLambda(3.74)
    })

    observeEvent(input$eight, {
        updateLambda(3.56)
    })

   observe({
       updateSliderInput(
         session = session,
         inputId = "lambda_v",
         value = input$lambda
       )
   })
   observe({
     if (input$trace_length <= input$burn_in) {
        updateSliderInput(
           session = session,
           inputId = "burn_in",
           value = input$trace_length - 5
        )
     }
   })

    updateLambda <- function (l) {
        updateSliderInput(
         session = session,
         inputId = "lambda_v",
         value = l
       )
        updateSliderInput(
         session = session,
         inputId = "lambda",
         value = l
       )
    }
}

# Run the application 
shinyApp(ui = ui, server = server)
