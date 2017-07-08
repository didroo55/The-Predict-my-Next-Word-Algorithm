#
#This is the User interface for the "Predict the Next WOrd Application"
# 
#   
#

#Loading necessary Pakcages
library(shiny)
library(shinythemes)

#Define Fluid Page
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The 'Predict Next Word' Algorithm by Satish Hariharan"),
  
  #navbarpage
  navbarPage("Predict Next Word",
             
  tabPanel("Application",
             
  # Sidebar layout with an option to enter text and description of how to use the application
  sidebarLayout(
    sidebarPanel(
      textInput(inputId="text1", label = "Please enter your text here: ", value =""),
      h4("The Algorithm", style = "color:brown"),
      p("Please go to the tab 'ReadMe' for a description of the algorithm used"),
      h4("How to have fun with this", style = "color:brown"),
      p("1. Wait for the message that the model is up and running. It might take 10-15 seconds for the first time. "),
      p("2. Start with typing a couple of words in the message box above."),
      p("3. Based on the words you enter the algorithm predicts the next word of your potential sentence. Click the read me tab for the description of prediction model"),
      p("4. Continue typing by choosing one of the predicted words."),
      p("4. Repeat Steps #3 and #4 by entering adding more words and form random sentences."),
      h4("Creation and Maintainance", style = "color:brown"),
      p("Satish Hariharan, satish181990@gmail.com"),
      h4("Bugs", style = "color:brown"),
      p("Email satish181990@gmail.com")
      
    ),
    
    
    
    # Main pannel to show the predicted word
    mainPanel(
      
      h4("Do you have a recommendation? Email satish181990@gmail.com with a description.",style ="color:red"),
      h5("NOTE : You might have to give 15 seconds to the application for the first time. Start rolling once you see the message that its ready below",style ="color:black"),
      h1( " "),
      h1( " "),
      h1( " "),
      h1( " "),
      h1( " "),
      htmlOutput("html1")
    )
  )
  ),#End of tabpanel
  tabPanel("Read Me",
           mainPanel(
             includeMarkdown("howThisWorks.md")
             
           ) # mainPanel
  ) # end of "Read Me" tabPanel
  
  
  )#End of navbar
))
