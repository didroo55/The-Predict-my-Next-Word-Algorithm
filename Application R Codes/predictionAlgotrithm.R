#Creating connection to Twitter data from Swift Key Corp.

cleanconnectionTwitter <- file("en_US.twitter.txt")
twitterData <- readLines(connectionTwitter, encoding = "UTF-8", skipNul = TRUE)
close(connectionTwitter)


#Creating connection to Blog data from Swift Key Corp.
connectinBlog <- file("en_US.blogs.txt",open="r")
lineBlogs <- readLines(connectinBlog) 
close(connectinBlog)

#Creating connection to News data from Swift Key Corp.
connectionNews <- file("en_US.news.txt",open="r")
newsData <- readLines(connectionNews)
close(connectionNews)

#Loading the R Text Mining Pakcage
library(tm)
nLines<-5000


tempVevtor<-vector('character')

#Creating a character vector of lines from Twittwe, Blog and News Data
tempIndex <-sample(twitterData, nLines, replace=FALSE)
tempVevtor <- c(tempVevtor,tempIndex)

tempIndex<-sample(lineBlogs, nLines, replace=FALSE);
tempVevtor <- c(tempVevtor,tempIndex)

tempIndex<-sample(newsData, nLines, replace=FALSE);
tempVevtor <- c(tempVevtor,tempIndex)

#Removing source data from environment
rm(twitterData)
rm(lineBlogs)
rm(newsData)

#Creating a courpus from the character vector. This will be used by the text mining package to clean and tockenize data
corpus<-VCorpus(VectorSource(tempVevtor))

#Cleaning Data
corpus<-tm_map(corpus, removeNumbers);
corpus<-tm_map(corpus, removePunctuation, preserve_intra_word_dashes=TRUE);
corpus<-tm_map(corpus, stripWhitespace);
rm(tempVevtor)

#Creating data frame with a line in each row. This is done to supply the data frame to the tockenizing functions
cleanData <- data.frame(rawtext = sapply(corpus, as.character), stringsAsFactors=FALSE)
rm(corpus)
cleanData$textLines <- iconv(cleanData$rawtext, 'UTF-8', 'ASCII')
cleanData$textLines <- tolower(cleanData$textLines)
cleanData <- cleanData[!is.na(cleanData$textLines),]

#Loading tockenizers package
library(tokenizers)

#NGram 1
tokens <- tokenize_ngrams(cleanData$textLines,n=1,n_min = 1)
tokenTable <- table(unlist(tokens))
ngramOne <- data.frame(tokenTable)
ngramOne <- ngramOne[order(ngramOne$Freq,decreasing = TRUE),]


#NGram 2
tokens <- tokenize_ngrams(cleanData$textLines,n=2,n_min = 2)
tokenTable <- table(unlist(tokens))
ngramTwo <- data.frame(tokenTable)
ngramTwo <- ngramTwo[order(ngramTwo$Freq,decreasing = TRUE),]


#NGram 3
tokens <- tokenize_ngrams(cleanData$textLines,n=3,n_min = 3)
tokenTable <- table(unlist(tokens))
ngramThree <- data.frame(tokenTable)
ngramThree <- ngramThree[order(ngramThree$Freq,decreasing = TRUE),]



#NGram 4
tokens <- tokenize_ngrams(cleanData$textLines,n=4,n_min = 4)
tokenTable <- table(unlist(tokens))
ngramFour <- data.frame(tokenTable)
ngramFour <- ngramFour[order(ngramFour$Freq,decreasing = TRUE),]







