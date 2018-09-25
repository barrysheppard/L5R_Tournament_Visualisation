# Load from Lotus Pavilion

# Starting code

if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2", "dplyr", "tidyr", "readr", "purrr", "tibble", "psych", "ggpubr", "httr", "jsonlite", "lubridate")


# This contacts the Lotus Pavilion website and downloads every game
# after the start date through the API
# The API  is https://thelotuspavilion.com/static/apidoc/v3.html
# Due to changes in the API only 50 results appear per page
# So we need to cycle through until we don't get a result anymore

options(stringsAsFactors = FALSE)
url <- "http://thelotuspavilion.com"
page <- 1
finished <- 0
path <- paste0("/api/v3/games?after=", startdate, "&tournament_id=", tournament_id ,"&page=")

while (finished != 1) {
  path1 <- paste0(path, page)
  raw.result <- GET(url = url, path = path1)
  this.raw.content <- rawToChar(raw.result$content)
    if (this.raw.content != "[]") {
      if (page == 1) {
        all_games <- fromJSON(this.raw.content)
      } else {
        all_games <- rbind(all_games, fromJSON(this.raw.content))
      }
    }
    else {
      finished <- 1
    }
  page <- page + 1
}


# remove cases where there is na, this includes Byes
games <- all_games[complete.cases(all_games), ]

# Date Range
# games$tournament_date <- as.Date(games$tournament_date,"%y-%m-%d")
games <- games[games$tournament_date >= startdate & games$tournament_date <= enddate, ]

# add winner
games$winner <- if (games$p1_points > games$p2_points) games$p1_clan else games$p2_clan

