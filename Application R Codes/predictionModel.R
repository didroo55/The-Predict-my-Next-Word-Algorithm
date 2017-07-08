#The program consumes ngram tables and computes the predicted work to match the user input.


#Consuming ngram databases 
ngramFour <- readRDS("./data/ngramFourFinal.rds")
ngramThree <- readRDS("./data/ngramThreeFinal.rds")
ngramTwo <- readRDS("./data/ngramTwo.rds")


#Setting up Environment
library(stringr)
library(dplyr)
library(tm)
library(stylo)



#Predict next word Function takes in the input variable from user and predicts the next word
predictNextWord <- function(input)
{
  
  #Cleaning the input
  wordInput <- cleanInput(input)
  #Getting the number of words in the input
  wordCount <- length(wordInput)
  #Initializing response
  prediction <- c()
  
  #Trimming input to the last three words
  if(wordCount>3)
  {
    wordInput <- wordInput[(wordCount-2):wordCount]
    prediction <- matchinFourGranm(wordInput[1],wordInput[2],wordInput[3])
  }
  
  #Four Gram Match
  if(wordCount ==3)
  {
    prediction <- matchinFourGranm(wordInput[1],wordInput[2],wordInput[3])
  }
  
  #Three Gram Match
  if(wordCount ==2)
  {
    prediction <- matchThreeGram(wordInput[1],wordInput[2])
  }
  #Two gram match
  if(wordCount ==1)
  {
    prediction <- matchTwoGram(wordInput[1])
  }
  
  #No word entered
  if(wordCount == 0)
  {
    prediction <- "Why dont you Enter something???"
  }
  
  #Unknown words
  if(length(prediction)==0)
  {
    prediction <- "Oops!!! unfortunately  I was not able to make sense of what you told me"
  }
  
  #Returning response
  if(length(prediction) < 5)
  {
    prediction
  }
  else
  {
    prediction[1:5]
  }
  
  
}



#Cleaning input to extract specific words
cleanInput <- function(text){
  textInput <- tolower(text)
  textInput <- removePunctuation(textInput)
  textInput <- removeNumbers(textInput)
  textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
  textInput <- stripWhitespace(textInput)
  textInput <- txt.to.words.ext(textInput, language="English.all", preserve.case = TRUE)
  return(textInput)
}





#Match string in Four Gram and get probable word
matchinFourGranm <- function (inputWord1,inputWord2,inputWord3)
  
{
predictWord <- filter(ngramFour,(word1 == inputWord1 & word2 == inputWord2 & word3 == inputWord3))$word4
if(length(predictWord) == 0)
{
  
  predictWord <- filter(ngramFour,( word2 == inputWord2 & word3 == inputWord3))$word4
  if(length(predictWord) == 0)
  {
    predictWord <- filter(ngramFour,( word1 == inputWord2 & word2 == inputWord3))$word3
    
    
    if(length(predictWord) ==0)
    {
      predictWord <- matchThreeGram(inputWord2,inputWord3)
    }
    
  }

}

predictWord

}



#Match string in Three Gram and get probable word
matchThreeGram <- function(inputWord1,inputWord2)
{
predictWord <- filter(ngramThree,( word1 == inputWord1 & word2 == inputWord2))$word3
if(length(predictWord)==0)
{
  predictWord <- filter(ngramThree,(word2 == inputWord2))$word3 
  
  if(length(predictWord)== 0)
  {
    predictWord <- filter(ngramThree,(word1 == inputWord2))$word2 
    
    if(length(predictWord) ==0 )
    {
      predictWord <- matchTwoGram(inputWord2)
    }
    
  }
}
predictWord
}

#Match string in Two Gram and get probable word
matchTwoGram <- function(inputWord1)
{
  predictWord <- filter(ngramTwo,( word1 == inputWord1 ))$word2
  
  predictWord
  
}










