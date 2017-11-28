
# This Code is for preparing bar charts for L5R tournaments.

# Clear the data at the start for a tidy environment
rm(list=ls())
# As we want to save files we're setting the directory to the same as the plot.R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Barchart for breakdown of clans in a tournament etc.
# In order of Crab, Crane, Dragon, Lion, Phoenix, Scorpion, Unicorn
tournament <- "PAX"
attendance <- c(27,35,32,31,27,44,15) 
qualifiers <- c(1,1,3,2,0,5,0) 
rate <- round(100*qualifiers/attendance)


# Setup loading packages and images

clan_data = data.frame(clan, attendance, qualifiers, rate) 

if (!require("pacman")) install.packages("pacman")
pacman::p_load(jpeg, png, ggplot2, grid, neuropsychology)
clan <- c("Crab","Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn") 
clan_palette <- c("#4C5660","#98AEAB", "#567C63", "#AF9445", "#B47741", "#8C3D2E", "#6D5472")
image <- jpeg::readJPEG("background.jpg")
crab <- png::readPNG("mon_crab.png")
crabmon <- grid::rasterGrob(crab, interpolate = T)
crane <- png::readPNG("mon_crane.png")
cranemon <- grid::rasterGrob(crane, interpolate = T)
dragon <- png::readPNG("mon_dragon.png")
dragonmon <- grid::rasterGrob(dragon, interpolate = T)
lion <- png::readPNG("mon_lion.png")
lionmon <- grid::rasterGrob(lion, interpolate = T)
phoenix <- png::readPNG("mon_phoenix.png")
phoenixmon <- grid::rasterGrob(phoenix, interpolate = T)
scorpion <- png::readPNG("mon_scorpion.png")
scorpionmon <- grid::rasterGrob(scorpion, interpolate = T)
unicorn <- png::readPNG("mon_unicorn.png")
unicornmon <- grid::rasterGrob(unicorn, interpolate = T)





## Attendance
clantitle <- paste("Imperial Advisor\n",tournament,"attendance")
titlevjust <- -max(attendance)*6
monymax <- max(attendance)/5

ggplot(clan_data, aes(clan, attendance, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust=titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face="bold")) +
  scale_fill_manual(values=clan_palette) +
  guides(fill=FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat="identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  scale_y_continuous('', limits = c(0, max(attendance) + max(attendance) / 3)) +
  scale_x_discrete('') +
  geom_text(aes(label = ifelse(attendance>0,round(attendance),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5) +
  annotation_custom(crabmon, xmin=0.7, xmax=1.3, ymin=0.2, ymax=monymax) +
  annotation_custom(cranemon, xmin=1.7, xmax=2.3, ymin=0.2, ymax=monymax) +
  annotation_custom(dragonmon, xmin=2.7, xmax=3.3, ymin=0.2, ymax=monymax) +
  annotation_custom(lionmon, xmin=3.7, xmax=4.3, ymin=0.2, ymax=monymax) +
  annotation_custom(phoenixmon, xmin=4.7, xmax=5.3, ymin=0.2, ymax=monymax) +
  annotation_custom(scorpionmon, xmin=5.7, xmax=6.3, ymin=0.2, ymax=monymax) +
  annotation_custom(unicornmon, xmin=6.7, xmax=7.3, ymin=0.2, ymax=monymax)

ggsave("attendance.png", width = 8, height = 5, units = "in")




## Qualification numbers
clantitle <- paste("Imperial Advisor\n",tournament,"qualifiers")
titlevjust <- -max(qualifiers)*3
monymax <- max(qualifiers)/5

ggplot(clan_data, aes(clan, qualifiers, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust=titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face="bold")) +
  scale_fill_manual(values=clan_palette) +
  guides(fill=FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat="identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  scale_y_continuous('', limits = c(0, max(qualifiers) + max(qualifiers) / 3)) +
  scale_x_discrete('') +
  geom_text(aes(label = ifelse(qualifiers>0,round(qualifiers),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5) +
  annotation_custom(crabmon, xmin=0.7, xmax=1.3, ymin=0.2, ymax=monymax) +
  annotation_custom(cranemon, xmin=1.7, xmax=2.3, ymin=0.2, ymax=monymax) +
  annotation_custom(dragonmon, xmin=2.7, xmax=3.3, ymin=0.2, ymax=monymax) +
  annotation_custom(lionmon, xmin=3.7, xmax=4.3, ymin=0.2, ymax=monymax) +
  annotation_custom(phoenixmon, xmin=4.7, xmax=5.3, ymin=0.2, ymax=monymax) +
  annotation_custom(scorpionmon, xmin=5.7, xmax=6.3, ymin=0.2, ymax=monymax) +
  annotation_custom(unicornmon, xmin=6.7, xmax=7.3, ymin=0.2, ymax=monymax)

ggsave("qualifiers.png", width = 8, height = 5, units = "in")




## Qualification Rate
clantitle <- paste("Imperial Advisor\n",tournament,"Qualification Rate")
titlevjust <- -max(rate)*5
monymax <- max(rate)/5

ggplot(clan_data, aes(clan, rate, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust=titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face="bold")) +
  scale_fill_manual(values=clan_palette) +
  guides(fill=FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat="identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  scale_y_continuous('', limits = c(0, max(rate) + max(rate) / 3)) +
  scale_x_discrete('') +
  geom_text(aes(label = ifelse(rate>0,paste(round(rate),'%'),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5) +
  annotation_custom(crabmon, xmin=0.7, xmax=1.3, ymin=0.2, ymax=monymax) +
  annotation_custom(cranemon, xmin=1.7, xmax=2.3, ymin=0.2, ymax=monymax) +
  annotation_custom(dragonmon, xmin=2.7, xmax=3.3, ymin=0.2, ymax=monymax) +
  annotation_custom(lionmon, xmin=3.7, xmax=4.3, ymin=0.2, ymax=monymax) +
  annotation_custom(phoenixmon, xmin=4.7, xmax=5.3, ymin=0.2, ymax=monymax) +
  annotation_custom(scorpionmon, xmin=5.7, xmax=6.3, ymin=0.2, ymax=monymax) +
  annotation_custom(unicornmon, xmin=6.7, xmax=7.3, ymin=0.2, ymax=monymax)

ggsave("qual_rate.png", width = 8, height = 5, units = "in")


# Org Chart for Single Elims

require("DiagrammeR")



# I went crazy trying to work out how to properly order the top 16.
# The solution was to not try. Check the label to see where in the order it is not the node.

# Updated for PAX

# Enter  name of Tournament
tournament <- "Pax Unplugged - Grand Kotei"

# Clan Colors
# Crab:     4C5660
# Crane:    98AEAB
# Dragon:   567C63
# Lion:     AF9445
# Phoenix:  B47741
# Scorpion: 8C3D2E
# Unicorn:  6D5472

# Enter names and color codes for top 16
name16a <-"Stephen Didion"; clan16a <-"4C5660"
name16b <-"Alex Tessier"; clan16b <-"567C63"
name16c <-"Francis Mercer"; clan16c <-"8C3D2E"
name16d <-"Alex Jacobs"; clan16d <-"567C63"
name16e <-"Timothy Wells"; clan16e <-"AF9445"
name16f <-"Kevin Becerra"; clan16f <-"567C63"
name16g <-"David Gearhart"; clan16g <-"567C63"
name16h <-"Eric Ridlon"; clan16h <-"AF9445"
name16i <-"Robert Hebert"; clan16i <-"8C3D2E"
name16j <-"Ronnie Szutu"; clan16j <-"98AEAB"
name16k <-"Tony Kwok"; clan16k <-"8C3D2E"
name16l <-"Zachary Devine"; clan16l <-"8C3D2E"
name16m <-"Kyle Wislocky"; clan16m <-"98AEAB"
name16n <-"Trevor Holmes"; clan16n <-"AF9445"
name16o <-"James Balthis"; clan16o <-"8C3D2E"
name16p <-"Edward Kim"; clan16p <-"567C63"

# Enter names and color codes for top 8
name8a <-"Stephen Didion"; clan8a <-"4C5660"
name8b <-"Francis Mercer"; clan8b <-"8C3D2E"
name8c <-"Timothy Wells"; clan8c <-"AF9445"
name8d <-"David Gearhart"; clan8d <-"567C63"
name8e <-"Ronnie Szutu"; clan8e <-"98AEAB"
name8f <-"Zachary Devine"; clan8f <-"8C3D2E"
name8g <-"Trevor Holmes"; clan8g <-"AF9445"
name8h <-"James Balthis"; clan8h <-"8C3D2E"

# Enter names and color codes for top 4
name4a <-"Stephen Didion"; clan4a <-"4C5660"
name4b <-"Timothy Wells"; clan4b <-"AF9445"
name4c <-"Zachary Devine"; clan4c <-"8C3D2E"
name4d <-"Trevor Holmes"; clan4d <-"AF9445"

# Enter names and color codes for top 2
name2a <-"Stephen Didion"; clan2a <-"4C5660"
name2b <-"Trevor Holmes"; clan2b <-"AF9445"

# Enter names and color codes for winner
name1 <-"Stephen Didion"; clan1 <-"4C5660"

x <- paste0("
            digraph boxes_and_circles {
            # a 'graph' statement
            graph [bgcolor = white, overlap = true, fontsize = 50, fontname = Arial, rankdir = LR, labelloc='t', label='Imperial Adviser - ",tournament," - Top 16']
            
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



## EOF

