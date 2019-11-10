
# This code takes data from the website TheLotusPavilion.com which includes games played
# Results are tallied to work out the win rate for each clan versus every other clan
# Barcharts are produced and saved

# Starting code
rm(list = ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","dplyr","tidyr","readr","purrr","tibble","psych","ggpubr","httr","jsonlite","lubridate", "gtools", "gridExtra", "png", "grid")

# User defined variables
startdate <- as.Date('2019-05-04')
enddate <- Sys.Date()
tournament_name <- "Winter Court 2019 - All Games"
tournament_id <- "4879"


# This contacts the Lotus Pavilion website and downloads every game 
# after the start date through the API
# The API  is https://thelotuspavilion.com/static/apidoc/v3.html
# Due to changes in the API only 50 results appear per page
# So we need to cycle through until we don't get a result anymore

options(stringsAsFactors = FALSE)
url  <- "http://thelotuspavilion.com"

page <- 1
finished <- 0
#path <- paste0("/api/v3/games?after=", startdate, "tournament_id=",tournament_id,"&page=")
path <- paste0("/api/v3/games?tournament_id=",tournament_id,"&page=")


# First Event
while (finished != 1) {
  print(page)
  path1 <- paste0(path,page)
  raw.result <- GET(url = url, path = path1)
  this.raw.content <- rawToChar(raw.result$content)
  if (this.raw.content == "[]") {
    finished <- 1
  }
  else {
    if (page == 1) {
      all_games <- fromJSON(this.raw.content)
    } else {
      new_games <- fromJSON(this.raw.content)
      all_games <- smartbind(all_games, fromJSON(this.raw.content))
      
    }
  }
  page <- page + 1
}
total_games <- all_games

# Second Event
tournament_id <- "4883"
path <- paste0("/api/v3/games?tournament_id=",tournament_id,"&page=")
page <- 1
finished <- 0
while (finished != 1) {
  print(page)
  path1 <- paste0(path,page)
  raw.result <- GET(url = url, path = path1)
  this.raw.content <- rawToChar(raw.result$content)
  if (this.raw.content == "[]") {
    finished <- 1
  }
  else {
    if (page == 1) {
      all_games <- fromJSON(this.raw.content)
    } else {
      new_games <- fromJSON(this.raw.content)
      all_games <- smartbind(all_games, fromJSON(this.raw.content))
      
    }
  }
  page <- page + 1
}
total_games <- rbind(total_games, all_games)

# Third Event
tournament_id <- "4906"
path <- paste0("/api/v3/games?tournament_id=",tournament_id,"&page=")
page <- 1
finished <- 0
while (finished != 1) {
  print(page)
  path1 <- paste0(path,page)
  raw.result <- GET(url = url, path = path1)
  this.raw.content <- rawToChar(raw.result$content)
  if (this.raw.content == "[]") {
    finished <- 1
  }
  else {
    if (page == 1) {
      all_games <- fromJSON(this.raw.content)
    } else {
      new_games <- fromJSON(this.raw.content)
      all_games <- smartbind(all_games, fromJSON(this.raw.content))
      
    }
  }
  page <- page + 1
}

# Adding this as top 32 cut didn't have stronghold names
library(gtools)
total_games <- smartbind(total_games, all_games)


all_games <- total_games

# remove cases where there is na, this includes Byes
games <- all_games[!is.na(all_games$p1_clan),]
games <- games[!is.na(games$p2_clan),]

# Remove games still in progress
games <- games[games$p1_points + games$p2_points != 0,]


# Option to look at a Date Range
# games$tournament_date <- as.Date(games$tournament_date,"%y-%m-%d")
# games <- games[games$tournament_date >= startdate & games$tournament_date <= enddate,]


# add winner
games$winner[games$p1_points > games$p2_points] <- games$p1_clan[games$p1_points > games$p2_points]
games$winner[games$p1_points < games$p2_points] <- games$p2_clan[games$p1_points < games$p2_points]


# This function takes in two clans returning the win rate of the first one
WinRate <- function(x,y) {
  total <- nrow(with(games, games[(games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x),]))
  wins <- nrow(with(games, games[((games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x)) & games$winner==x,]))
  if(x==y | total==0) 50 else 100 * wins / total
}

TotalPairs <- function(x, y) {
  # Take in the two clans x and y. Returns the total number of games with that pairing
  nrow(with(games, games[(games$p1_clan == x & games$p2_clan == y) | (games$p1_clan == y & games$p2_clan == x), ]))
}

# Clan Palette
clan_palette <- c("#6D5472", "#8C3D2E", "#B47741", "#AF9445", "#567C63", "#98AEAB", "#4C5660")

# This function takes in a clan name and a clan color and returns a chart
clanplot <- function(x, clancolor) {
  # Create a frame
  clan <- factor(c("Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn", "Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn"), levels = c("Unicorn","Scorpion", "Phoenix", "Lion", "Dragon", "Crane", "Crab"))
  rate <- c(WinRate(x, "Crab"), WinRate(x, "Crane"), WinRate(x, "Dragon"), WinRate(x, "Lion"), WinRate(x, "Phoenix"), WinRate(x, "Scorpion"), WinRate(x, "Unicorn"), WinRate("Crab", x), WinRate("Crane", x), WinRate("Dragon", x), WinRate("Lion", x), WinRate("Phoenix", x), WinRate("Scorpion", x), WinRate("Unicorn", x))
  clanpairs <- c(TotalPairs(x, "Crab"), TotalPairs(x, "Crane"), TotalPairs(x, "Dragon"), TotalPairs(x, "Lion"), TotalPairs(x, "Phoenix"), TotalPairs(x, "Scorpion"), TotalPairs(x, "Unicorn"))
  result <- c("Win", "Win", "Win", "Win", "Win", "Win", "Win", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss")
  windata <- data.frame(clan, rate, result, clanpairs)
  totalgames <- nrow(with(games, games[(games$p1_clan == x | games$p2_clan == x), ]))
  
  # Chart it all
  g <- ggplot(windata, aes(clan, rate))
  g + geom_bar(stat = "identity", aes(fill = clan)) +
    scale_x_discrete(breaks = c("Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn"), labels = clanpairs) +
    scale_fill_manual(values = clan_palette) +
    geom_bar(colour = "black", stat = "identity", fill = clancolor, aes(alpha = result)) +
    scale_alpha_manual(
      values = c(0, 1),
      name = "Win Rate",
      breaks = c("Win", "Loss"), # can use to set order
      labels = c("Win", "Loss")
    ) +
    theme_minimal() +
    xlab("") +
    ylab(paste0(totalgames, " games in total")) +
    ggtitle(paste0(x, " Clan")) +
    theme(legend.position = "none") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x = element_blank()) +
    geom_text(aes(label = paste0(round(rate), "%")), position = position_stack(vjust = 0.5), color = "white") +
    coord_flip()
}

# Logo
logo_png <- png::readPNG("logo.png")
logo <- rasterGrob(logo_png, interpolate=TRUE)


# Multiplot option
p1 <- clanplot('Crab','#4C5660')
p2 <- clanplot('Crane','#98AEAB')
p3 <- clanplot('Dragon','#567C63')
p4 <- clanplot('Lion','#AF9445')
p5 <- clanplot('Phoenix','#B47741')
p6 <- clanplot('Scorpion','#8C3D2E')
p7 <- clanplot('Unicorn','#6D5472')

multiplot <- arrangeGrob(p1, p2, p3, p4, p5, p6, p7, logo, nrow = 2, top=textGrob(tournament_name, gp=gpar(fontsize=20,font=3)))
ggsave("winrates.png", multiplot, width = 12, height = 6)

