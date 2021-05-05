#Install libraries
library(readr)
library(tidyverse)
library(ggplot2)
library(plyr)
library(plotly)
library(ggthemes)
library(scales)
library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)

diabetes <- read.csv("~/Shiny/FinalProject/diabetes.csv", stringsAsFactors = TRUE)

#DEFINE UI
ui <- fluidPage(
    sidebarLayout(
        mainPanel(
            plotlyOutput("finalPlot")
        ),
        
        sidebarPanel(
            selectInput(inputId = "Age",
                        label = h3("Age:"),
                        choices = diabetes$Age),
            sliderInput(inputId = "Glucose",
                        label = h3("Glucose Level:"),
                        min = min(diabetes$Glucose),
                        max = max(diabetes$Glucose),
                        value = 100),
            sliderInput(inputId = "Insulin",
                        label = h3("Insulin Level:"),
                        min = min(diabetes$Insulin),
                        max = max(diabetes$Insulin),
                        value = 300)
            )
            
            
        )
        
    ) #end of fluid page

    
  #------------------------------------------------------------------------------------------------------------------------   
    

#DEFINE SERVER

server <- function(input, output){
    
    output$finalPlot <- renderPlotly({

        plot <-  diabetes %>% filter(Glucose >= input$Glucose, Insulin >= input$Insulin) %>%

            ggplot(mapping = aes(x = Glucose, y = Insulin, color = Age)) + 
            geom_point(mapping = aes(size = Age)) +
            labs(title = "Level of Glucose and Insulin according to the Age",
                 color = "Age")
        
        ggplotly(plot)
        
    })
    
    
}

shinyApp(ui = ui, server = server)
