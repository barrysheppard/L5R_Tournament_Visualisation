
# This Code is for preparing bar charts for L5R tournaments.

# Commented out for fear of another user murdering us
# Clear the data at the start for a tidy environment
# rm(list=ls())
# As we want to save files we're setting the directory to the same as the plot.R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

if (!require("pacman")) install.packages("pacman")
pacman::p_load(jpeg, png, ggplot2, grid, neuropsychology, shadowtext, magick)

# this is the load from Lotus
 
# User defined variables for the load from Lotus Pavilion
tournament_id <- 5163
tournament <- "Las Vegas Open"

# Load from Lotus Pavilion if possible
# Returns tournament_players
source("load_tournament.R", print.eval = TRUE)

# This next step gets attendance for each clan
Crab <- length(which(tournament_players$clan == 'Crab'))
Crane <- length(which(tournament_players$clan == 'Crane'))
Dragon <- length(which(tournament_players$clan == 'Dragon'))
Lion <- length(which(tournament_players$clan == 'Lion'))
Phoenix <- length(which(tournament_players$clan == 'Phoenix'))
Scorpion <- length(which(tournament_players$clan == 'Scorpion'))
Unicorn <- length(which(tournament_players$clan == 'Unicorn'))
attendance <- c(Crab, Crane, Dragon, Lion, Phoenix, Scorpion, Unicorn)

# Next we get those who qualified.
# For this we need to specify the number of points required.
Crab <- length(which(tournament_players$clan == 'Crab' & tournament_players$topx < 256))
Crane <- length(which(tournament_players$clan == 'Crane' & tournament_players$topx < 256))
Dragon <- length(which(tournament_players$clan == 'Dragon' & tournament_players$topx < 256))
Lion <- length(which(tournament_players$clan == 'Lion' & tournament_players$topx < 256))
Phoenix <- length(which(tournament_players$clan == 'Phoenix' & tournament_players$topx < 256))
Scorpion <- length(which(tournament_players$clan == 'Scorpion' & tournament_players$topx < 256))
Unicorn <- length(which(tournament_players$clan == 'Unicorn' & tournament_players$topx < 256))
qualifiers <- c(Crab, Crane, Dragon, Lion, Phoenix, Scorpion, Unicorn)

# Barchart for breakdown of clans in a tournament etc.
# In order of Crab, Crane, Dragon, Lion, Phoenix, Scorpion, Unicorn

# If no Lotus Pavilion then manually enter attendance
# attendance <- c(8,9,5,3,8,9,9)
# qualifiers <- c(2,3,2,2,1,4,2) 
rate <- round(100*qualifiers/attendance)
backgroundimage <- "background.jpg"


# Saving to dataframe
clan <- c("Crab","Crane", "Dragon", "Lion", "Phoenix", "Scorpion", "Unicorn") 
clan_data = data.frame(clan, attendance, qualifiers, rate) 

# Setup loading packages and images

clan_palette <- c("#4C5660","#98AEAB", "#567C63", "#AF9445", "#B47741", "#8C3D2E", "#6D5472")
image <- jpeg::readJPEG(backgroundimage)
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
clantitle <- paste(tournament,"\nAttendance")
titlevjust <- -8
monymax <- max(attendance)/4

# Plot the chart

ggplot(clan_data, aes(clan, attendance, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust = titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face = "bold")) +
  scale_fill_manual(values = clan_palette) +
  guides(fill = FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  annotation_custom(crabmon, xmin = 0.7, xmax = 1.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(cranemon, xmin = 1.7, xmax = 2.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(dragonmon, xmin = 2.7, xmax = 3.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(lionmon, xmin = 3.7, xmax = 4.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(phoenixmon, xmin = 4.7, xmax = 5.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(scorpionmon, xmin = 5.7, xmax = 6.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(unicornmon, xmin = 6.7, xmax = 7.3, ymin = 0.2, ymax = monymax) +
  scale_y_continuous('', limits = c(0, max(attendance) + max(attendance) / 3)) +
  scale_x_discrete('') +
  geom_shadowtext(aes(label = ifelse(attendance > 0,round(attendance),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5)

file_name <- paste0(tournament_id, "_attendance.png")
ggsave(file_name, width = 8, height = 5, units = "in")

# Added section to crop and resize images
raw_image <- image_read(file_name)
cropped_image <- image_crop(raw_image, "2180x1141+205+160")
final_image <- image_scale(cropped_image, "500")
image_write(final_image, path = file_name, format = "png")


## Qualification numbers
clantitle <- paste(tournament,"\nQualifiers")
titlevjust <- -8
monymax <- max(qualifiers)/4

ggplot(clan_data, aes(clan, qualifiers, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust = titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face = "bold")) +
  scale_fill_manual(values = clan_palette) +
  guides(fill = FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  scale_y_continuous('', limits = c(0, max(qualifiers) + max(qualifiers) / 3)) +
  scale_x_discrete('') +
  annotation_custom(crabmon, xmin = 0.7, xmax = 1.3, ymin = 0, ymax = monymax) +
  annotation_custom(cranemon, xmin = 1.7, xmax = 2.3, ymin = 0., ymax = monymax) +
  annotation_custom(dragonmon, xmin = 2.7, xmax = 3.3, ymin = 0, ymax = monymax) +
  annotation_custom(lionmon, xmin = 3.7, xmax = 4.3, ymin = 0, ymax = monymax) +
  annotation_custom(phoenixmon, xmin = 4.7, xmax = 5.3, ymin = 0, ymax = monymax) +
  annotation_custom(scorpionmon, xmin = 5.7, xmax = 6.3, ymin = 0, ymax = monymax) +
  annotation_custom(unicornmon, xmin = 6.7, xmax = 7.3, ymin = 0, ymax = monymax) +
  geom_shadowtext(aes(label = ifelse(qualifiers > 0,round(qualifiers),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5)

file_name <- paste0(tournament_id, "_qualifiers.png")
ggsave(file_name, width = 8, height = 5, units = "in")

# Added section to crop and resize images
raw_image <- image_read(file_name)
cropped_image <- image_crop(raw_image, "2180x1141+205+160")
final_image <- image_scale(cropped_image, "500")
image_write(final_image, path = file_name, format = "png")


## Qualification Rate

clantitle <- paste(tournament,"\nQualification Rate")
titlevjust <- -8
monymax <- max(rate)/4

ggplot(clan_data, aes(clan, rate, fill = clan)) +
  theme_neuropsychology() +
  ggtitle(clantitle) +
  theme(plot.title = element_text(hjust = 0.5, vjust = titlevjust, margin = margin(t = 10, b = -20), colour = "#DFD8C1", size = rel(2), face = "bold")) +
  scale_fill_manual(values = clan_palette) +
  guides(fill = FALSE) + 
  annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", position = "dodge", width = .75, colour = 'white', alpha = 0.8) +
  scale_y_continuous('', limits = c(0, max(rate) + max(rate) / 3)) +
  scale_x_discrete('') +
  annotation_custom(crabmon, xmin = 0.7, xmax = 1.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(cranemon, xmin = 1.7, xmax = 2.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(dragonmon, xmin = 2.7, xmax = 3.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(lionmon, xmin = 3.7, xmax = 4.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(phoenixmon, xmin = 4.7, xmax = 5.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(scorpionmon, xmin = 5.7, xmax = 6.3, ymin = 0.2, ymax = monymax) +
  annotation_custom(unicornmon, xmin = 6.7, xmax = 7.3, ymin = 0.2, ymax = monymax) +
  geom_shadowtext(aes(label = ifelse(rate > 0,paste(round(rate),'%', sep=''),''), ymax = 0), size = 7, fontface = 2, colour = 'white', hjust = 0.5, vjust = 1.5)

file_name <- paste0(tournament_id, "_qual_rate.png")
ggsave(file_name, width = 8, height = 5, units = "in")

# Added section to crop and resize images
raw_image <- image_read(file_name)
cropped_image <- image_crop(raw_image, "2180x1141+205+160")
final_image <- image_scale(cropped_image, "500")
image_write(final_image, path = file_name, format = "png")

## EOF

