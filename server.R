library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse)
library(caret)
library(ggplot2)
library(rmarkdown)

server = function(input, output, session) {
  csvfile <- reactive({
    csvfile <- input$file1
    if (is.null(csvfile)){return(NULL)}
    dt <- read.csv(csvfile$datapath, header=input$header, sep=",")
    dt
  })
  
  output$var <- renderUI({
    if(is.null(input$file1$datapath)){return()}
    list (radioButtons("yvar", "Please pick dependent Variable (Y) (The variable should be binary in nature)", choices =    names(csvfile())),
          checkboxGroupInput("xvar", "Please pick independent Variables (X)", choices =    names(csvfile())),
          tags$br(),
          actionBttn(
            inputId = "submit",
            label = "Run Analysis!",
            color = "danger",
            style = "jelly"
          )
    )
  })
  
  output$regtab<- renderTable({
    if(is.null(input$file1$datapath)){return()}
    if(is.null(input$submit)){return()}
    if(input$submit > 0){
      input$reload
      Sys.sleep(2)
      d=as.data.frame(csvfile())
      y<-subset(d,select=input$yvar)
      x<-subset(d,select=input$xvar)
      data1<-cbind(y,x)
      colnames(data1)[1] <- "y"
      model <- glm(as.factor(data1$y)~., data = data1, family=binomial)
      sum<-summary(model)
      coeff<-as.data.frame(sum$coefficients)
      est<-coeff[,1]
      oddsratio<-exp(est)
      oddsratio[1]<-0
      final<-summary(model)$coef
      final1<-as.data.frame(cbind(final,oddsratio))
      colnam<-c("Estimate","Std.Error","z value","P-value","Odds ratio")
      colnames(final1)<-colnam
      final1
    }
  },digits=3,caption=('<b> Logistic Regression Analysis </b>'),bordered = TRUE,align='c',caption.placement = getOption("xtable.caption.placement", "top"),rownames = TRUE)
  
  output$text1<- renderUI({
    if(is.null(input$file1$datapath)){return()}
    if(is.null(input$submit)){return()}
    if(input$submit > 0){
      HTML(paste0("<b>"," Regression co-efficients with P-value <0.05 are significant (alpha = 0.05) ","</b>"))
      
    }  
    
  })
  
   
  
  
  output$text2<- renderUI({
    if(is.null(input$file1$datapath)){return(
      HTML(paste0("<b>"," Upload file by clicking Browse","</b>"))
      
    )}
    if(is.null(input$submit1)){return()}
    if(input$submit1 > 0){
      
      HTML(paste0("<b>"," You can save the image by right clicking on the image and then by selecting 'save image as' ","</b>"))
    } 
    
    
  })
  
  
  output$var2 <- renderUI({
    if(is.null(input$file1$datapath)){return()}
    if(is.null(input$submit)){return()}
    if(input$submit > 0){
      list( radioButtons("format", "Download report:", c("HTML", "PDF", "Word"),
                         inline = TRUE
      ),
      downloadButton("downloadReport") 
      )
      
    }
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste("my-report", sep = ".", switch(
        input$format, PDF = "pdf", HTML = "html", Word = "docx"
      ))
    },
    content = function(file) {
      src <- normalizePath("report.Rmd")
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, "report.Rmd", overwrite = TRUE)
      out <- render("report.Rmd", switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )  
  #############################################
  ############################### this note appear on opening
  output$note1<- renderUI({
    if(is.null(input$file1$datapath)){return(
      HTML(paste0(" <h4> To perform analysis using your own dataset, prepare excel file in csv format by reading instruction below  </h4>
<p>
<ui>
<li>Open a new blank excel file</li>
<li>Copy and paste observations into a new sheet (use only one sheet) of a new excel file</li>
<li>Observations should be pasted as columns </li>
<li>Independent variables (X) and dependent variable (Y) should be arranged as columns </li>
<li>Don't type or delete anything on other cells without data</li>
<li>You can use any names for your columns. No space is allowed in the Column name. If space is required use underscore ‘_’ or ‘.’ full stop; for example ‘Variable name’ should be written as Variable_name or Variable.name</li>
<li>Data should be arranged towards upper left corner and row above the data should not be left blank </li>
<li>Type 'NA' in the cell with no observation</li>
<li>Don't type and delete anything on other cells without data. If so select those cells, right click and click clear contents </li>
<li>Give names to all column, Don't add any unnecessary columns that is not required for analysis</li>
<li>Once all these are done, your file is ready. Now save it as CSV file. </li>
<li><b>Upload file by clicking browse in the app </b></li>
</ui>
</p>
<h5> You can download a model data set from below and test the App  </h5>
"))
    )}
    
    else{
      return()
    }
  })
  
  ############################## download data set
  output$data_set <- renderUI({
    if (is.null(input$file1$datapath)) {
      list(
        selectInput(
          "filenames", "Choose a dataset:",
          list.files(pattern = ".csv")
        ),
        downloadButton("downloadData", label = "Download csv file to test", class = "butt1")
      )
    }
    
    else {
      return()
    }
  })
  
  datasetInput <- reactive({
    switch(input$filenames,
           filenames
    )
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      input$filenames
    },
    content = function(file) {
      write.csv(read.csv
                (input$filenames, header = TRUE, sep = ","), file, row.names = FALSE)
    }
  )
  ######################### end data set download 
}