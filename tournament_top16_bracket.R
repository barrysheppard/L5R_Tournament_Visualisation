# This code produces a chart of the Single Elims in a tournament

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
if (!require("pacman")) install.packages("pacman")
pacman::p_load("DiagrammeR","DiagrammeRsvg","magrittr","rsvg")


# I went crazy trying to work out how to properly order the top 16.
# The solution was to not try. Check the label to see where in the order it is not the node.


# User defined variables for the load from Lotus Pavilion
tournament_id <- 5419

file_name <- paste0(tournament_id, "_top_16.png")


# As we want to save files we're setting the directory to the same as the plot.R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Load from Lotus Pavilion if possible
# Returns tournament_players
source("load_tournament.R", print.eval = TRUE)
# Change if the name is too long
tournament <- tournament_name

# Clan Colors
crab <- '4C5660'
crane <- '98AEAB'
dragon <- '567C63'
lion <- 'AF9445'
phoenix <- 'B47741'
scorpion <- '8C3D2E'
unicorn <- '6D5472'
neutral <- '888888'

clan_color <- function(clan_name) {
  if (clan_name == "Crab") {color <- crab}
  else if (clan_name == "Crane") {color <- crane}
  else if (clan_name == "Dragon") {color <- dragon}
  else if (clan_name == "Lion") {color <- lion}
  else if (clan_name == "Phoenix") {color <- phoenix}
  else if (clan_name == "Scorpion") {color <- scorpion}
  else if (clan_name == "Unicorn") {color <- unicorn}
  else {color <- neutral}
  color
}


player_name <- function(topx, table, player) {
  player1 <- all_games$p1_name[all_games$topx==topx & all_games$table_number==table]
  player2 <- all_games$p2_name[all_games$topx==topx & all_games$table_number==table]
  if (player == 1) {player_name <- player1}
  else {player_name <- player2}
  # remove any weird characters
  player_name <- str_replace_all(player_name, "[[:punct:]]", " ")
  player_name
}

player_clan_color <- function(topx, table, player) {
  player1 <- all_games$p1_clan[all_games$topx == topx & all_games$table_number == table]
  player2 <- all_games$p2_clan[all_games$topx == topx & all_games$table_number == table]
  if (player == 1) {
    player_clan <- player1
  } else {
    player_clan <- player2
  }
  result <- clan_color(player_clan)
  print(player1)
  print(player2)
  print(result)
  
}



# Round 16 (topx, table, player)
name16a <- player_name(16, 1, 1); clan16a <- player_clan_color(16, 1, 1)
name16b <- player_name(16, 1, 2); clan16b <- player_clan_color(16, 1, 2)
name16c <- player_name(16, 8, 1); clan16c <- player_clan_color(16, 8, 1)
name16d <- player_name(16, 8, 2); clan16d <- player_clan_color(16, 8, 2)
name16e <- player_name(16, 4, 1); clan16e <- player_clan_color(16, 4, 1)
name16f <- player_name(16, 4, 2); clan16f <- player_clan_color(16, 4, 2)
name16g <- player_name(16, 5, 1); clan16g <- player_clan_color(16, 5, 1)
name16h <- player_name(16, 5, 2); clan16h <- player_clan_color(16, 5, 2)
name16i <- player_name(16, 2, 1); clan16i <- player_clan_color(16, 2, 1)
name16j <- player_name(16, 2, 2); clan16j <- player_clan_color(16, 2, 2)
name16k <- player_name(16, 7, 1); clan16k <- player_clan_color(16, 7, 1)
name16l <- player_name(16, 7, 2); clan16l <- player_clan_color(16, 7, 2)
name16m <- player_name(16, 3, 1); clan16m <- player_clan_color(16, 3, 1)
name16n <- player_name(16, 3, 2); clan16n <- player_clan_color(16, 3, 2)
name16o <- player_name(16, 6, 1); clan16o <- player_clan_color(16, 6, 1)
name16p <- player_name(16, 6, 2); clan16p <- player_clan_color(16, 6, 2)

# Top 8
name8a <- player_name(8, 1, 1); clan8a <- player_clan_color(8, 1, 1)
name8b <- player_name(8, 1, 2); clan8b <- player_clan_color(8, 1, 2)
name8c <- player_name(8, 4, 1); clan8c <- player_clan_color(8, 4, 1)
name8d <- player_name(8, 4, 2); clan8d <- player_clan_color(8, 4, 2)
name8e <- player_name(8, 2, 1); clan8e <- player_clan_color(8, 2, 1)
name8f <- player_name(8, 2, 2); clan8f <- player_clan_color(8, 2, 2)
name8g <- player_name(8, 3, 1); clan8g <- player_clan_color(8, 3, 1)
name8h <- player_name(8, 3, 2); clan8h <- player_clan_color(8, 3, 2)

# top 4
name4a <- player_name(4, 1, 1); clan4a <- player_clan_color(4, 1, 1)
name4b <- player_name(4, 1, 2); clan4b <- player_clan_color(4, 1, 2)
name4c <- player_name(4, 2, 1); clan4c <- player_clan_color(4, 2, 1)
name4d <- player_name(4, 2, 2); clan4d <- player_clan_color(4, 2, 2)

# top 2
name2a <- player_name(2, 1, 1); clan2a <- player_clan_color(2, 1, 1)
name2b <- player_name(2, 1, 2); clan2b <- player_clan_color(2, 1, 2)

# Winner
name1 <- tournament_players$player_name[tournament_players$topx == 1]
clan1 <- clan_color(tournament_players$clan[tournament_players$topx == 1])

# name1 <- ""; clan1 <- neutral



x <- paste0("
            digraph boxes_and_circles {
            # a 'graph' statement
            graph [bgcolor = white, overlap = true, fontsize = 50, fontname = Arial, rankdir = LR, labelloc='t', label='Meta Check - ",tournament,"']
            
            # several 'node' statements
            node [	shape = box,
            fixedsize = true,
            style = filled,
            width = 4,
            height = 0.5,
            fontsize = 18
            fontname = Arial]
            Top16a [label='",name16i,"' fillcolor = '#",clan16i,"' fontcolor = white];
            Top16b [label='",name16j,"' fillcolor = '#",clan16j,"' fontcolor = white];
            Top16c [label='",name16k,"' fillcolor = '#",clan16k,"' fontcolor = white];
            Top16d [label='",name16l,"' fillcolor = '#",clan16l,"' fontcolor = white];
            Top16e [label='",name16o,"' fillcolor = '#",clan16o,"' fontcolor = white];
            Top16f [label='",name16p,"' fillcolor = '#",clan16p,"' fontcolor = white];
            Top16g [label='",name16m,"' fillcolor = '#",clan16m,"' fontcolor = white];
            Top16h [label='",name16n,"' fillcolor = '#",clan16n,"' fontcolor = white];
            Top16i [label='",name16a,"' fillcolor = '#",clan16a,"' fontcolor = white];
            Top16j [label='",name16b,"' fillcolor = '#",clan16b,"' fontcolor = white];
            Top16k [label='",name16c,"' fillcolor = '#",clan16c,"' fontcolor = white];
            Top16l [label='",name16d,"' fillcolor = '#",clan16d,"' fontcolor = white];
            Top16m [label='",name16e,"' fillcolor = '#",clan16e,"' fontcolor = white];
            Top16n [label='",name16f,"' fillcolor = '#",clan16f,"' fontcolor = white];
            Top16o [label='",name16g,"' fillcolor = '#",clan16g,"' fontcolor = white];
            Top16p [label='",name16h,"' fillcolor = '#",clan16h,"' fontcolor = white];
            
            node [	shape = box,
            fixedsize = true,
            style = filled,
            width = 4,
            height = 1,
            fontsize = 22
            fontname = Arial]
            Top8a [label='",name8e,"' fillcolor = '#",clan8e,"' fontcolor = white];
            Top8b [label='",name8f,"' fillcolor = '#",clan8f,"' fontcolor = white];
            Top8c [label='",name8h,"' fillcolor = '#",clan8h,"' fontcolor = white];
            Top8d [label='",name8g,"' fillcolor = '#",clan8g,"' fontcolor = white];
            Top8e [label='",name8a,"' fillcolor = '#",clan8a,"' fontcolor = white];
            Top8f [label='",name8b,"' fillcolor = '#",clan8b,"' fontcolor = white];
            Top8g [label='",name8c,"' fillcolor = '#",clan8c,"' fontcolor = white];
            Top8h [label='",name8d,"' fillcolor = '#",clan8d,"' fontcolor = white];
            
            node [	shape = box,
            fixedsize = true,
            style = filled,
            width = 4,
            height = 2,
            fontsize = 26
            fontname = Arial]
            Top4a [label='",name4c,"' fillcolor = '#",clan4c,"' fontcolor = white];
            Top4b [label='",name4d,"' fillcolor = '#",clan4d,"' fontcolor = white];
            Top4c [label='",name4a,"' fillcolor = '#",clan4a,"' fontcolor = white];
            Top4d [label='",name4b,"' fillcolor = '#",clan4b,"' fontcolor = white];
            Top2a [label='",name2b,"' fillcolor = '#",clan2b,"' fontcolor = white];
            Top2b [label='",name2a,"' fillcolor = '#",clan2a,"' fontcolor = white];
            
            
            node [	shape = box,
            fixedsize = true,
            style = filled,
            width = 4,
            height = 3,
            fontsize = 30
            fontname = Arial]
            Top1 [label='",name1,"' fillcolor = '#",clan1,"' fontcolor = white];
            
            # several 'edge' statements
            Top16a->Top8a Top16b->Top8a Top16c->Top8b Top16d->Top8b Top16e->Top8c Top16f->Top8c
            Top16g->Top8d Top16h->Top8d Top16i->Top8e Top16j->Top8e Top16k->Top8f Top16l->Top8f
            Top16m->Top8g Top16n->Top8g Top16o->Top8h Top16p->Top8h
            Top8a->Top4a Top8b->Top4a Top8c->Top4b Top8d->Top4b Top8e->Top4c Top8f->Top4c
            Top8g->Top4d Top8h->Top4d Top4a->Top2a Top4b->Top2a Top4d->Top2b Top4c->Top2b
            Top2a->Top1 Top2b->Top1
            
            }
            ")
grViz(x)
grViz(x) %>%
  export_svg %>% charToRaw %>% rsvg_png(file_name)
