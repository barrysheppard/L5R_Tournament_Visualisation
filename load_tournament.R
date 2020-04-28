# Load from Lotus Pavilion


# Starting code

if (!require("pacman")) install.packages("pacman")
pacman::p_load("ggplot2","dplyr","tidyr","readr","purrr","tibble","psych","ggpubr","httr","jsonlite","lubridate", "gtools", "gridExtra", "png", "grid")


# This contacts the Lotus Pavilion website and downloads every game
# after the start date through the API
# The API  is https://thelotuspavilion.com/static/apidoc/v3.html
# Due to changes in the API only 50 results appear per page
# So we need to cycle through until we don't get a result anymore


options(stringsAsFactors = FALSE)
url <- "http://thelotuspavilion.com"
path <- paste0("/api/v3/tournaments/", tournament_id)
raw.result <- GET(url = url, path = path)
this.raw.content <- rawToChar(raw.result$content)
tournament_players <- fromJSON(this.raw.content)

path <- paste0("/api/v3/tournaments?tournament_id=", tournament_id)
raw.result <- GET(url = url, path = path)
this.raw.content <- rawToChar(raw.result$content)
tournament_details <- fromJSON(this.raw.content)
tournament_name <- tournament_details$tournament_name


url  <- "http://thelotuspavilion.com"
page <- 1
finished <- 0
#path <- paste0("/api/v3/games?after=", startdate, "tournament_id=",tournament_id,"&page=")
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
      new_games <- fromJSON(this.raw.content)
      all_games <- smartbind(all_games, fromJSON(this.raw.content))
      
    }
  }
  page <- page + 1
}



# Tidy up phase. we really only want the tournament_players and tournament data
rm(url)
rm(path)
rm(this.raw.content)
rm(raw.result)

