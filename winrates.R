
# This code takes data from the website TheLotusPavilion.com which includes games played
# Results are tallied to work out the win rate for each clan versus every other clan
# Barcharts are produced and saved


# User defined variables for the load from Lotus Pavilion
startdate <- as.Date("2018-01-01")
enddate <- Sys.Date()
tournament_id <- "1355"

# Load from Lotus
source("load_from_lotus.R", print.eval = TRUE)

# This function takes in two clans returning the win rate of the first one
WinRate <- function(x, y) {
  total <- nrow(with(games, games[(games$p1_clan == x & games$p2_clan == y) | (games$p1_clan == y & games$p2_clan == x), ]))
  wins <- nrow(with(games, games[((games$p1_clan == x & games$p2_clan == y) | (games$p1_clan == y & games$p2_clan == x)) & games$winner == x, ]))
  if (wins == total) 50 else 100 * wins / total
}

TotalPairs <- function(x, y) {
  # Take in the two clans x and y. Returns the total number of games with that pairing
  nrow(with(games, games[(games$p1_clan == x & games$p2_clan == y) | (games$p1_clan == y & games$p2_clan == x), ]))
}

# Clan Palette
clan_palette <- c("#4C5660", "#98AEAB", "#567C63", "#AF9445", "#B47741", "#8C3D2E", "#6D5472")

# This function takes in a clan name and a clan color and returns a chart
clanplot <- function(x, clancolor) {
  # Create a frame
  clan <- c("Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn", "Crab", "Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn")
  rate <- c(WinRate(x, "Crab"), WinRate(x, "Crane"), WinRate(x, "Dragon"), WinRate(x, "Lion"), WinRate(x, "Phoenix"), WinRate(x, "Scorpion"), WinRate(x, "Unicorn"), WinRate("Crab", x), WinRate("Crane", x), WinRate("Dragon", x), WinRate("Lion", x), WinRate("Phoenix", x), WinRate("Scorpion", x), WinRate("Unicorn", x))
  clanpairs <- c(TotalPairs(x, "Crab"), TotalPairs(x, "Crane"), TotalPairs(x, "Dragon"), TotalPairs(x, "Lion"), TotalPairs(x, "Phoenix"), TotalPairs(x, "Scorpion"), TotalPairs(x, "Unicorn"))
  result <- c("Win", "Win", "Win", "Win", "Win", "Win", "Win", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss", "Loss")
  windata <- data.frame(clan, rate, result)
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
    ylab(paste0(startdate, " to ", enddate, ", ", totalgames, " games in total")) +
    ggtitle(paste0(x, " Clan Win Rate")) +
    theme(legend.position = "none") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x = element_blank()) +
#    theme(axis.text.y = element_blank()) +
    geom_text(aes(label = paste0(round(rate), "%")), position = position_stack(vjust = 0.5), color = "white") +
    coord_flip()
}



clanplot("Crab", "#4C5660")
ggsave("winrate_crab.png", width = 4, height = 4)
clanplot("Crane", "#98AEAB")
ggsave("winrate_crane.png", width = 4, height = 4)
clanplot("Dragon", "#567C63")
ggsave("winrate_dragon.png", width = 4, height = 4)
clanplot("Lion", "#AF9445")
ggsave("winrate_lion.png", width = 4, height = 4)
clanplot("Phoenix", "#B47741")
ggsave("winrate_phoenix.png", width = 4, height = 4)
clanplot("Scorpion", "#8C3D2E")
ggsave("winrate_scorpion.png", width = 4, height = 4)
clanplot("Unicorn", "#6D5472")
ggsave("winrate_unicorn.png", width = 4, height = 4)
