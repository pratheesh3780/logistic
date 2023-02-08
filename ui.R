library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse)
library(caret)
library(ggplot2)
library(rmarkdown)

ui <- fluidPage(
  setBackgroundColor(
    color = c("#e5e8b0", "#f2ec9b"),
    gradient = "radial",
    direction = c("bottom", "right")
  ),
  titlePanel(tags$div(tags$b('Logistic Regression Analysis'),style="color:#360a02")),
  
                      sidebarPanel(
                        fileInput("file1", "CSV File (upload in csv format)", accept=c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                        checkboxInput("header", "Header", TRUE),
                        uiOutput('var'),
                        tags$br(),
                        conditionalPanel("$('#regtab').hasClass('recalculating')", 
                                         tags$div(tags$b('Loading ...please wait while we are calculating in the background.....please dont press submit button again '), style="color:green")),
                        tags$br(),
                        h5(
                          tags$div( 
                            "Developed by:",
                            tags$br(),
                            h3(""),
                            tags$b("Dr. Pratheesh P. Gopinath"),
                            tags$br(),
                            tags$b("Assistant Professor"),
                            tags$br(),
                            tags$b("Agricultural Statistics"),
                            tags$br(),
                            tags$b("Kerala Agricultural University"),
                            tags$br(),
                            h3(""),
                            "post your queries at: grapescoa@gmail.com"
                            ,style="color:#343aeb") 
                        )
                        
                      ),
                      mainPanel( 
                        tabsetPanel(type = "tab",
                                    tabPanel("Analysis",
                        conditionalPanel("$('#regtab').hasClass('recalculating')", 
                                         tags$div(tags$b('Loading ...please wait while we are calculating in the background.....please dont press submit button again '), style="color:green")),
                        htmlOutput('note1'),
                        uiOutput('data_set'),# for data set download
                        tableOutput('regtab'),
                        htmlOutput('text1'),
                        tags$br(),
                        tags$br(),
                        tableOutput('regtab1'),
                        tags$br(),
                        tags$br(),
                        uiOutput('var2')
                      ),
             
             tabPanel(tags$b("Plots and Graphs"),
                      sidebarPanel( uiOutput('var1')),
                      mainPanel(tags$br(),
                                plotOutput('regplot')%>% withSpinner(color="#0dc5c1")),
                      tags$br(),
                      htmlOutput('text2')
             ),
             
             tabPanel(tags$b("Read me"),
                      htmlOutput('text3')
             ) 
             
             
             
                        )
             
)
)



