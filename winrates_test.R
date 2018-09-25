
# This code takes data from the website TheLotusPavilion.com which includes games played
# Results are tallied to work out the win rate for each clan versus every other clan
# Barcharts are produced and saved

# Starting code
rm(list = ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","dplyr","tidyr","readr","purrr","tibble","psych","ggpubr","httr","jsonlite","lubridate")


# User defined variables
startdate <- as.Date('2018-07-13')
enddate <- Sys.Date()
tournament_name <- "Houston Kotei"
tournament_id <- 1885


# This contacts the Lotus Pavilion website and downloads every game 
# after the start date through the API
# The API  is https://thelotuspavilion.com/static/apidoc/v3.html
# Due to changes in the API only 50 results appear per page
# So we need to cycle through until we don't get a result anymore

options(stringsAsFactors = FALSE)
url  <- "http://thelotuspavilion.com"

page <- 1
finished <- 0
path <- paste0("/api/v3/games?tournament_id=",tournament_id,"&page=")


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
      all_games <- rbind(all_games, fromJSON(this.raw.content))

    }
  }
  page <- page + 1
}



# remove cases where there is na, this includes Byes
games <- all_games[complete.cases(all_games),]

# Remove games still in progress
games <- games[games$p1_points + games$p2_points != 0,]


# Date Range
# games$tournament_date <- as.Date(games$tournament_date,"%y-%m-%d")
# games <- games[games$tournament_date >= startdate & games$tournament_date <= enddate,]



# add winner
games$winner[games$p1_points > games$p2_points] <- games$p1_clan[games$p1_points > games$p2_points]
games$winner[games$p1_points < games$p2_points] <- games$p2_clan[games$p1_points < games$p2_points]


# This function takes in two clans returning the win rate of the first one
WinRate <- function(x,y) {
  total <- nrow(with(games, games[(games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x),]))
  wins <- nrow(with(games, games[((games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x)) & games$winner==x,]))
  if(x==y) 50 else 100 * wins / total
}


TotalPairs <- function(x, y) {
  # Take in the two clans x and y. Returns the total number of games with that pairing
  nrow(with(games, games[(games$p1_clan == x & games$p2_clan == y) | (games$p1_clan == y & games$p2_clan == x), ]))
}


# Clan Palette
clan_palette <- c("#4C5660","#98AEAB", "#567C63", "#AF9445", "#B47741", "#8C3D2E", "#6D5472")

# This function takes in a clan name and a clan color and returns a chart
clanplot <- function(x, clancolor) {
  # Create a frame
  clan <- factor(c("Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn", "Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn"), levels = c("Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn"))
#  clan <- c("Unicorn", "Scorpion", "Phoenix", "Lion", "Dragon", "Crane", "Crab", "Unicorn", "Scorpion", "Phoenix", "Lion", "Dragon", "Crane", "Crab")
  
  rate <- c(WinRate(x, "Crab"), WinRate(x, "Crane"), WinRate(x, "Dragon"), WinRate(x, "Lion"), WinRate(x, "Phoenix"), WinRate(x, "Scorpion"), WinRate(x, "Unicorn"), WinRate("Crab", x), WinRate("Crane", x), WinRate("Dragon", x), WinRate("Lion", x), WinRate("Phoenix", x), WinRate("Scorpion", x), WinRate("Unicorn", x))
#  clanpairs <- c(TotalPairs(x, "Crab"), TotalPairs(x, "Crane"), TotalPairs(x, "Dragon"), TotalPairs(x, "Lion"), TotalPairs(x, "Phoenix"), TotalPairs(x, "Scorpion"), TotalPairs(x, "Unicorn"))
  clanpairs <- c(TotalPairs(x, "Unicorn"), TotalPairs(x, "Scorpion"), TotalPairs(x, "Phoenix"), TotalPairs(x, "Lion"), TotalPairs(x, "Dragon"), TotalPairs(x, "Crane"), TotalPairs(x, "Crab"))
  result <- c("Win", "Win", "Win", "Win", "Win", "Win", "Win", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss")
  windata <- data.frame(clan, rate, result, clanpairs)
  totalgames <- nrow(with(games, games[(games$p1_clan == x | games$p2_clan == x), ]))

  # Chart it all
 g <- ggplot(windata, aes(clan, rate))
 g + geom_bar(stat = "identity", aes(fill = clan)) +
    scale_x_discrete(breaks = c("Unicorn", "Scorpion", "Phoenix", "Lion", "Dragon", "Crane", "Crab"), labels = clanpairs) +
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
    ylab(paste0(tournament_name, ", ", totalgames, " games in total")) +
    ggtitle(paste0(x, " Clan Win Rate")) +
    theme(legend.position = "none") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x = element_blank()) +
    #    theme(axis.text.y = element_blank()) +
    geom_text(aes(label = paste0(round(rate), "%")), position = position_stack(vjust = 0.5), color = "white") +
    coord_flip()
}




clanplot('Crab','#4C5660')
ggsave("winrate_crab.png",width = 4, height = 4)
clanplot('Crane','#98AEAB')
ggsave("winrate_crane.png",width = 4, height = 4)
clanplot('Dragon','#567C63')
ggsave("winrate_dragon.png",width = 4, height = 4)
clanplot('Lion','#AF9445')
ggsave("winrate_lion.png",width = 4, height = 4)
clanplot('Phoenix','#B47741')
ggsave("winrate_phoenix.png",width = 4, height = 4)
clanplot('Scorpion','#8C3D2E')
ggsave("winrate_scorpion.png",width = 4, height = 4)
clanplot('Unicorn','#6D5472')
ggsave("winrate_unicorn.png",width = 4, height = 4)

