#
#This is the server for the Predict the next word algorithm. This gets data, accesses prediction R Code and returns the predicted word
#
# 
#

#Loading the required pakcages
library(shiny)
library(tm)
library(stringr)
library(stylo)

#Loading the predcition function
source("predictionModel.R")

# Define server logic required to predict next word
shinyServer(function(input, output) {

  
  output$html1 <- renderUI({
    
    inputText <- input$text1
    #Clean Input form user - using cleanInput function defined in predictionModel.R package
    inputText <- cleanInput(inputText)
    #Predict next word - using predictNextWord function defined in predictionModel.R package
    prediction <- predictNextWord(inputText)
    
  
    #Inisitalizing prediction
    str1 <- "Predicted word(s): "
    
    str2 <- ""
    
    for(i in 1:length(prediction))
    {
      if(!is.na(prediction[i]))
      {
        
        if(prediction[i] == "Why dont you Enter something???")
        {
          str2 <-paste(str2, "<span style= color:green>",h4("The model is up and running. Why dont you Enter something???", align = "left"), "</span>")
          str1 <- ""
        }
        else if(prediction[i] == "Oops!!! unfortunately  I was not able to make sense of what you told me"){
          str2 <-paste(str2, "<span style= color:red>",h4(prediction[i],align = "left"), "</span>")
          str1 <- ""
        }
        else{
        prediction[i] <- paste(i,". ", prediction[i])
        str2 <- paste(str2, h4(prediction[i], align = "left"), "</span>")
        }
      }
    }
    str1 <- h4(str1, align = "left")
    HTML(paste(str1, str2))
  })
  
  

  
})
