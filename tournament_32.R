# This code produces a chart of the Single Elims in a tournament

# install.packages("DiagrammeR")
require("DiagrammeR")

# I went crazy trying to work out how to properly order the top 16.
# The solution was to not try. Check the label to see where in the order it is not the node.

# Updated for PAX

# Enter  name of Tournament
tournament <- "Madrid Grand Kotei 2018"

# Clan Colors
crab <- '4C5660'
crane <- '98AEAB'
dragon <- '567C63'
lion <- 'AF9445'
phoenix <- 'B47741'
scorpion <- '8C3D2E'
unicorn <- '6D5472'
neutral <- '888888'




# Players in Seed order
seed01 <- "Shadowblade"
clan01 <- lion
seed02 <- "Jakub Irzyk"
clan02 <- scorpion
seed03 <- "Jose Luis SS"
clan03 <- phoenix
seed04 <- "Pablo Tobias"
clan04 <- scorpion
seed05 <- "Mario B A"
clan05 <- neutral
seed06 <- "Cesar Jiminez"
clan06 <- neutral
seed07 <- "Gustavo C C"
clan07 <- neutral
seed08 <- "Aioria"
clan08 <- neutral
seed09 <- "Marc C R"
clan09 <- neutral
seed10 <- "Roberto C R"
clan10 <- neutral
seed11 <- "Pablo Pintor"
clan11 <- neutral
seed12 <- "Marcos Yerga"
clan12 <- neutral
seed13 <- "See13"
clan13 <- neutral
seed14 <- "See14"
clan14 <- neutral
seed15 <- "See15"
clan15 <- neutral
seed16 <- "Antonio Garrido"
clan16 <- neutral



# Enter names and color codes for top 16
name16a <- "Shadowblade"; clan16a <- lion
name16b <- "Antonio Garrido"; clan16b <- scorpion
name16c <- "Aioria"; clan16c <- crane
name16d <- "Marc C R"; clan16d <- dragon
name16e <- "Pablo Tobias"; clan16e <- scorpion
name16f <- "Javier G P"; clan16f <- crane
name16g <- "Mario B A"; clan16g <- scorpion
name16h <- "Diego Ferandez"; clan16h <- scorpion
name16i <- "Jakub Irzyk"; clan16i <- clan02
name16j <- "Alfonso Domenech"; clan16j <- phoenix
name16k <- "Xavier M"; clan16k <- scorpion
name16l <- "Roberto C P"; clan16l <- dragon
name16m <- "Jose Luis S S"; clan16m <- phoenix
name16n <- "Santiago Orte"; clan16n <- scorpion
name16o <- "Cesar Jiminez"; clan16o <- scorpion
name16p <- "Alain L"; clan16p <- crane


# Enter names and color codes for top 8
name8a <- name16a; clan8a <- clan16a
name8b <- name16d; clan8b <- clan16d
name8c <- name16e; clan8c <- clan16e
name8d <- name16g; clan8d <- clan16g
name8e <- name16i; clan8e <- clan16i
name8f <- name16k; clan8f <- clan16k
name8g <- name16m; clan8g <- clan16m
name8h <- name16o; clan8h <- clan16o

# Blank out
# Enter names and color codes for top 8
name8a <- ""; clan8a <- neutral
name8b <- ""; clan8b <- neutral
name8c <- ""; clan8c <- neutral
name8d <- ""; clan8d <- neutral
name8e <- ""; clan8e <- neutral
name8f <- ""; clan8f <- neutral
name8g <- ""; clan8g <- neutral
name8h <- ""; clan8h <- neutral


name4a <- ""; clan4a <- neutral
name8b <- ""; clan8b <- neutral
name8c <- ""; clan8c <- neutral
name4b <- ""; clan4b <- neutral
name4c <- ""; clan4c <- neutral
name8f <- ""; clan8f <- neutral
name4d <- ""; clan4d <- neutral
name8h <- ""; clan8h <- neutral


# Enter names and color codes for top 4
name4a <- name8a; clan4a <- clan8a
name4b <- name8d; clan4b <- clan8d
name4c <- name8f; clan4c <- clan8f
name4d <- name8g; clan4d <- clan8g 

# Enter names and color codes for top 2

#name2a <- ""; clan2a <- neutral
#name2b <- ""; clan2b <- neutral

name2a <- name4b; clan2a <- clan4b
name2b <- name4d; clan2b <- clan4d

# Enter names and color codes for winner
name1 <- name2b; clan1 <- clan2b
#name1 <- ""; clan1 <- neutral

x <- paste0("
            digraph boxes_and_circles {
            # a 'graph' statement
            graph [bgcolor = white, overlap = true, fontsize = 50, fontname = Arial, rankdir = LR, labelloc='t', label='IA - ",tournament," - Top 16']
            
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
