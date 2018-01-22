
# This code takes data from the website TheLotusPavilion.com which includes games played
# Results are tallied to work out the win rate for each clan versus every other clan
# Barcharts are produced and saved

# Starting code
rm(list=ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","dplyr","tidyr","readr","purrr","tibble","psych","ggpubr","httr","jsonlite","lubridate")


# User defined variables
startdate <- as.Date('2017-12-22')
enddate <- Sys.Date()


# This contacts the Lotus Pavilion website and downloads every game after the start date through the API
options(stringsAsFactors = FALSE)
url  <- "http://thelotuspavilion.com"
path <- paste0("/api/v2/json/games?after=",startdate)
raw.result <- GET(url = url, path = path)
this.raw.content <- rawToChar(raw.result$content)
all_games <- fromJSON(this.raw.content)


# remove cases where there is na, this includes Byes
games <- all_games[complete.cases(all_games),]

# Date Range
# games$tournament_date <- as.Date(games$tournament_date,"%y-%m-%d")
games <- games[games$tournament_date >= startdate & games$tournament_date <= enddate,]

# add winner
games$winner <- if(games$p1_points > games$p2_points) games$p1_clan else games$p2_clan


# This function takes in two clans returning the win rate of the first one
WinRate <- function(x,y) {
  total <- nrow(with(games, games[(games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x),]))
  wins <- nrow(with(games, games[((games$p1_clan==x & games$p2_clan==y) | (games$p1_clan==y & games$p2_clan==x)) & games$winner==x,]))
  if(wins==total) 50 else 100 * wins / total
}

# Clan Palette
clan_palette <- c("#4C5660","#98AEAB", "#567C63", "#AF9445", "#B47741", "#8C3D2E", "#6D5472")

# This function takes in a clan name and a clan color and returns a chart
clanplot <- function(x,clancolor){
  # Create a frame
  clan <- c('Crab','Crane','Dragon','Lion','Phoenix','Scorpion','Unicorn','Crab','Crane','Dragon','Lion','Phoenix','Scorpion','Unicorn')
  rate <- c(WinRate(x,'Crab'),WinRate(x,'Crane'),WinRate(x,'Dragon'),WinRate(x,'Lion'), WinRate(x,'Phoenix'), WinRate(x,'Scorpion'), WinRate(x,'Unicorn'),WinRate('Crab',x),WinRate('Crane',x),WinRate('Dragon',x),WinRate('Lion',x), WinRate('Phoenix',x), WinRate('Scorpion',x), WinRate('Unicorn',x))
  result <- c('Win','Win','Win','Win','Win','Win','Win','Loss','Loss','Loss','Loss','Loss','Loss','Loss')
  windata <- data.frame(clan, rate, result)
  totalgames <- nrow(with(games, games[(games$p1_clan==x | games$p2_clan==x),]))
    
  # Chart it all
  g <- ggplot(windata, aes(clan, rate))
  g +geom_bar(stat = "identity", aes(fill = clan)) +
    scale_x_discrete(limits = c('Unicorn','Scorpion','Phoenix','Lion','Dragon','Crane','Crab')) +
    scale_fill_manual(values = clan_palette) +
    geom_bar(colour="black",stat = "identity", fill=clancolor, aes(alpha = result)) +
    scale_alpha_manual(values=c(0,1),
                       name="Win Rate",
                       breaks=c("Win", "Loss"),         # can use to set order
                       labels=c("Win", "Loss")) +
    theme_minimal() +
    xlab("") +
    ylab(paste0(startdate," to ", enddate, ", ", totalgames, " games in total")) +
    ggtitle(paste0(x," Clan Win Rate"))+
    theme(legend.position="none") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x=element_blank()) +
    theme(axis.text.y=element_blank()) +
    geom_text(aes(label=paste0(round(rate),'%')), position=position_stack(vjust=0.5), color="white") +
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

