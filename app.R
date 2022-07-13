#install.packages("randomForest")
#install.packages("RCurl")
#install.packages("data.table")
#install.packages("shiny")
#install.packages("shinythemes")
#install.packages("dplyr")

library(randomForest)
library(RCurl)
library(data.table)
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)


#https://shiny.rstudio.com/tutorial/


ui <- fluidPage(  #this creates the structure for our web app
 # titlePanel("Pokemon Data Findings"), 
  navbarPage(
    "Data about pokemon",   #This is the page title
    
    tabPanel('Fire Pokemon',
             sidebarPanel(
               tags$h3("Input:"),
               textInput("txt1", "First Name:",""),
               textInput("txt2", "Last Name:",""),
             ),
             mainPanel(
               h1("This is important info"),
               h4("This is subtext"),
               verbatimTextOutput("txtout"),
               plotOutput(outputId="firePokemon")
             )
             ),
    
    tabPanel('Water Pokemon',
             sidebarPanel(
               tags$h3("Input:"),
               textInput("txt1", "First Name:",""),
               textInput("txt2", "Last Name:",""),
             ),
             mainPanel(
               h1("This is going to be about water pokemon"),
               h4("They are great"),
              # verbatimTextOutput("txtout"),
             #  plotOutput(outputId="waterPokemon")
             )
    ),
  )

)

server<- function(input, output){
  Pokemon <- read.csv("C:/Users/terra/projects/ColumbiaUniversity/Shiny-Display-Example/pokemon.csv")
  Pokemon %>% filter(Pokemon$Type.1 =="Fire")->fire_pokemon
  
  output$firePokemon <- renderPlot({
    ggplot(data=fire_pokemon, aes(x=HP))+geom_histogram(fill="red")
  })
    
  output$txtout <- renderText({
    paste(input$txt1, input$txt2, sep = " ")
  })
}

shinyApp(ui = ui, server = server)