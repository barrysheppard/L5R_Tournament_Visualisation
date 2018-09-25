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
path <- paste0("/api/v3/tournaments/", tournament_id)

raw.result <- GET(url = url, path = path)
this.raw.content <- rawToChar(raw.result$content)

tournament_players <- fromJSON(this.raw.content)


# Tidy up phase. we really only want the tournament_players and tournament data
rm(url)
rm(path)
rm(this.raw.content)
rm(raw.result)