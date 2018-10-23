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

   # Application title
   titlePanel("Find the value of Feigenbaum equation"),

   # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("lambda",
                "Lambda:",
                min = 0,
                max = 4,
                step = 0.001,
                value = 2.923),
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
}

# Run the application 
shinyApp(ui = ui, server = server)
