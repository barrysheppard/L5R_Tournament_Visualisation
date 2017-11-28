install.packages(c("httr", "jsonlite", "lubridate"))
library("httr")
library("jsonlite")
library("lubridate")

options(stringsAsFactors = FALSE)

url  <- "http://api.fiveringsdb.com/"
path <- "/cards"
raw.result <- GET(url = url, path = path)
names(raw.result)
raw.result

head(raw.result$content)
this.raw.content <- rawToChar(raw.result$content)
nchar(this.raw.content)
substr(this.raw.content, 1, 100)
this.content <- fromJSON(this.raw.content)

class(this.content)
length(this.content)
this.content[[1]]
head(this.content[[1]])

cards <- this.content[[1]]

names(cards)


cards$name
cards$id

head(cards$type)

cards[cards$type=="character",]$name
cards[cards$type=="character",]$political
cards[cards$type=="character",]$military

names <- cards[cards$type=="character",]$name
political <- cards[cards$type=="character",]$political
military <- cards[cards$type=="character",]$military


estimatedcost <- 0.53 + 0.54*X + 0.42*Z











Getting Rulings.


cards$rulings <- NA

head(cards)






for (i in cards$id){

  i<-"togashi-yokuni"  
  cat("\n\nName:", i, "  \n")
  
  path <- paste("/cards/",i,"/rulings", sep="")
  ruling.result <- GET(url = url, path = path)
  this.ruling.content <- rawToChar(ruling.result$content)
  nchar(this.ruling.content)
  substr(this.ruling.content, 1, 100)
  this.ruling <- fromJSON(this.ruling.content)
  rulings <- this.ruling[[1]]

  cards[cards$id==i,]$rulings <-  paste(rulings$text,collapse="\n")
  
  cards[cards$id==i,]$rulings
  
  rulings$text
  
  cards[cards$id==i,]$rulings

  cards[cards$id==i,]
  
  
  
  
}


rules
cards[cards$id==i,]$rulings
