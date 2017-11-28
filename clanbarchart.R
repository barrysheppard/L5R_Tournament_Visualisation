
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



## EOF

