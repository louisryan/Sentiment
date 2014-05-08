library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)

dir = "C:/Users/lryan/Dropbox/Development/Python/Sentiment"
setwd(dir)
getwd()


test <- read.table("sentiment_data.csv", quote=",")
corpus <- Corpus(VectorSource(data))
corpus <- tm_map(corpus, function(x) iconv(x, to='UTF-8-MAC', sub='byte'))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, function(x) removeWords(x, stopwords("english")))

ap.tdm <- TermDocumentMatrix(corpus)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)

setwd('~/Documents/TwitterGoggles-master/WordCloud/Output')

pal2 <- brewer.pal(8,"Dark2")
filename <- paste("wordcloud", Sys.Date(), sep="_")
png(paste(filename, "png", sep="."), width=12,height=8, units='in', res=400)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,0.5),min.freq=3, max.freq=70,max.words=400, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()